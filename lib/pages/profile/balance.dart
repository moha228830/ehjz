import 'package:flutter/material.dart';
import 'package:my_store/functions/localizations.dart';
import 'package:my_store/pages/home/home.dart';
import 'package:my_store/pages/login_signup/forgot_password.dart';
import 'package:my_store/pages/login_signup/login.dart';
import 'package:page_transition/page_transition.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import 'package:my_store/config.dart';
import 'package:my_store/pages/login_signup/activation.dart';

import 'package:http/http.dart' as http;
class Balance extends StatefulWidget {
  @override
  _BalanceState createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  var token = utils.CreateCryptoRandomString();


  // Initially password is obscure


  // Toggles the password show status




  bool _load = true;
  double balance ;
  String my_name = "user" ;
  final TextEditingController _nameControl = new TextEditingController();
  get_shard() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var d = localStorage.getString('user');
    var name = jsonDecode(d)["name"]??"user";
    setState(() {
      my_name = name;
    });
    print(name);
  }

  //////////////login //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  get_balance  () async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if(token !="" || token !=null ){
      try{
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          http.Response response =
          await http.get(Config.url+"get_governs?token="+token);


          if (response.statusCode == 200) {


            var res = json.decode(response.body);
            if (res["state"]=="1"){
              if (this.mounted) {
                setState(() {
                  balance= res["msg"].toDouble();
                  // print(governs);

                });
              }
              //print(cartItemList.length);

              //  print(tok);

            }else{
              Fluttertoast.showToast(
                msg: '${res["msg"]}',
                backgroundColor: Theme.of(context).textTheme.headline6.color,
                textColor: Theme.of(context).appBarTheme.color,
              );

            }


          }
        }else{
          Fluttertoast.showToast(
            msg: 'no internet ',
            backgroundColor: Theme.of(context).textTheme.headline6.color,
            textColor: Theme.of(context).appBarTheme.color,
          );
        }
      } on SocketException {

        Fluttertoast.showToast(
          msg: 'no internet ',
          backgroundColor: Theme.of(context).textTheme.headline6.color,
          textColor: Theme.of(context).appBarTheme.color,
        );
      }

    }else{
      Fluttertoast.showToast(
        msg: 'اغلق التطبيق ثم اعد فتحه ',
        backgroundColor: Theme.of(context).textTheme.headline6.color,
        textColor: Theme.of(context).appBarTheme.color,
      );
    }

    if (this.mounted) {
      setState(() {
        _load = false;
      });
    }
  }

  ///end ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  @override
  void initState() {
    super.initState();
    get_balance();
    get_shard();
  }
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text(
          "رصيدي ",
          style: TextStyle(
            fontFamily: 'Jost',
            color: Colors.white,
            fontSize: width/24,
            letterSpacing: 1.7,
            fontWeight: FontWeight.bold,
          ),
        ),
        titleSpacing: 0.0,
      ),
      body: ListView(
        children: <Widget>[
         _load?Center(child:  LinearProgressIndicator(
           backgroundColor: Colors.pinkAccent,
           valueColor: AlwaysStoppedAnimation(Colors.purpleAccent),
           minHeight: 20,
         )): Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 25.0,
                ),

                SizedBox(
                  height: 25.0,
                ),
                Center(
                  child: Container(
                    height: height/3,
                    width: width /2,
                    padding: EdgeInsets.only(
                        top: 20.0, bottom: 20.0, right: 10.0, left: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      borderRadius: BorderRadius.circular(width/2),

                      boxShadow: [
                        BoxShadow(
                          blurRadius: 1.5,
                          color: Colors.grey[300],
                        ),
                      ],
                    ),
                    child: Container(
                      height: height/4,
                      width: width /2,
                      padding: EdgeInsets.only(
                          top: 20.0, bottom: 20.0, right: 10.0, left: 10.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).appBarTheme.color,
                        borderRadius: BorderRadius.circular(width/2),

                        boxShadow: [
                          BoxShadow(
                            blurRadius: 1.5,
                            color: Colors.grey[300],
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 30.0),
                          Text("رصيدي",
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: width/22,color: Theme.of(context).textTheme.headline6.color),
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                            crossAxisAlignment: CrossAxisAlignment.center, //Center Row contents vertically,
                            children: [
                              Text("KW ",
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: width/22,color: Theme.of(context).textTheme.headline6.color),
                              ),
                              Text("  ${balance}",
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: width/22,color: Theme.of(context).textTheme.headline6.color),
                              ),
                            ],
                          ),
                        ],
                      ),

                    ),
                  ),
                ),

                SizedBox(height: 50.0),
                Text("يمكنك استخدام الرصيد في الشراء من خلال التطبيق",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: width/22,color: Theme.of(context).textTheme.headline6.color),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
