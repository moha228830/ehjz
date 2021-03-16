import 'package:flutter/material.dart';
import 'package:my_store/functions/localizations.dart';
import 'package:my_store/pages/home/home.dart';
import 'package:my_store/pages/login_signup/forgot_password.dart';
import 'package:my_store/pages/login_signup/login.dart';
import 'package:my_store/providers/admin.dart';
import 'package:page_transition/page_transition.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import 'package:my_store/config.dart';
import 'package:sizer/sizer.dart';

import 'package:http/http.dart' as http;
class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  var token = utils.CreateCryptoRandomString();


  // Initially password is obscure
  bool _obscureText = true;

  String _password;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }



  bool _isload = false;
  final TextEditingController _codeControl = new TextEditingController();
  final TextEditingController _passwordControl = new TextEditingController();

  //////////////login //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  my_login() async {




    try {

      if (_passwordControl.text
          .trim()
          .isEmpty ||
          _codeControl.text
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
      }

      else if (_passwordControl.text.length < 6 ||
          _passwordControl.text.length > 20) {
        Fluttertoast.showToast(
          msg:
          AppLocalizations.of(context).translate('loginPage', 'pass_words'),
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
      } else {
        if (this.mounted) {
          setState(() {
            _isload = true;
          });
        }
        final response = await http
            .post(Config.url + "changPassword_new", headers: {
          "Accept": "application/json"
        }, body: {
          "code": _codeControl.text,
          "password": _passwordControl.text,

        });




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
          " تغيير كلمة المرور",
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
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius:
                          BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: TextField(
                          controller: _codeControl,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 2.0.h),

                            hintText: "الكود من رسالة sms",
                            prefixIcon: Icon(Icons.code),
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

                            hintText: "كلمة المرور الجديدة",
                            prefixIcon:  new FlatButton(
                                onPressed: _toggle,
                                child: _obscureText?Icon(Icons.visibility_off ):Icon(Icons.visibility )
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(width: 2, color: Colors.purple)),
                          ),
                          obscureText: _obscureText,
                        ),
                      ),

                      SizedBox(
                        height: 20.0,
                      ),

            !_isload?
            InkWell(
                        onTap: () {
                          my_login();
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
                                Text("تأكيد",
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
                        height: 15.0,
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
