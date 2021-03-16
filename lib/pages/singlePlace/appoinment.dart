import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_store/functions/place_modle.dart';
import 'dart:async';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:my_store/pages/home/home.dart';
import 'package:sizer/sizer.dart';

import 'package:page_transition/page_transition.dart';
import 'dart:convert';
import 'package:select_dialog/select_dialog.dart';
import 'package:my_store/config.dart';
import 'package:http/http.dart' as http;
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:my_store/functions/localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'dart:async' show Future, Timer;




import 'package:shimmer/shimmer.dart';

import '../../helper.dart';
class Appoinment extends StatefulWidget {
  var cats;
  var data ;
  var days;
  Appoinment(this.cats,this.data,this.days);
  @override
  _AppoinmentState createState() => _AppoinmentState();
}

class _AppoinmentState extends State<Appoinment> {
  final TextEditingController _phoneControl = new TextEditingController();
  final TextEditingController _nameControl = new TextEditingController();
  List days = [];
  bool check= false ;
  bool load = true ;
  Future<List> fetchCats() async {

    final response = await http
        .get(Config.url + 'place/id/'+widget.cats.id.toString());
    setState(() {

      days = jsonDecode(response.body)["data"]["days"];
      print(days);
      load = false ;

      //   print(cities);
    });
  }
  // Use the compute function to run parseProducts in a separate isolate.

  bool _isload = false;
  final double circleRadius = 110.0;
  final double circleBorderWidth = 8.0;


  //////////////set data to database//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  set_data() async {
    print(widget.days);
    try {
      if (_nameControl.text.trim().isEmpty ||
          _phoneControl.text.trim().isEmpty) {
        Fluttertoast.showToast(
          msg: AppLocalizations.of(context).translate('loginPage', 'complete'),
          backgroundColor: Theme.of(context).textTheme.headline6.color,
          textColor: Theme.of(context).appBarTheme.color,
        );
      } else if (_phoneControl.text.length < 8) {
        Fluttertoast.showToast(
          msg: AppLocalizations.of(context)
              .translate('loginPage', 'phone_error'),
          backgroundColor: Theme.of(context).textTheme.headline6.color,
          textColor: Theme.of(context).appBarTheme.color,
        );
      } else if (_nameControl.text.length < 4 ||
          _nameControl.text.length > 30) {
        Fluttertoast.showToast(
          msg:
          "الاسم من 4 الي 30 حرف",
          backgroundColor: Theme.of(context).textTheme.headline6.color,
          textColor: Theme.of(context).appBarTheme.color,
        );
      } else {
        if (this.mounted) {
          setState(() {
            _isload = true;
          });
        }
        print(widget.cats.id);
        print(widget.days["id"]);
        final response = await http
            .post(Config.url + "add_new_booking", headers: {
          "Accept": "application/json"
        }, body: {
              "payment_method":"cash",
          "phone": _phoneControl.text,
          "date": widget.days["date"].toString(),
          "start": widget.days["start"].toString(),
          "end": widget.days["end"].toString(),

          "name": _nameControl.text,
          "place_id": widget.cats.id.toString(),
          "address": widget.cats.address.toString(),
          "place_name": widget.cats.name.toString(),
          "img": widget.cats.imgFullPath.toString(),
          "job": widget.cats.jobTitle.toString(),
          "user_id":widget.data["id"].toString(),
          "token":widget.data["token"].toString(),
          "appointment_id":widget.days["id"].toString()
        });

        final _formKey = GlobalKey<FormState>();

        var prif = SharedPreferences.getInstance();

        final data = jsonDecode(response.body);
print(data);

        if (data["status"] == 201) {
          showSimpleNotification(Text("لديك موعد بالفعل في هذا اليوم ", style: TextStyle(fontSize: 12.0.sp,fontFamily: "Cairo"),),
              background: Colors.red);
          setState(() {
            _isload = false;
          });

        }
        else{
          if (data["status"] == 200) {


            showSimpleNotification(Text("تم حجز الموعد بنجاح ", style: TextStyle(fontSize: 12.0.sp,fontFamily: "Cairo"),),
                background: Colors.green);



            Timer(Duration(seconds:3), () {
              // 5s over, navigate to a new page
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child:Home(1)));
            });

          }
          else {
            Fluttertoast.showToast(
              msg: 'خطأ غير متوقع اغلق التطبيق ثم اعد فتحة او تحدث مع الدعم الفني',
              backgroundColor: Theme.of(context).textTheme.headline6.color,
              textColor: Theme.of(context).appBarTheme.color,
            );
            //01155556624
            if (this.mounted) {
              setState(() {
                _isload = false;
              });
            }
          }
        }

        // _showDialog (data["state"],m);

      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context).translate('loginPage', 'no_net'),
        backgroundColor: Theme.of(context).textTheme.headline6.color,
        textColor: Theme.of(context).appBarTheme.color,
      );
    }
  }

  ///end ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  @override
  void initState() {
    fetchCats();
    _nameControl.text = widget.data["name"] ;
    _phoneControl.text = widget.data["mobile"] ;


    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: Text(
          "تأكيد الحجز ",
          style: TextStyle(
            fontFamily: 'Cairo',
            color: Colors.white,
            fontSize: width/24,
            letterSpacing: 1.7,
            fontWeight: FontWeight.bold,
          ),
        ),
        titleSpacing: 0.0,
      ),
      body:
      Container(

        padding:EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: ListView(
          children: [
            Stack(

              alignment: Alignment.center,
              children: <Widget>[
                // background image and bottom contents
                Column(
                  children: <Widget>[
                    SizedBox(height: 50,),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue[800])   ,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            color: Colors.grey[300],
                          ),
                        ],
                      ),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10, 60, 10, 10),
                        //height: 120.0,
                        child:
                        Column(
                          children: [
                            Center(
                              child:  Text(
                                " ${widget.cats.name}",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.indigo,
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),


                          ],
                        ),
                      ),
                    ),

                  ],
                ),
                // Profile image
                Positioned(
                  top:0, // (background container size) - (circle height / 2)
                  child: Container(
                    height: 110.0,
                    width: 110.0,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue[700])   ,
                        image: DecorationImage(
                          image: NetworkImage(widget.cats.imgFullPath),
                          fit: BoxFit.cover,
                        ),
                        shape: BoxShape.circle,
                        color: Colors.lightBlue[200 ]
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue[800])   ,
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 2,
                    color: Colors.grey[300],
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                child:
                Row(
                  children: [
                    Expanded(flex:1,
                        child:Center(
                          child: Container(
                            child: Icon(Icons.account_circle,color: Colors.blue,),
                          ),
                        )),
                    Expanded(flex:8,
                        child:
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide( //                   <--- left side
                            color: Colors.grey[300],
                            width: 2.0,
                          ),
                      )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: check,
                                onChanged: (newValue) {
                                  setState(() {
                                    check = newValue;

                                    if(check==true){
                                      _nameControl.text = "";
                                      _phoneControl.text = "";
                                    }else{
                                      _nameControl.text = widget.data["name"] ;
                                      _phoneControl.text = widget.data["mobile"] ;
                                    }
                                  });

                                },
                              ),
                              SizedBox(width: 6,),
                              getDeviceType()!="small"?
                              Text("انا اقوم بالحجز نيابة عن مريض اخر",style: TextStyle(fontSize: 11.0.sp,
                              fontFamily: "Cairo",fontWeight: FontWeight.w400),) :
                              Text("انا اقوم بالحجز نيابة عن مريض اخر",style: TextStyle(fontSize: 9.0.sp,
                                  fontFamily: "Cairo",fontWeight: FontWeight.w400),)
                            ],
                          ),
                          TextField(
                            controller: _nameControl,
                              enabled:check,
                            decoration: new InputDecoration(
                                contentPadding: const EdgeInsets.all(12.0),

                                fillColor: Colors.white,
                                hintText: "الاسم الكامل",
                                labelText:"الاسم الكامل",
                                labelStyle:
                                new TextStyle(fontSize: 12.0.sp,
                                    fontFamily: "Cairo",fontWeight: FontWeight.w400,color: Colors.black45)),
                            ),
                          Row(
                            children: [
                              Expanded(
                                flex:4,
                                child: TextFormField(
                                  enabled:check,

                                  controller: _phoneControl,
                                  // validator: (value) {
                                  //  if (value.isEmpty) {
                                  //  return 'Please enter some text';
                                  //  }
                                  //   },
                                  keyboardType: TextInputType.number,
                                  decoration: new InputDecoration(
                                      contentPadding: const EdgeInsets.all(12.0),

                                      fillColor: Colors.white,
                                      hintText: "رقم الهاتف",
                                      labelText:"رقم الهاتف",
                                      labelStyle:
                                      new TextStyle(fontSize: 12.0.sp,
                                          fontFamily: "Cairo",fontWeight: FontWeight.w400,color: Colors.black45)),
                                ),
                              ),
                             Expanded(flex:1,child: Container()),
                              Expanded(
                                flex:2,
                                child: TextFormField(
                                  enableInteractiveSelection: false,
                                  enabled: false,                                   // will disable paste operation
                                  // validator: (value) {
                                  //  if (value.isEmpty) {
                                  //  return 'Please enter some text';
                                  //  }
                                  //   },
                                  keyboardType: TextInputType.number,
                                  decoration: new InputDecoration(
                                      contentPadding: const EdgeInsets.all(12.0),

                                      fillColor: Colors.white,
                                      hintText: "965+",
                                      labelText:"965+",
                                      labelStyle:
                                      new TextStyle(fontSize: 12.0.sp,
                                          fontFamily: "Cairo",fontWeight: FontWeight.w400,color: Colors.black45)),
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    )),

                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),

            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue[800])   ,
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 2,
                    color: Colors.grey[300],
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                child:
                Column(
                  children: [

                    Divider(),
                    Row(
                      children: [
                        Expanded(flex:1,
                            child:Center(
                              child: Container(
                                child: Icon(Icons.date_range,color: Colors.blue,),
                              ),
                            )),
                        Expanded(flex:8,
                            child:
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide( //                   <--- left side
                                      color: Colors.grey[300],
                                      width: 2.0,
                                    ),
                                  )),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Row(
                                    children: [
                                      Text("${widget.days["start"]}",style:TextStyle(fontFamily: "Cairo",fontWeight: FontWeight.w500
                                  ,fontSize: 10.0.sp ),),
                                      Text("  -  "),
                                      Text("${widget.days["end"]}",style:TextStyle(fontFamily: "Cairo",fontWeight: FontWeight.w500
                                          ,fontSize: 10.0.sp ),)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("${widget.days["first"]}",style:TextStyle(fontFamily: "Cairo",fontWeight: FontWeight.w500
                                          ,fontSize: 10.0.sp ),),

                                    ],
                                  )

                                ],
                              ),
                            )),

                      ],
                    ),
                    Divider(color: Colors.grey,),
                    Row(
                      children: [
                        Expanded(flex:1,
                            child:Center(
                              child: Container(
                                child: Icon(Icons.location_on,color: Colors.blue,),
                              ),
                            )),
                        Expanded(flex:8,
                            child:
                            Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide( //                   <--- left side
                                        color: Colors.grey[300],
                                        width: 2.0,
                                      ),
                                    )),
                                child: Text("${widget.cats.address}",style: TextStyle(fontFamily: "Cairo",fontWeight: FontWeight.w500
                                ,fontSize: 10.0.sp ),)
                            )),

                      ],
                    ),
                    Container(child: Text("يرجي التواجد قبل الموعد ب 15 دقيقية",style: TextStyle(fontFamily: "Cairo",fontWeight: FontWeight.w500
                        ,fontSize: 10.0.sp,color: Colors.green ),),)
                  ],
                ),
              ),
            ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 1.0.h),
          child: Container(),
        ),
            Center(child:
           _isload? Center(child: CircularProgressIndicator()):
           InkWell(
             onTap: set_data,
              child: Container(
                height: width/9,
                decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 1.5,
                      color: Colors.grey[300],
                    ),
                  ],
                ),
                child:
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text("تأكيد الحجز ",style: TextStyle(letterSpacing:5,color: Colors.white,fontSize: 15.0.sp,fontWeight: FontWeight.w500,fontFamily: "Cairo"),),

                  ],),
              ),
            ))

          ],
        ),
      ),
    );
  }
}
