import 'package:flutter/material.dart';
import 'package:my_store/functions/localizations.dart';
import 'package:my_store/pages/home/home.dart';
import 'package:my_store/pages/login_signup/changePassword.dart';
import 'package:my_store/pages/login_signup/login.dart';
import 'package:sizer/sizer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import 'package:my_store/config.dart';

import 'package:http/http.dart' as http;
class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  var token = utils.CreateCryptoRandomString();


  // Initially password is obscure


  // Toggles the password show status


  bool _isload = false;
  final TextEditingController _phoneControl = new TextEditingController();


  //////////////login //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  my_activate() async {


    try {

      if (_phoneControl.text
          .trim()
          .isEmpty ) {
        Fluttertoast.showToast(
          msg: AppLocalizations.of(context).translate('loginPage', 'complete'),
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
      }  else {
        if (this.mounted) {
          setState(() {
            _isload = true;
          });
        }
        final response = await http
            .post(Config.url + "send_code", headers: {
          "Accept": "application/json"
        }, body: {
          "mobile": _phoneControl.text,

        });

        final _formKey = GlobalKey<FormState>();

        var prif = SharedPreferences.getInstance();

        final data = jsonDecode(response.body);

        if (data["state"] == "1") {

          return Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return ChangePassword();
              },
            ),
          );
        } else {
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

      }
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
  }

  ///end ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.color,

      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        automaticallyImplyLeading: false,
        title: Text(
          " نسيت كلمة المرور",
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
      body: ListView(
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
                  padding: EdgeInsets.only(
                      top: 20.0, bottom: 20.0, right: 10.0, left: 10.0),
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
                      SizedBox(
                        height: 20.0,
                      ),
                      Text("بعد ارسال رقم هاتفك افحص رسائل sms في جهازك",style: TextStyle(fontFamily: "Cairo",fontSize: 12.0.sp), ),
                      SizedBox(
                        height: 10.0,
                      ),
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

                            hintText: "رقم الهاتف",
                            prefixIcon: Icon(Icons.phone),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(width: 2, color: Colors.purple)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),

                      SizedBox(
                        height: 20.0,
                      ),







                      !_isload?InkWell(
                        onTap: () {
                          my_activate();
                        },
                        child: Container(
                          height: 45.0,
                          width: 190.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.lightBlue,
                            elevation: 7.0,
                            child: GestureDetector(
                              child: Center(
                                child:
                                Text("ارسال",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Cairo',
                                    fontSize: 12.0.sp,
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ),
                            ),
                          ),
                        ),
                      ):CircularProgressIndicator(),
                      SizedBox(
                        height: 20.0,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "انهاء وتراجع ",
                          style: TextStyle(
                            color:
                            Theme.of(context).textTheme.headline6.color,
                            fontFamily: 'Cairo',
                            fontSize: 12.0.sp,
                            letterSpacing: 0.7,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),

                SizedBox(height: 50.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
