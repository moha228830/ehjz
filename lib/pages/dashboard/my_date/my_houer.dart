
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_store/functions/drawer.dart';
import 'package:my_store/functions/localizations.dart';
import 'package:my_store/functions/place_modle.dart';
import 'package:my_store/providers/admin.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:sizer/sizer.dart';

import 'package:my_store/pages/dashboard/my_date/add_appoinment.dart';
import 'package:my_store/pages/dashboard/my_date/add_seprate.dart';
import 'package:my_store/pages/dashboard/my_date/clone_appoinment.dart';
import 'package:my_store/pages/dashboard/my_date/futureHouer.dart';
import 'package:my_store/pages/login_signup/activation.dart';
import 'package:my_store/pages/login_signup/login.dart';

import 'dart:convert';
import 'package:select_dialog/select_dialog.dart';
import 'package:my_store/config.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';


import 'dart:async' show Future, Timer;




import 'package:shimmer/shimmer.dart';

import '../../../helper.dart';

class My_houer extends StatefulWidget {
  int place_id ;
  var type;
  var token;
  var date ;
  var day;
  var cat;
  var all_day;
  My_houer(this.place_id,this.date,this.day,this.cat,this.token,this.all_day,this.type);
  @override
  _My_houerState createState() => _My_houerState();
}

class _My_houerState extends State<My_houer> {

  var select ;
  bool load = true ;
  // Use the compute function to run parseProducts in a separate isolate.

  bool _isload = false;
  final double circleRadius = 110.0;
  final double circleBorderWidth = 8.0;
  List  fu = [];
  List  my = [];
  List  close = [];
  var provider_place ;

  //////////////is_login //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  get_shard() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var login = localStorage.getString('login');
    var token =localStorage.getString('token');

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
              .get(Config.url + "get_all_houer?place_id="+widget.place_id.toString()+"&date="+widget.date.toString()+"&token="+
              token
              , headers: {
                "Accept": "application/json",
                "token":token
              });
          _isload = false;

          final _formKey = GlobalKey<FormState>();

          var prif = SharedPreferences.getInstance();

          final data = jsonDecode(response.body);

          if (data["state"] == "1") {

            if (this.mounted) {
              setState(() {
                fu = data["data"]["all"];
                close = data["data"]["all"];
                my = data["data"]["all"];

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

  ///end ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  @override
  void initState() {
    super.initState();


    get_shard();

  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[700],

          title: Text(
            '${widget.day}   ${widget.date}',style: TextStyle(fontFamily: "Cairo",color: Colors.white,fontSize: 13.0.sp,fontWeight: FontWeight.bold),
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
        body: _isload?Center(child: CircularProgressIndicator()):
        Column(
          children: <Widget>[
            // construct the profile details widget here


            // the tab bar with two items
            SizedBox(
              height: getDeviceType()=="small"? 9.0.h:getDeviceType()=="phone"?7.0.h:6.0.h,
              child: AppBar(
                automaticallyImplyLeading: false,
                bottom: TabBar(
                  isScrollable: true,
                  labelStyle: TextStyle(fontSize: 12.0.sp,fontFamily: 'Cairo'),  //For Selected tab
                  unselectedLabelStyle: TextStyle(fontSize: 10.0.sp,fontFamily: 'Cairo'), //For Un-selected Tabs
                  tabs: [


                    Tab(
                      text: "اضف موعد",
                    ),
                    Tab(
                      text: "اضف متعدد",
                    ),
                    Tab(
                      text: "المواعيد",
                    ),
                    Tab(
                      text: "نسخ الي",
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 2.0.h,),
            // create widgets for each tab bar here
            Expanded(
              child: TabBarView(
                children: [
                  // first tab bar view widget


                  // second tab bar viiew widget
                  Add_appoinment(widget.cat,widget.type,widget.place_id,widget.token,widget.all_day),
                  Add_seprate(widget.cat,widget.type,widget.place_id,widget.token,widget.all_day),
                  FutureHouer(my,widget.type,widget.token,widget.place_id,widget.all_day,widget.cat),

                  Clone(widget.cat,widget.type,widget.place_id,widget.token,widget.all_day),

                ],
              ),
            ),
          ],
        ),

      ),
    );
  }
}