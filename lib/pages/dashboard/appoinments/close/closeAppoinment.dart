import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_store/config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_store/functions/localizations.dart';
import 'package:my_store/pages/dashboard/index.dart';
import 'package:my_store/pages/dashboard/my_date/my_date.dart';
import 'package:my_store/pages/dashboard/my_date/my_houer.dart';
import 'package:my_store/pages/home/home.dart';
import 'package:my_store/pages/login_signup/activation.dart';
import 'package:my_store/pages/login_signup/login.dart';
import 'package:my_store/pages/login_signup/signup.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'DayCloseAppoinment.dart';
// My Own Import
import 'package:my_store/pages/login_signup/forgot_password.dart';

class CloseAppoinment extends StatefulWidget {
  List cats ;
  CloseAppoinment(this.cats);
  @override
  _CloseAppoinmenttState createState() => _CloseAppoinmenttState();
}

class _CloseAppoinmenttState extends State<CloseAppoinment> {
  bool _isload = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Locale myLocale = Localizations.localeOf(context);

    return SafeArea(
      child:
      Scaffold(
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
                Text("لا يوجد بيانات",style: TextStyle(fontFamily: "Cairo",fontSize: 16),)
              ],),
          )
              :
          ListView.separated(
            separatorBuilder: (context, index) {
              return Divider();
            },
            shrinkWrap: true,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 20),
            itemCount: widget.cats.length,
            itemBuilder: (BuildContext context, index) {
              final item = widget.cats[index];
              return
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Text("     ${item["first"]}",style: TextStyle(fontFamily: "Cairo",fontSize: width/26),),

                        ],
                      ),
                    ),

                    Expanded(
                      // flex: 2,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                        child: InkWell(
                          onTap: (){
                            return Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return DayCloseAppoinments(item["date"])    ;
                                },
                              ),
                            );
                          },
                          child: Container(
                            height: width/10,
                            decoration: BoxDecoration(
                              color:  Colors.lightBlue,
                              borderRadius: BorderRadius.circular(10.0),
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



                                Text(" عرض ",style: TextStyle(letterSpacing:5,color: Colors.white,fontSize: width/30,fontWeight: FontWeight.bold,fontFamily: "Cairo"),),

                              ],),
                          ),
                        ),
                      ),
                    ),


                  ],
                );
            },
          )
      ),
    );
  }

}




