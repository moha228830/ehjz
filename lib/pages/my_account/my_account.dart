import 'dart:convert';
import 'package:my_store/providers/admin.dart';
import 'package:sizer/sizer.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_store/pages/call_center/call_center.dart';
import 'package:my_store/pages/dashboard/request.dart';
import 'package:my_store/pages/product_list_view/get_function.dart';
import 'package:my_store/pages/profile/address.dart';
import 'package:my_store/pages/profile/balance.dart';
import 'package:my_store/pages/profile/password.dart';
import 'package:my_store/pages/profile/phone.dart';
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

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
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
  var status ;
  var name;
@override
  void initState() {
  my_name =  Provider.of<PostDataProvider>(context, listen: false).user["name"];
  name = Provider.of<PostDataProvider>(context, listen: false).user["name"];
  status = Provider.of<PostDataProvider>(context, listen: false).login;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    // Logout AlertDialog Start Here
    logoutDialogue() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          // return object of type Dialog
          return Dialog(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              height: 160.0,
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context)
                        .translate('myAccountPage', 'sureDialogueString'),
                    style: TextStyle(
                      fontFamily: "Cairo",
                      fontSize: 12.0.sp,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).textTheme.headline6.color,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      InkWell(
                        onTap: () {

                        },
                        child: Container(
                          width: (width / 3.5),
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('myAccountPage', 'closeString'),
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {

                        },
                        child: Container(
                          width: (width / 3.5),
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('myAccountPage', 'logoutString'),
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).appBarTheme.color,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
    // Logout AlertDialog Ends Here

    return status=="no"?CircularProgressIndicator():
      Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),

            width: width,
            height: 210.0,
            color: Colors.white,

            child: Stack(
              children: <Widget>[
               Container(
                 height: 100,
                 color: Colors.white,

               ),
                Positioned(
                  top: 45.0,
                  right: ((width / 2) - 60.0),
                  child: Column(
                    children: <Widget>[
                      Container(

                        height: 110.0,
                        width: 110.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(55.0),
                          border: Border.all(color: Colors.blue[800], width: 5.0),
                        ),
                        child: ClipRRect(
                          borderRadius: new BorderRadius.circular(50.0),
                          child: Image(
                            image: AssetImage('assets/user_profile/profile.png'),
                            height: 100.0,
                            width: 100.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child:  Text(
                          "${Provider.of<PostDataProvider>(context, listen: true).user["name"]}",
                          style: TextStyle(
                            fontFamily: "Cairo",
                              fontSize: 12.0.sp,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).textTheme.headline6.color),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
              border: Border.all(color: Colors.blue[800])   ,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  color: Colors.grey[300],
                ),
              ],
            ),
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child:
            status == "1" ?
            Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft, child: Activation()));
                  },
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.supervised_user_circle,
                          size: 17.0.sp,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Text(
                          "تأكيد الحساب",
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
                InkWell(
                  onTap: () {
                    deleete_activation();
                  },
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.supervised_user_circle,
                          size: 17.0.sp,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Text(
                          " الرجوع للتسجيل من جديد",
                          style: TextStyle(
                              fontFamily: "Cairo",
                              fontSize: 12.0.sp,
                              color: Theme.of(context).textTheme.headline6.color),
                        )
                      ],
                    ),
                  ),

                )
              ],
            )
                :
            status == "2"?

            Column(
              children: [




                Padding(
                  padding: EdgeInsets.only(right: 30.0, left: 70.0),
                  child: Divider(
                    height: 1.0,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft, child: Data()));
                  },
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.edit,
                          size: 17.0.sp,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Text(
                          "تعديل الاسم",
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
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft, child: Password()));
                  },
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.edit,
                          size: 17.0.sp,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Text(
                          "تعديل كلمة المرور",
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
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft, child: Phone()));
                  },
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.edit,
                          size: 17.0.sp,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Text(
                          "تعديل الهاتف والدولة",
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
                InkWell(
                  onTap: () {
                    deleete();
                    showSimpleNotification(
                        Text("تم تسجيل الخروج بنجاح", style: TextStyle(fontSize: 12.0.sp,fontFamily: "Cairo"),),
                        background: Colors.green);

                  },
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.arrow_back,
                          size: 17.0.sp,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Text(
                          "تسجيل خروج",
                          style: TextStyle(
                              fontFamily: "Cairo",
                              fontSize: 12.0.sp,
                              color: Theme.of(context).textTheme.headline6.color),
                        )
                      ],
                    ),
                  ),

                ),
                SizedBox(height: 2.0.sp,)
              ],
            ):


            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft, child: LoginPage()));
              },
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.supervised_user_circle,
                      size: 30.0,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      "تسجيل دخول",
                      style: TextStyle(
                          fontFamily: "Cairo",
                          fontSize: 12.0.sp,
                          color: Theme.of(context).textTheme.headline6.color),
                    )
                  ],
                ),
              ),

            )
                ,

              )
          ],
        ),

        ],
    ),
      );
  }
}
