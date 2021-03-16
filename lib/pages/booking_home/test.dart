
import 'package:flutter/material.dart';

import 'package:my_store/pages/dashboard/index.dart';
import 'package:my_store/pages/home/home.dart' as home;

import 'package:my_store/providers/admin.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'dart:convert';
import 'package:sizer/sizer.dart';
import 'package:my_store/pages/login_signup/login.dart';



class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex;
  var num = "!";

  var token = utils.CreateCryptoRandomString();
  set_token_not_register(context) async{
    SharedPreferences localStorage =
    await SharedPreferences.getInstance();
    var tok = localStorage.getString('token');
    var login = localStorage.getString('login');

    //if(login=="2"){
    //var data_user = localStorage.getString('user_id');
    //print(data_user);
    //}

    if ( login  != "2" || login==null   ){


      Provider.of<PostDataProvider>(context, listen: false).get_shard("0","0","0",null);
      print(Provider.of<PostDataProvider>(context, listen: false).login);

    }
    else{
      var user = jsonDecode( localStorage.getString('user'));
      var  user_id = user["id"];
      Provider.of<PostDataProvider>(context, listen: false).get_shard(login,tok,user_id,user);
      print(Provider.of<PostDataProvider>(context, listen: false).login);
    }

  }
  DateTime currentBackPressTime;
  @override
  void initState() {
    set_token_not_register(context);
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var login2 = Provider.of<PostDataProvider>(context, listen: true).login;

    return Scaffold(
        backgroundColor:Colors.lightBlue[500] ,

        body:  ListView(
          children: [
            SizedBox(height: 30.0),
            Image.asset(
              'assets/round_logo2.png',
              height:20.0.h,
            ),
            SizedBox(
              height: 3.0.h,
            ),

            Center(child:
            Text("لتخفيف عناء البحث",style: TextStyle(color: Colors.white,fontSize: 15.0.sp,fontWeight: FontWeight.bold,fontFamily:"Cairo"),),),
            SizedBox(
              height: 10.0.h,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
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
                child: ListTile(
                  leading: Icon(Icons.add_box,color: Colors.indigo,),
                  title: Text(' احجز الان',style: TextStyle(color: Colors.indigo,fontSize: 15.0.sp,fontWeight: FontWeight.bold,fontFamily:"Cairo"),),
                  trailing: Icon(Icons.arrow_forward_ios,color: Colors.indigo,),
                  selected: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>home.Home(0),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
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
                child:login2=="2"?
                ListTile(
                  leading: Icon(Icons.alarm,color: Colors.indigo,),
                  title: Text('مواعيدي',style: TextStyle(letterSpacing:5,color: Colors.indigo,fontSize: 15.0.sp,fontWeight: FontWeight.bold,fontFamily:"Cairo"),),
                  trailing: Icon(Icons.arrow_forward_ios,color: Colors.indigo,),
                  selected: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>home.Home(1),
                      ),
                    );

                  },
                ):
                ListTile(
                  leading: Icon(Icons.login,color: Colors.indigo,),
                  title: Text('تسجيل دخول',style: TextStyle(letterSpacing:5,color: Colors.indigo,fontSize: 15.0.sp,fontWeight: FontWeight.bold,fontFamily:"Cairo"),),
                  trailing: Icon(Icons.arrow_forward_ios,color: Colors.indigo,),
                  selected: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>LoginPage(),
                      ),
                    );

                  },
                )
                ,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
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
                child: ListTile(
                  leading: Icon(Icons.apps,color: Colors.indigo,),
                  title: Text(' حساب نشاط',style: TextStyle(letterSpacing:5,color: Colors.indigo,fontSize: 15.0.sp,fontWeight: FontWeight.bold,fontFamily:"Cairo"),),
                  trailing: Icon(Icons.arrow_forward_ios,color: Colors.indigo,),
                  selected: true,
                  onTap: () {
                    return
                      login2!="2"?
                      Navigator.push(
                          context,
                          PageTransition(
                              curve: Curves.linear,
                              duration: Duration(milliseconds: 400),

                              type: PageTransitionType.bottomToTop,
                              child:LoginPage())):
                      Navigator.push(
                          context,
                          PageTransition(
                              curve: Curves.linear,
                              duration: Duration(milliseconds: 400),

                              type: PageTransitionType.bottomToTop,
                              child:Index()))
                    ;

                  },
                ),
              ),
            ),
          ],
        )

    );
  }


}
class utils {
  static final Random _random = Random.secure();

  static String CreateCryptoRandomString([int length = 32]) {
    var values = List<int>.generate(length, (i) => _random.nextInt(256));

    return base64Url.encode(values);
  }
}