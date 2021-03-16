import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_store/config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_store/functions/localizations.dart';
import 'package:my_store/pages/dashboard/my_date/my_houer.dart';
import 'package:sizer/sizer.dart';

// My Own Import
import 'package:my_store/pages/login_signup/forgot_password.dart';

class Add_day extends StatefulWidget {
  List cats ;
  var token;
  var type;
  int place_id;
  Add_day(this.cats,this.type,this.place_id,this.token);
  @override
  _Add_dayState createState() => _Add_dayState();
}

class _Add_dayState extends State<Add_day> {
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
                Text("لا يوجد بيانات",style: TextStyle(fontFamily: "Cairo",fontSize: 12.0.sp),)
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
                      child: Row(
                        children: [
                          Text("${item["day"]}",style: TextStyle(fontFamily: "Cairo",fontSize: 12.0.sp),),

                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [


                          Text("${item["date"]}",style: TextStyle(fontFamily: "Cairo",fontSize: 12.0.sp),),
                        ],
                      ),
                    ),
                    Expanded(
                      // flex: 2,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: InkWell(
                          onTap: (){
                            return Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return My_houer(widget.place_id, item["date"], item["day"],item,widget.token,widget.cats,widget.type);
                                },
                              ),
                            );
                          },
                          child: Container(
                            height: width/10,
                            decoration: BoxDecoration(
                              color:  widget.type==2?Colors.lightBlue:Colors.lightBlue,
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
                                Icon(Icons.add,color: Colors.white,),



                                Text("اضف موعد",style: TextStyle(letterSpacing:5,color: Colors.white,fontSize: 12.0.sp,fontWeight: FontWeight.bold,fontFamily: "Cairo"),),

                              ],)
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




