
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
      backgroundColor:Colors.white ,

      body:  ListView(
        children: [



          Container(
              height: 27.0.h,
              child: Column(

            children: [
            Image.asset(
              'assets/eh.png',
              height:26.0.h,
            ),


          ],)),


      Container(
        height: 73.0.h,
        decoration: new BoxDecoration(
            color: Colors.blue[700],
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(50.0),
              topRight: const Radius.circular(40.0),
            )
        ),
                child: Center(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment:CrossAxisAlignment.center,
              children: [

                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>home.Home(0),
                      ),
                    );
                  },
                  child: Container(width:width-100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white)   ,
                      borderRadius: BorderRadius.circular(10.0),

                    ),
                    padding: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 1.0.h),
                    child:Center(
                        child: Container(
                        child:Text(' احجز الان',style: TextStyle(color: Colors.indigo,fontSize: 15.0.sp,fontWeight: FontWeight.bold,fontFamily:"Cairo"),),

                      ),
                      )

                    ,),
                ),
                SizedBox(height: 3.0.h,),
                login2=="2"?
                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>home.Home(1),
                      ),
                    );
                  },
                  child: Container(width:width-100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white)   ,
                      borderRadius: BorderRadius.circular(10.0),

                    ),
                    padding: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 1.0.h),
                    child:Center(child:
                     Container(
                        child: Text('مواعيدي',style: TextStyle(letterSpacing:5,color: Colors.indigo,fontSize: 15.0.sp,fontWeight: FontWeight.bold,fontFamily:"Cairo"),),

                      ),
                      )

                    ,),
                ):
                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>LoginPage(),
                      ),
                    );
                  },
                  child: Container(width:width-100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white)   ,
                      borderRadius: BorderRadius.circular(10.0),

                    ),
                    padding: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 1.0.h),
                    child:Center(child:
                  Container(
                        child: Text('تسجيل دخول',style: TextStyle(letterSpacing:5,color: Colors.indigo,fontSize: 15.0.sp,fontWeight: FontWeight.bold,fontFamily:"Cairo"),),

                      )
                      ,)

                    ,),
                )
                ,
                SizedBox(height: 3.0.h,),
                InkWell(
                  onTap: (){
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
                  child: Container(width:width-100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white)   ,
                      borderRadius: BorderRadius.circular(10.0),

                    ),
                    padding: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 1.0.h),
                    child:Center(child:
                     Container(
                        child: Text(' حساب نشاط',style: TextStyle(letterSpacing:5,color: Colors.indigo,fontSize: 15.0.sp,fontWeight: FontWeight.bold,fontFamily:"Cairo"),),

                      )
                      ,)

                    ,),
                ),


              ],
            ),

        ),
      )

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