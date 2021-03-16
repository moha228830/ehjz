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
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:sizer/sizer.dart';

import 'package:http/http.dart' as http;
// My Own Import
import 'package:my_store/pages/login_signup/forgot_password.dart';

class Future_houer extends StatefulWidget {
  var data;
  var cats;
  String date;
  int place_id;
  var select;

  Future_houer(this.cats,this.data,this.select,this.place_id,this.date);
  @override
  _Future_houerState createState() => _Future_houerState();
}

class _Future_houerState extends State<Future_houer> {
  bool _isload = true;
  List houers = [] ;

  get_data() async{

      try {


          final response = await http
              .get(Config.url + "get_all_houer_user?place_id="+widget.place_id.toString()+"&date="+widget.date.toString()
              , headers: {
                "Accept": "application/json",

              });
          _isload = false;



          final data = jsonDecode(response.body);
             print(data);
          if (data["state"] == "1") {

            if (this.mounted) {
              setState(() {
                houers = data["data"]["all"];


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
          backgroundColor: Theme.of(context).appBarTheme.color,
          appBar: AppBar(
            backgroundColor: Colors.blue[700],

            title: Text(
              '${widget.select["day"]}   ${widget.date}',style: TextStyle(fontFamily: "Cairo",color: Colors.white,fontSize: 14.0.sp,fontWeight: FontWeight.bold),
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
          houers.length==0?
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
            itemCount: houers.length,
            itemBuilder: (BuildContext context, index) {
              final item = houers[index];
              return
                Row(
                  children: [
                    Expanded(
                      child: Row(


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
                        InkWell(
                          onTap: (){
                            return Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return Appoinment(widget.cats, widget.data, item);
                                },
                              ),
                            );
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
                               // Icon(Icons.add,color: Colors.white,),



                                Text(" حجز  ",style: TextStyle(letterSpacing:5,color: Colors.white,fontSize: width/25,fontWeight: FontWeight.bold,fontFamily: "Cairo"),),

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
