import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_store/config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_store/functions/localizations.dart';
import 'package:my_store/pages/dashboard/my_date/my_houer.dart';
import 'package:my_store/pages/home/home.dart';
import 'package:my_store/pages/login_signup/activation.dart';
import 'package:my_store/pages/login_signup/login.dart';
import 'package:my_store/pages/login_signup/signup.dart';
import 'package:my_store/pages/singlePlace/appoinment.dart';
import 'package:my_store/providers/admin.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_store/pages/dashboard/appoinments/appoinment.dart';
import 'package:sizer/sizer.dart';

// My Own Import
import 'package:my_store/pages/login_signup/forgot_password.dart';

class DayFutureAppoinments extends StatefulWidget {
  var date;

  DayFutureAppoinments(this.date);
  @override
  _DayFutureAppoinmentsState createState() => _DayFutureAppoinmentsState();
}

class _DayFutureAppoinmentsState extends State<DayFutureAppoinments> {
  bool _isload = true;
  String token ;
  String login;
  int user_id;
  int place_id;
  List my_data = [];
  deletet_book(id) async{

    if (this.mounted) {
      setState(() {
        _isload = true;
      });
    }

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
      try {
        if(user_id != null) {
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
            "id":id.toString(),
            "token":token

          });
          _isload = false;



          var prif = SharedPreferences.getInstance();

          final data = jsonDecode(response.body);

          if (data["state"] == "1") {
            Fluttertoast.showToast(
              msg: 'تمت العملية بنجاح',
              backgroundColor: Theme.of(context).textTheme.headline6.color,
              textColor: Theme.of(context).appBarTheme.color,
            );


            return Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return Appoinments();
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
            //01155556624
            if (this.mounted) {
              setState(() {
                _isload = false;
              });
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
    else{

      return Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return LoginPage();
          },
        ),
      );

    }




  }
  get_data() async{

    try {



      final response = await http
          .post(Config.url + "get_day_admin_appoinments", headers: {
        "Accept": "application/json"
      }, body: {
        "token":token,
        "place_id":place_id.toString(),
        "type":"future",
        "date":widget.date.toString()

      });
      _isload = false;



      final data = jsonDecode(response.body);
      print(data);
      if (data["state"] == "1") {

        if (this.mounted) {
          setState(() {
            my_data = data["data"];


            _isload = false;
          });
        }

        // print(my);


      }
      else {
        Fluttertoast.showToast(
          msg: '${data["msg"]}',
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
      // _showDialog (data["state"],m);


    } on SocketException catch (_) {
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context).translate('loginPage', 'no_net'),
        backgroundColor: Theme.of(context).textTheme.headline6.color,
        textColor: Theme.of(context).appBarTheme.color,
      );
    }


  }




  @override
  void initState() {
    token = Provider.of<PostDataProvider>(context, listen: false).token ;
    login = Provider.of<PostDataProvider>(context, listen: false).login ;
    user_id= Provider.of<PostDataProvider>(context, listen: false).user["id"] ;

    place_id = Provider.of<PostDataProvider>(context, listen: false).place["id"] ;
    get_data();

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Locale myLocale = Localizations.localeOf(context);

    return SafeArea(
      child:
      Scaffold(
          backgroundColor:Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.blue[700],

            title: Text(
              '${widget.date}',style: TextStyle(fontFamily: "Cairo",color: Colors.white,fontSize: 13.0.sp,fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            elevation: 0,
            // give the app bar rounded corners
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),

          ),
          body:

          _isload?Center(child: CircularProgressIndicator()):
          my_data.length==0?
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
                Text("لا يوجد بيانات",style: TextStyle(fontFamily: "Cairo",fontSize: 12.0.sp),)
              ],),
          )
              :
          ListView.builder(
            itemCount: my_data.length,
            itemBuilder: (BuildContext context, index) {
              final item = my_data[index];
              return
                Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey)   ,
                  color: Theme.of(context).appBarTheme.color,
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


                        Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),

                          width: width-30,
                          child: ListTile(
                            dense:true,
                            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                            contentPadding: EdgeInsets.only(left: 5, right: 5),
                            leading: Icon(Icons.perm_identity,color: Colors.indigo,size: 18.0.sp,),
                            title: Text(" ${item["name"]}",style: TextStyle(color: Colors.black,fontSize:13.0.sp,fontWeight: FontWeight.bold,fontFamily: "Cairo"),),
                            //trailing: Icon(Icons.arrow_forward_ios,color: Colors.lightBlue,),
                            selected: true,
                            onTap: () {

                            },
                          ),

                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),

                          width: width-30,
                          child: ListTile(
                            dense:true,
                            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                            contentPadding: EdgeInsets.only(left: 5, right: 5),
                            leading: Icon(Icons.phone,color: Colors.indigo,size:18.0.sp),
                            title: Text(" ${item["phone"]}",style: TextStyle(color: Colors.black,fontSize: 13.0.sp,fontWeight: FontWeight.bold,fontFamily: "Cairo"),),
                            //trailing: Icon(Icons.arrow_forward_ios,color: Colors.lightBlue,),
                            selected: true,
                            onTap: () {

                            },
                          ),

                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),

                          width: width-30,
                          child: ListTile(
                            dense:true,
                            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                            contentPadding: EdgeInsets.only(left: 5, right: 5),
                            leading: Icon(Icons.alarm,color: Colors.indigo,size:18.0.sp),
                            title: Text(" ${item["start"]}",style: TextStyle(color: Colors.black,fontSize: 13.0.sp,fontWeight: FontWeight.bold,fontFamily: "Cairo"),),
                            //trailing: Icon(Icons.arrow_forward_ios,color: Colors.lightBlue,),
                            selected: true,
                            onTap: () {

                            },
                          ),

                        ),
                        Divider(color: Colors.grey,),
                        Row(
                          children: [

                            Expanded(
                              child: Center
                                (child:

                              Container(
                                padding: EdgeInsets.all(10),
                                child: InkWell
                                  (onTap: (){
                                  Alert(
                                    context: context,
                                    type: AlertType.warning,
                                    style:AlertStyle(titleStyle:TextStyle(fontSize:12.0.sp,fontWeight: FontWeight.bold,fontFamily: "Cairo" ,color: Colors.indigo),
                                      descStyle: TextStyle(fontSize:10.0.sp,fontWeight: FontWeight.bold,fontFamily: "Cairo" ),
                                    ),
                                    title: "الغاء الحجز",
                                    desc: "هل انت متاكد من الغاء الحجز.",
                                    buttons: [
                                      DialogButton(
                                        child: Text(
                                          "الغاء",
                                          style: TextStyle(color: Colors.white, fontSize: 12.0.sp,fontFamily: "Cairo",fontWeight: FontWeight.bold),
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                        color: Colors.lightBlue,
                                      ),
                                      DialogButton(
                                        child: Text(
                                          "تأكيد",
                                          style: TextStyle(color: Colors.white, fontSize: 12.0.sp,fontFamily: "Cairo",fontWeight: FontWeight.bold),
                                        ),
                                        onPressed:() {
                                          deletet_book(item["id"]);
                                          Navigator.pop(context);
                                        },
                                        color: Colors.red,
                                      )
                                    ],
                                  ).show();

                                },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                      Icon(Icons.close),
                                      Text("الغاء الحجز",style: TextStyle(fontFamily: "Cairo",fontWeight: FontWeight.bold,color: Colors.red,fontSize: 12.0.sp)),

                                    ],),),
                              ),),
                            ),
                          ],
                        )



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

}
