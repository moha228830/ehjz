import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_store/config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_store/functions/localizations.dart';
import 'package:my_store/pages/dashboard/my_date/my_houer.dart';

import 'package:overlay_support/overlay_support.dart';
import 'package:sizer/sizer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// My Own Import
import 'package:my_store/pages/login_signup/forgot_password.dart';

class FutureHouer extends StatefulWidget {
  var cats ;
  var cats2 ;
  var type;
  var token;
  var place_id;
  var all_day;
  FutureHouer(this.cats,this.type,this.token,this.place_id,this.all_day,this.cats2);
  @override
  _FutureHouerState createState() => _FutureHouerState();
}

class _FutureHouerState extends State<FutureHouer> {
  bool _isload = false;
  delete(id) async {

    try {


        if (this.mounted) {
          setState(() {
            _isload = true;
          });
        }
        final response = await http
            .post(Config.url + "delete_one_appoinment", headers: {
          "Accept": "application/json"
        }, body: {

          "place_id": widget.place_id.toString(),
          "token":widget.token.toString(),
          "id":id.toString()

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
                return My_houer(widget.place_id, widget.cats[0]["date"], widget.cats[0]["day"],widget.cats2,widget.token,widget.all_day,widget.type);
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

                      child: Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [

              SizedBox(width: 20,),
                          Text("${item["start"]}",style: TextStyle(fontFamily: "Cairo",fontSize: width/23),),

                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding:  EdgeInsets.symmetric(vertical: 0.0.h, horizontal: 5.0.w),
                        child:
              item["type"] ==1?Container(
                  height: width/10,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1.5,
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                  child: Icon(Icons.check,color: Colors.green,size: 22.0.sp,)) :
                       InkWell(
                          onTap: (){
                            delete(item["id"].toString());
                          },
                          child: Container(
                            height: width/10,
                            decoration: BoxDecoration(
                              color: Colors.blue[700],
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



                                Text(" حذف ",style: TextStyle(letterSpacing:5,color: Colors.white,fontSize: width/25,fontWeight: FontWeight.bold,fontFamily: "Cairo"),),

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
