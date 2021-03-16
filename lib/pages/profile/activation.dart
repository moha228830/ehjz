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
class Activation extends StatefulWidget {
  var phone;
  var country ;
  var code;
  Activation(this.phone,this.country,this.code);
  @override
  _ActivationState createState() => _ActivationState();
}

class _ActivationState extends State<Activation> {
  var token = utils.CreateCryptoRandomString();


  // Initially password is obscure


  // Toggles the password show status


  bool _isload = false;
  final TextEditingController _codeControl = new TextEditingController();
  var tok ;

  //////////////login //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  my_activate() async {


    SharedPreferences localStorage = await SharedPreferences.getInstance();
    if (tok != null){
      try {

        if (_codeControl.text
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
              .post(Config.url + "change_phone", headers: {
            "Accept": "application/json"
          }, body: {
            "mobile": widget.phone,

            "phone_code": widget.code,
            "country": widget.country,
            "token":tok.toString(),
            "code": _codeControl.text,
          });

          final _formKey = GlobalKey<FormState>();

          var prif = SharedPreferences.getInstance();

          final data = jsonDecode(response.body);
  print(data);
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
            print(data['data']["User"]);
            localStorage.setString('user', json.encode(data['data']["User"]));
            Provider.of<PostDataProvider>(context, listen: false).get_shard("2", data['data']["token"],data['data']["User"]["id"],data['data']["User"]);

            return Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return Home(0);
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

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          "كود تغيير رقم الهاتف",
          style: TextStyle(
            fontFamily: 'Cairo',
            color: Colors.white,
            fontSize: 13.0.sp,
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
                      SizedBox(
                        height: 20.0,
                      ),
                      Text("افحص رسائل sms علي هاتفك ",style: TextStyle(fontSize: 13.0.sp,fontFamily: "Cairo"),),
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

                          controller: _codeControl,
                          decoration: InputDecoration(
                            hintText: "كود التغيير",
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

                      SizedBox(
                        height: 20.0,
                      ),







                      InkWell(
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
                            child:!_isload? GestureDetector(
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
                                ),
                              ),
                            ):Center(child: CircularProgressIndicator()),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
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
