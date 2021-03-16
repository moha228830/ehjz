
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_store/functions/localizations.dart';
import 'package:my_store/functions/place_modle.dart';
import 'dart:async';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:my_store/pages/login_signup/activation.dart';
import 'package:my_store/pages/login_signup/login.dart';
import 'package:my_store/pages/login_signup/signup.dart';
import 'package:my_store/pages/singlePlace/appoinment.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:convert';
import 'package:select_dialog/select_dialog.dart';
import 'package:my_store/config.dart';
import 'package:http/http.dart' as http;
import 'package:my_store/pages/place/one_place.dart';
import 'package:my_store/pages/place/se.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sizer/sizer.dart';

import 'dart:async' show Future, Timer;




import 'package:shimmer/shimmer.dart';

import '../../helper.dart';
import 'future.dart';
class Index extends StatefulWidget {

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {

  List days = [];
  var select ;
  bool load = true ;
  // Use the compute function to run parseProducts in a separate isolate.

  bool _isload = false;
  final double circleRadius = 110.0;
  final double circleBorderWidth = 8.0;
  List  fu = [];
  List  end = [];
  List  close = [];


  //////////////is_login //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  get_shard() async{
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
              .post(Config.url + "get_booking", headers: {
            "Accept": "application/json"
          }, body: {
            "user_id":user_id.toString(),

          });




          final data = jsonDecode(response.body);

          if (data["state"] == "1") {

            if (this.mounted) {
              setState(() {
                fu = data["data"]["future"];
                close = data["data"]["close"];
                end = data["data"]["end"];

                _isload = false;
              });
            }

            EasyLoading.dismiss();

          }
          else {
            Fluttertoast.showToast(
              msg: '${data["msg"]}',
              backgroundColor: Theme.of(context).textTheme.headline6.color,
              textColor: Theme.of(context).appBarTheme.color,
            );
            EasyLoading.dismiss();
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
        EasyLoading.dismiss();
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
  void initState() {
    EasyLoading.show(status: '...loading');
    super.initState();
    get_shard();

  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[700],

          title: Text(
            'مواعيدي',style: TextStyle(fontFamily: "Cairo",color: Colors.white,fontSize: 15.0.sp,fontWeight: FontWeight.bold),
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
        Column(
          children: <Widget>[
            // construct the profile details widget here


            // the tab bar with two items
            SizedBox(
              height: getDeviceType()=="small"? 9.0.h:getDeviceType()=="phone"?7.0.h:6.0.h,
              child: AppBar(
                automaticallyImplyLeading: false,
                bottom: TabBar(
                  labelStyle: TextStyle(fontSize: 10.0.sp,fontFamily: 'Cairo'),  //For Selected tab
                  unselectedLabelStyle: TextStyle(fontSize: 10.0.sp,fontFamily: 'Cairo'), //For Un-selected Tabs
                  tabs: [
                    Tab(
                      text: "حالية",
                    ),
                    Tab(
                      text: "منتتهية",
                    ),
                    Tab(
                      text: "تم الالغاء",
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
                  FuturePage(fu,0),

                  // second tab bar viiew widget
                  FuturePage(end,1),
                  FuturePage(close,2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}