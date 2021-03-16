
import 'dart:io';
import 'package:my_store/functions/drawer.dart';
import 'package:sizer/sizer.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_store/functions/localizations.dart';
import 'package:my_store/functions/place_modle.dart';
import 'dart:async';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:my_store/pages/dashboard/admin/admin.dart';
import 'package:my_store/pages/dashboard/my_date/FutureDate.dart';
import 'package:my_store/pages/dashboard/my_date/add_day.dart';
import 'package:my_store/pages/dashboard/request.dart';
import 'package:my_store/pages/home/home.dart';
import 'package:my_store/pages/login_signup/activation.dart';
import 'package:my_store/pages/login_signup/login.dart';
import 'package:my_store/pages/login_signup/signup.dart';
import 'package:my_store/pages/my_booking/future.dart';
import 'package:my_store/pages/singlePlace/appoinment.dart';
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


import 'dart:async' show Future, Timer;




import 'package:shimmer/shimmer.dart';

import '../../../helper.dart';

class My_date extends StatefulWidget {
int place_id ;
My_date(this.place_id);
  @override
  _My_dateState createState() => _My_dateState();
}

class _My_dateState extends State<My_date> {

  List days = [];
  bool _isload = false;
  List  fu = [];
  List  my = [];
  List  close = [];
  var place;
  var token = "" ;

  get_shard() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var login = localStorage.getString('login');

    setState(() {
      token =localStorage.getString('token');
    });
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
     var  user_id = user["id"];



      try {
        if(user_id !=null) {
          if (this.mounted) {
            setState(() {
              _isload = true;
            });
          }
          final response = await http
              .get(Config.url + "get_all_date?place_id="+widget.place_id.toString()
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
                fu = data["data"]["future"];
                close = data["data"]["close"];
                my = data["data"]["my"];

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



  @override
  void initState() {
    get_shard();

    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<PostDataProvider>(context, listen: false);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[700],
          title: Text(
            'ايام العمل',style: TextStyle(fontFamily: "Cairo",color: Colors.white,fontSize: 13.0.sp,fontWeight: FontWeight.bold),
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

                 // isScrollable: true,

                  labelStyle: TextStyle(fontSize: 12.0.sp,fontFamily: 'Cairo'),  //For Selected tab
                  unselectedLabelStyle: TextStyle(fontSize: 10.0.sp,fontFamily: 'Cairo'), //For Un-selected Tabs
                  tabs: [
                    Tab(
                      text: "جارية",
                    ),

                    Tab(
                      text: " اضف يوم",
                    ),
                    Tab(
                      text: "الارشيف",
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
                  FutureDate(my,0,widget.place_id,token,fu),
                  Add_day(fu,2,widget.place_id,token),
                  FutureDate(close,1,widget.place_id,token,fu),

                ],
              ),
            ),
          ],
        ),
        drawer:
        Drawer(
          child:
          My_Drawer(),
        ),

      ),
    );
  }
}