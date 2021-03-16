import 'dart:io';
import 'package:my_store/config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_store/functions/localizations.dart';
import 'package:my_store/pages/home/home.dart';
import 'package:my_store/pages/login_signup/signup.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_store/providers/admin.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
// My Own Import
import 'package:my_store/pages/login_signup/forgot_password.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  DateTime currentBackPressTime;
  bool _isload = false;
  final TextEditingController _phoneControl = new TextEditingController();
  final TextEditingController _passwordControl = new TextEditingController();
  //////////////login //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  my_login(context) async {
    try {
      if (_passwordControl.text.trim().isEmpty ||
          _phoneControl.text.trim().isEmpty) {
        Fluttertoast.showToast(
          msg: AppLocalizations.of(context).translate('loginPage', 'complete'),
          backgroundColor: Theme.of(context).textTheme.headline6.color,
          textColor: Theme.of(context).appBarTheme.color,
        );
      } else if (_phoneControl.text.length < 8) {
        Fluttertoast.showToast(
          msg: AppLocalizations.of(context)
              .translate('loginPage', 'phone_error'),
          backgroundColor: Theme.of(context).textTheme.headline6.color,
          textColor: Theme.of(context).appBarTheme.color,
        );
      } else if (_passwordControl.text.length < 6 ||
          _passwordControl.text.length > 20) {
        Fluttertoast.showToast(
          msg:
          AppLocalizations.of(context).translate('loginPage', 'pass_words'),
          backgroundColor: Theme.of(context).textTheme.headline6.color,
          textColor: Theme.of(context).appBarTheme.color,
        );
      } else {
        if (this.mounted) {
          setState(() {
            _isload = true;
          });
        }
        final response = await http
            .post(Config.url + "login2", headers: {
          "Accept": "application/json"
        }, body: {
          "mobile": _phoneControl.text,
          "password": _passwordControl.text,
        });
        _isload = false;

        final _formKey = GlobalKey<FormState>();

        var prif = SharedPreferences.getInstance();

        final data = jsonDecode(response.body);

        if (data["state"] == "1") {
          SharedPreferences localStorage =
          await SharedPreferences.getInstance();
          localStorage.setString('token', data['data']["token"]);
          localStorage.setString('user', json.encode(data['data']["User"]));
          localStorage.setString('user_id', json.encode(data['data']["User"]["id"].toString()));

          localStorage.setString('login', "2");
          Provider.of<PostDataProvider>(context, listen: false).get_shard("2", data['data']["token"],data['data']["User"]["id"],data['data']["User"]);
          Fluttertoast.showToast(
            msg: 'تم التسجيل بنجاح',
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

          return Navigator.pop(context);
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

  ///end ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    Locale myLocale = Localizations.localeOf(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).appBarTheme.color,
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          automaticallyImplyLeading: false,
          title: Text(
            "تسجيل الدخول",
            style: TextStyle(
              fontFamily: "Cairo",
              fontSize: 12.0.sp,
                color:Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              tooltip: "Back",
              icon: Icon(
                Icons.clear,
                color: Colors.black,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        body: WillPopScope(
          child: ListView(
            children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 30.0),
                    Image.asset(
                      'assets/round_logo2.png',
                      height: 18.0.h,
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Container(
                      width: width - 40.0,
                      padding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 2.0.h),
                      decoration: BoxDecoration(
                        color: Theme.of(context).appBarTheme.color,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 1.5,
                            color: Colors.grey[300],
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius:
                              BorderRadius.all(Radius.circular(20.0)),
                            ),
                            child: TextField(
                              keyboardType: TextInputType.number,

                              controller: _phoneControl,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 2.0.h),

                                hintText: AppLocalizations.of(context)
                                    .translate('loginPage', 'phone'),
                                prefixIcon: Icon(Icons.phone),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius:
                              BorderRadius.all(Radius.circular(20.0)),
                            ),
                            child: TextField(
                              controller: _passwordControl,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 2.0.h),

                                hintText: AppLocalizations.of(context)
                                    .translate('loginPage', 'passwordString'),
                                prefixIcon: Icon(Icons.vpn_key),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              obscureText: true,
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: ForgotPasswordPage()));
                            },
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('loginPage', 'forgotPasswordString'),
                                style: TextStyle(
                                  color:
                                  Theme.of(context).textTheme.headline6.color,
                                  fontFamily: "Cairo",
                                  fontSize: 12.0.sp,
                                  letterSpacing: 0.7,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          _isload
                              ? Center(
                            child: CircularProgressIndicator(),
                          )
                              : InkWell(
                            onTap: () {
                              my_login(context);
                            },
                            child: Center(
                              child: Container(
                                height: 45.0,
                                width:
                                (myLocale.languageCode == 'ru') ? 180.0 : 140.0,
                                child: Material(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.lightBlue,
                                  elevation: 7.0,
                                  child: Center(
                                    child: Text("تسجيل",style: TextStyle(
                                    color:
                                    Colors.white,
                                    fontFamily: "Cairo",
                                    fontSize: 12.0.sp,
                                    letterSpacing: 0.7,
                                    fontWeight: FontWeight.bold,
                                ),),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: SignupPage()));
                            },
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('loginPage', 'createAccountString'),
                              style: TextStyle(
                                color:
                                Theme.of(context).textTheme.headline6.color,
                                fontFamily: "Cairo",
                                fontSize: 12.0.sp,
                                letterSpacing: 0.7,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 50.0),

                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                             "انهاء وتراجع ",
                              style: TextStyle(
                                color:
                                Theme.of(context).textTheme.headline6.color,
                                fontFamily: "Cairo",
                                fontSize: 12.0.sp,
                                letterSpacing: 0.7,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          onWillPop: onWillPop,
        ),
      ),
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context)
            .translate('loginPage', 'exitToastString'),
        backgroundColor: Theme.of(context).textTheme.headline6.color,
        textColor: Theme.of(context).appBarTheme.color,
      );
      return Future.value(false);
    }
    exit(0);
    return Future.value(true);
  }
}
