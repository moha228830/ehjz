import 'package:flutter/material.dart';
import 'package:my_store/functions/localizations.dart';
import 'package:my_store/pages/home/home.dart';
import 'package:my_store/providers/admin.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:my_store/pages/login_signup/login.dart';
import 'package:page_transition/page_transition.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import 'package:my_store/config.dart';
import 'package:my_store/pages/login_signup/activation.dart';

import 'package:http/http.dart' as http;
class Password extends StatefulWidget {
  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  var token = utils.CreateCryptoRandomString();


  // Initially password is obscure
  bool _obscureText1 = true;
  bool _obscureText2 = true;

  String _password;

  // Toggles the password show status
  void _toggle1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  void _toggle2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }


  var tok ;
  var login ;
  bool _isload = false;
  final TextEditingController _newpasswordControl = new TextEditingController();
  final TextEditingController _oldpasswordControl = new TextEditingController();

  //////////////login //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  my_login() async {




    SharedPreferences localStorage = await SharedPreferences.getInstance();
    if (login== "2"){
      try {

        if (_oldpasswordControl.text
            .trim()
            .isEmpty ||
            _newpasswordControl.text
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

        else if (_oldpasswordControl.text.length < 6 ||
            _oldpasswordControl.text.length > 20) {
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
        }
        else if (_newpasswordControl.text.length < 6 ||
            _newpasswordControl.text.length > 20) {
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
              .post(Config.url + "edit_pass", headers: {
            "Accept": "application/json"
          }, body: {
            "new": _newpasswordControl.text,
            "old": _oldpasswordControl.text,

            "token":tok.toString()
          });

          final _formKey = GlobalKey<FormState>();

          var prif = SharedPreferences.getInstance();

          final data = jsonDecode(response.body);

          if (data["state"] == "1") {
            SharedPreferences localStorage =
            await SharedPreferences.getInstance();

            Fluttertoast.showToast(
              msg: 'تمت العملية بنجاح',
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
    }else{
      Fluttertoast.showToast(
        msg: 'خطأ غير متوقع اغلق التطبيق ثم اعد فتحة من البداية',
        backgroundColor: Theme.of(context).textTheme.headline6.color,
        textColor: Theme.of(context).appBarTheme.color,
      );
    }
    if (this.mounted) {
      setState(() {
        _isload = false;
      });
    }
  }

  ///end ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  @override
  void initState() {
    tok =  Provider.of<PostDataProvider>(context, listen: false).token;

    login = Provider.of<PostDataProvider>(context, listen: false).login;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text(
          "تعديل كلمة المرور",
          style: TextStyle(
            fontFamily: 'Cairo',
            color: Colors.white,
            fontSize: 12.0.sp,
            letterSpacing: 1.7,
            fontWeight: FontWeight.bold,
          ),
        ),
        titleSpacing: 0.0,
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
                          controller: _oldpasswordControl,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 2.0.h),

                            hintText: "كلمة المرور القديمة",
                            prefixIcon:  new FlatButton(
                                onPressed: _toggle1,
                                child: _obscureText1?Icon(Icons.visibility_off ):Icon(Icons.visibility )
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(width: 2, color: Colors.purple)),
                          ),
                          obscureText: _obscureText1,
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
                          controller: _newpasswordControl,
                          decoration: InputDecoration(
                            hintText: "كلمة المرور الجديدة",
                            contentPadding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 2.0.h),

                            prefixIcon:  new FlatButton(
                                onPressed: _toggle2,
                                child: _obscureText2?Icon(Icons.visibility_off ):Icon(Icons.visibility )
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(width: 2, color: Colors.purple)),
                          ),
                          obscureText: _obscureText2,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),






                      InkWell(
                        onTap: () {
                          my_login();
                        },
                        child: Container(
                          height: 45.0,
                          width: 190.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Colors.redAccent,
                            color: Colors.lightBlue,
                            elevation: 7.0,
                            child: GestureDetector(
                              child: Center(
                                child:!_isload?
                                Text("حفظ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Cairo',
                                    fontSize: 13.0.sp,
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ):CircularProgressIndicator(),
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
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: Home(0
                                  )));
                        },
                        child: Text("الرئيسية",
                          style: TextStyle(
                            color: Theme.of(context).textTheme.headline6.color,
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
