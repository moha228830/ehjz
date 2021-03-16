
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_store/functions/drawer.dart';
import 'package:my_store/functions/localizations.dart';
import 'package:my_store/pages/login_signup/activation.dart';
import 'package:my_store/pages/login_signup/login.dart';
import 'package:sizer/sizer.dart';

import 'package:my_store/providers/admin.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:select_dialog/select_dialog.dart';
import 'package:my_store/config.dart';
import 'package:http/http.dart' as http;
import 'package:my_store/pages/place/one_place.dart';
import 'package:my_store/pages/place/se.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helper.dart';
import 'future/futureAppoinment.dart';
import 'close/closeAppoinment.dart';

import 'end/endAppoinment.dart';

import 'dart:async' show Future, Timer;




import 'package:shimmer/shimmer.dart';

class Appoinments extends StatefulWidget {

  @override
  _AppoinmentsState createState() => _AppoinmentsState();
}

class _AppoinmentsState extends State<Appoinments> {

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
  String token ;
  int place_id;
  var place;

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
              .post(Config.url + "get_all_admin_appoinments", headers: {
            "Accept": "application/json"
          }, body: {
            "token":token,
            "place_id":place_id.toString()

          });
          _isload = false;



          final data = jsonDecode(response.body);
        print(data);
          if (data["state"] == "1") {

            if (this.mounted) {
              setState(() {
                fu = data["data"]["future"];
                close = data["data"]["close"];
                end = data["data"]["end"];

                _isload = false;
              });
            }

            print(end);


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
    token = Provider.of<PostDataProvider>(context, listen: false).token ;
    place_id = Provider.of<PostDataProvider>(context, listen: false).place["id"] ;
    place =  Provider.of<PostDataProvider>(context, listen: false).place ;
    get_shard();

    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer:
        Drawer(
          child:
          My_Drawer(),
        ),
         appBar: AppBar(
      backgroundColor: Colors.blue[700],
          title: Text(
            'الحجوزات',style: TextStyle(fontFamily: "Cairo",color: Colors.white,fontSize: 13.0.sp,fontWeight: FontWeight.bold),
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
                bottom: TabBar(
                  labelStyle: TextStyle(fontSize: 12.0.sp,fontFamily: 'Cairo'),  //For Selected tab
                  unselectedLabelStyle: TextStyle(fontSize: 12.0.sp,fontFamily: 'Cairo'), //For Un-selected Tabs
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
                  FutureAppoinment(fu),

                  // second tab bar viiew widget

                  EndAppoinment(end),
                  CloseAppoinment(close),
                ],
              ),
            ),
          ],
        ),

      ),
    );
  }
}