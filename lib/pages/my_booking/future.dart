import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_store/config.dart';
import 'package:my_store/helper.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_store/functions/localizations.dart';
import 'package:my_store/pages/home/home.dart';
import 'package:my_store/pages/login_signup/activation.dart';
import 'package:my_store/pages/login_signup/login.dart';
import 'package:my_store/pages/login_signup/signup.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';
import 'package:my_store/pages/login_signup/forgot_password.dart';

class FuturePage extends StatefulWidget {
  List cats ;
  var type;
  FuturePage(this.cats,this.type);
  @override
  _FuturePageState createState() => _FuturePageState();
}

class _FuturePageState extends State<FuturePage> {
  DateTime currentBackPressTime;
  bool _isload = false;
  deletet_book(id) async{
    EasyLoading.show(status: '...loading');
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var login = localStorage.getString('login');
    //var user =localStorage.getString('user');

    print(login);
    if(login=="0"){

      return Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return LoginPage();
          },
        ),
      );

    }else if (login=="1"){
      return Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return Activation();
          },
        ),
      );

    }else if (login=="2"){
      var user = jsonDecode( localStorage.getString('user'));
      var user_id = user["id"];

      try {
        if(user_id !=null) {
          if (this.mounted) {
            setState(() {
              _isload = true;
            });
          }
          final response = await http
              .post(Config.url + "delete_booking", headers: {
            "Accept": "application/json"
          }, body: {
            "user_id":user_id.toString(),
            "id":id.toString()

          });
          _isload = false;





          final data = jsonDecode(response.body);

          if (data["state"] == "1") {
            showSimpleNotification(Text("تم الغاء الموعد بنجاح ", style: TextStyle(fontSize: 12.0.sp,fontFamily: "Cairo"),),
                background: Colors.green);
            EasyLoading.dismiss();

            return Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return Home(1);
                },
              ),
            );



          }
          else {
            Fluttertoast.showToast(
              msg: 'حاول مرة اخري',
              backgroundColor: Theme.of(context).textTheme.headline6.color,
              textColor: Theme.of(context).appBarTheme.color,
            );
            EasyLoading.dismiss();
            if (this.mounted) {
              setState(() {
                _isload = false;
              });
            }
          }
          // _showDialog (data["state"],m);

        }
      } on SocketException catch (_) {
        EasyLoading.dismiss();
        Fluttertoast.showToast(
          msg: AppLocalizations.of(context).translate('loginPage', 'no_net'),
          backgroundColor: Theme.of(context).textTheme.headline6.color,
          textColor: Theme.of(context).appBarTheme.color,
        );
      }


    }
    else{
      EasyLoading.dismiss();
      return Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return LoginPage();
          },
        ),
      );
    }




  }
  ///end ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Locale myLocale = Localizations.localeOf(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).appBarTheme.color,

        body:

      _isload?Center(child: CircularProgressIndicator()):
      widget.cats.length==0?
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

              Image.asset(
                'assets/round_logo2.png',
                height: 150.0,
              ),
              SizedBox(
                height: 25.0,
              ),
            ],),
          )
          :
      ListView.builder(
        itemCount: widget.cats.length,
        itemBuilder: (BuildContext context, index) {
          final item = widget.cats[index];
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey)   ,
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  color: Colors.grey[300],
                ),
              ],
            ),
            padding: EdgeInsets.all(0),
            width: width,
            margin: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 2.0.h),
            child: SingleChildScrollView(
              child: Card(
                elevation: 10,
                child: Column(
                  children: [
                    Container(height: 7.0.h,color: Colors.lightBlue,child:
                      Center(child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Icon(Icons.date_range,color: Colors.white,size: 14.0.sp,),
                          Text(" ${item["first"]}",style: TextStyle(color: Colors.white,fontSize: 13.0.sp,fontWeight: FontWeight.bold,fontFamily: "Cairo"),),
                        ],
                      ),
                      )
                      ,),
                    Container(
                      margin: EdgeInsets.all(0),
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 25.0.w,
                                height: 12.0.h,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[300])   ,

                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                    image: NetworkImage("${item["img"]}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              widthSpace,
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    " ${get_by_size(item["place_name"],26,26,"..")}",
                                    style: TextStyle(
                                      fontSize: 12.0.sp,
                                      color: Colors.indigo,
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  SizedBox(height: 5,),
                                  Text(
                                    " ${ get_by_size(item["job"],26,26,"..")}",
                                    style: TextStyle(
                                      fontSize: 12.0.sp,
                                      color: Colors.black,
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5,),




                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: width,
                      child: ListTile(
                        contentPadding: EdgeInsets.only(left: 5, right: 5),
                        leading: Icon(Icons.location_on,color: Colors.lightBlue,size: 15.0.sp,),
                        title: Text(" ${get_by_size(item["address"],26,26,"..")}",style: TextStyle(color: Colors.black,fontSize: 12.0.sp,fontWeight: FontWeight.bold,fontFamily: "Cairo"),),
                        //trailing: Icon(Icons.arrow_forward_ios,color: Colors.lightBlue,),
                        selected: true,
                        onTap: () {

                        },
                      ),
                    ),

                    Container(
                      color: Colors.grey[300],
                      child: Column(
                        children: [
                          SizedBox(height: 1.0.h,),

                          Row(
                            children: [
                              Expanded(
                                child: Center(child: InkWell
                                  (child:
                                    item["type"]==0?
                               Text("   الساعة    ${item["start"]}",style: TextStyle(fontFamily: "Cairo",fontWeight: FontWeight.bold,color: Colors.blue,fontSize: 13.0.sp),)
                                        : item["type"]==1?    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(Icons.check_circle,color: Colors.green,),

                                            Text(" تم التأكيد ",style: TextStyle(fontFamily: "Cairo",fontWeight: FontWeight.bold,color: Colors.green),),
                                          ],
                                        )
                                        :item["type"]==2?    Text("تم الغاء الحجز",style: TextStyle(fontFamily: "Cairo",fontWeight: FontWeight.bold,color: Colors.red,fontSize: 13.0.sp),)
                                    :Text("جاري تاكيد الحجز",style: TextStyle(fontFamily: "Cairo",fontWeight: FontWeight.bold,color: Colors.grey),)

                                ),),
                              ),
                              Expanded(
                                child: Center
                                  (child:
                                    item["type"] ==2?  Text("   الساعة    ${item["start"]}",style: TextStyle(fontFamily: "Cairo",fontWeight: FontWeight.bold,color: Colors.blue,fontSize: 13.0.sp),)
                                        :
                                        widget.type == 1?Text(" "):
                                Container(
                                  padding: EdgeInsets.all(10),
                                   child: InkWell
                                    (onTap: (){
                                     Alert(
                                       context: context,
                                       type: AlertType.warning,
                                       style:AlertStyle(titleStyle:TextStyle(fontSize:12.0.sp,fontWeight: FontWeight.bold,fontFamily: "Cairo" ,color: Colors.indigo),
                                         descStyle: TextStyle(fontSize:12.0.sp,fontWeight: FontWeight.bold,fontFamily: "Cairo" ),
                                       ),
                                       title: "الغاء الحجز",
                                       desc: "هل انت متاكد من الغاء الحجز.",
                                       buttons: [
                                         DialogButton(
                                           child: Text(
                                             "تأكيد",
                                             style: TextStyle(color: Colors.white, fontSize: 12.0.sp,fontFamily: "Cairo",fontWeight: FontWeight.bold),
                                           ),
                                           onPressed:() {deletet_book(item["id"]);},
                                           color: Colors.green,
                                         ),
                                         DialogButton(
                                           child: Text(
                                             "اغلاق",
                                             style: TextStyle(color: Colors.white, fontSize: 12.0.sp,fontFamily: "Cairo",fontWeight: FontWeight.bold),
                                           ),
                                           onPressed: () => Navigator.pop(context),
                                           color: Colors.red,
                                         ),

                                       ],
                                     ).show();


                                  },
                                    child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                      Icon(Icons.close),
                                      Text("الغاء الحجز",style: TextStyle(fontFamily: "Cairo",fontWeight: FontWeight.bold,color: Colors.red,fontSize: 13.0.sp)),

                                    ],),),
                                ),),
                              ),
                            ],
                          ),
                          SizedBox(height: 1.0.h,),
                        ],
                      ),
                    ),




                  ],
                ),
              ),
            ),
          );
        },
      )
      ),
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context)
            .translate('loginPage', 'exitToastString'),
        backgroundColor: Theme.of(context).textTheme.headline6.color,
        textColor: Theme.of(context).appBarTheme.color,
      );
      return Future.value(false);
    }
    exit(0);
    return Future.value(true);
  }
}
