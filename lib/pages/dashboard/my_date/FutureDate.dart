import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_store/config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_store/functions/localizations.dart';
import 'package:my_store/pages/dashboard/my_date/my_date.dart';
import 'package:my_store/pages/dashboard/my_date/my_houer.dart';
import 'package:overlay_support/overlay_support.dart';

import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sizer/sizer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// My Own Import
import 'package:my_store/pages/login_signup/forgot_password.dart';

class FutureDate extends StatefulWidget {
  List cats ;
  var token;
  var type;
  var all_day;
  int place_id;
  FutureDate(this.cats,this.type,this.place_id,this.token,this.all_day);
  @override
  _FutureDateState createState() => _FutureDateState();
}

class _FutureDateState extends State<FutureDate> {
  bool _isload = false;
  delete(date) async {

    try {


      if (this.mounted) {
        setState(() {
          _isload = true;
        });
      }
      final response = await http
          .post(Config.url + "delete_all_appoinment", headers: {
        "Accept": "application/json"
      }, body: {

        "place_id": widget.place_id.toString(),
        "token":widget.token.toString(),
        "date":date.toString()

      });



      final data = jsonDecode(response.body);
      print(data);
      if (data["state"] == "1") {

        showSimpleNotification(
            Text("تمت العملية بنجاح", style: TextStyle(fontSize: 12.0.sp,fontFamily: "Cairo"),),
            background: Colors.green);
        return Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return My_date(widget.place_id);
            },
          ),
        );


      }

      else {
        Fluttertoast.showToast(
          msg: '${data["msg"]}',
          backgroundColor: Theme
              .of(context)
              .textTheme
              .headline6
              .color,
          textColor: Theme
              .of(context)
              .appBarTheme
              .color,
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
        backgroundColor: Theme
            .of(context)
            .textTheme
            .headline6
            .color,
        textColor: Theme
            .of(context)
            .appBarTheme
            .color,
      );
    }


    if (this.mounted) {
      setState(() {
        _isload = false;
      });
    }
  }

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
                          Text("${item["day"]} ${item["date"]}",style: TextStyle(fontFamily: "Cairo",fontSize: width/26),),

                        ],
                      ),
                    ),

                    Expanded(
                     // flex: 2,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                        child: InkWell(
                          onTap: (){
                            return Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return My_houer(widget.place_id, item["date"], item["day"],item,widget.token,widget.all_day,widget.type);
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



                                    Text(" المواعيد",style: TextStyle(letterSpacing:5,color: Colors.white,fontSize: width/30,fontWeight: FontWeight.bold,fontFamily: "Cairo"),),

                                  ],),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      // flex: 2,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: InkWell(
                          onTap: (){
                            Alert(
                              context: context,
                              type: AlertType.warning,
                              style:AlertStyle(titleStyle:TextStyle(fontSize:12.0.sp,fontWeight: FontWeight.bold,fontFamily: "Cairo" ,color: Colors.indigo),
                                descStyle: TextStyle(fontSize:10.0.sp,fontWeight: FontWeight.bold,fontFamily: "Cairo" ),
                              ),
                              title: " حذف مواعيد",
                              desc: "هل انت متأكد من حذف جميع مواعيد هذا اليوم.",
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
                                    delete(item["date"]);
                                    Navigator.pop(context);
                                    },
                                  color: Colors.red,
                                )
                              ],
                            ).show();

                          },
                          child: Container(
                            height: width/10,
                            decoration: BoxDecoration(
                              color:  widget.type==2?Colors.pinkAccent:Colors.redAccent,
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



                                Text("حذف",style: TextStyle(letterSpacing:5,color: Colors.white,fontSize: width/30,fontWeight: FontWeight.bold,fontFamily: "Cairo"),),

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




