import 'dart:convert';
import 'package:my_store/pages/call_center/call_center.dart';
import 'package:my_store/providers/admin.dart';
import 'package:sizer/sizer.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_store/pages/dashboard/index.dart' as dash;
import 'package:overlay_support/overlay_support.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:my_store/pages/login_signup/signup.dart';
import 'package:my_store/pages/profile/data.dart';

import 'package:my_store/pages/login_signup/login.dart';

import 'package:my_store/pages/login_signup/activation.dart';
import 'package:my_store/pages/login_signup/changePassword.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_store/pages/home/home.dart';

// My Own Imports
import 'package:my_store/AppTheme/AppStateNotifier.dart';
import 'package:my_store/pages/change_language.dart';
import 'package:my_store/functions/localizations.dart';

import 'package:my_store/pages/login_signup/login.dart';
import 'package:my_store/pages/my_account/account_setting.dart';

import '../../main.dart';
import 'package:sizer/sizer.dart';

class Visitor extends StatefulWidget {
  @override
  _VisitorState createState() => _VisitorState();
}

class _VisitorState extends State<Visitor> {
  String my_name;
  deleete() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove("user");
    localStorage.remove("token");
    localStorage.setString('login', "0");

    Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeft, child: MyHomePage()));
  }

  deleete_activation() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove("user");
    localStorage.setString('login', "0");
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeft, child: SignupPage()));
  }

  var status;
  var name;
  @override
  void initState() {
    status = Provider.of<PostDataProvider>(context, listen: false).login;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'المزيد',
          style: TextStyle(
              fontFamily: "Cairo",
              color: Colors.white,
              fontSize: 13.0.sp,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[700],
        elevation: 0,
        // give the app bar rounded corners
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 1.0.h),
            child: Divider(
              height: 1.0,
            ),
          ),
          InkWell(
            onTap: () {
              status != "2"
                  ? Navigator.push(
                      context,
                      PageTransition(
                          curve: Curves.linear,
                          duration: Duration(milliseconds: 400),
                          type: PageTransitionType.bottomToTop,
                          child: LoginPage()))
                  : Navigator.push(
                      context,
                      PageTransition(
                          curve: Curves.linear,
                          duration: Duration(milliseconds: 900),
                          type: PageTransitionType.bottomToTop,
                          child: dash.Index()));
            },
            child: Container(
              padding: EdgeInsets.all(7.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.location_city,
                    size: 17.0.sp,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Container(
                    width: (width - (width / 4.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "حساب نشاط",
                          style: TextStyle(
                              fontFamily: "Cairo",
                              fontSize: 12.0.sp,
                              color:
                                  Theme.of(context).textTheme.headline6.color),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 1.0.h),
            child: Divider(
              height: 1.0,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: CallCenter()));
            },
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.phone,
                    size: 30.0,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Text(
                    "تواصل معنا",
                    style: TextStyle(
                        fontFamily: "Cairo",
                        fontSize: 12.0.sp,
                        color: Theme.of(context).textTheme.headline6.color),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 1.0.h),
            child: Divider(
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}
