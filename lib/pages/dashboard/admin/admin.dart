import 'dart:io';
import 'package:badges/badges.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_store/functions/drawer.dart';
import 'package:my_store/functions/localizations.dart';
import 'package:my_store/pages/dashboard/index.dart' as dash;
import 'package:my_store/pages/dashboard/my_date/my_date.dart';
import 'package:my_store/pages/dashboard/profile/profile.dart';
import 'package:my_store/pages/dashboard/request.dart';
import 'package:my_store/pages/home/home.dart';
import 'package:sizer/sizer.dart';


import 'package:my_store/pages/dashboard/appoinments/appoinment.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'dart:convert';

// My Own Imports
import 'package:my_store/pages/home/home_main.dart';
import 'package:my_store/pages/login_signup/login.dart';

import '../../../config.dart';
import '../../../helper.dart';



class Admin extends StatefulWidget {
  int place_id ;
 var name  ;
 var img ;

  var job_title;
  Admin(this.name,this.place_id,this.img,this.job_title);
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  int currentIndex;
  var num = "!";
  var token = utils.CreateCryptoRandomString();

  DateTime currentBackPressTime;
  @override



  void initState() {

    super.initState();


    set_token_not_register();

  }

  set_token_not_register() async{
    SharedPreferences localStorage =
    await SharedPreferences.getInstance();
    var tok = localStorage.getString('token');
    var login = localStorage.getString('login');

    //if(login=="2"){
    //var data_user = localStorage.getString('user_id');
    //print(data_user);
    //}

    if ( tok == null  ){
      localStorage.setString('token', token);
      localStorage.setString('user_id', "0");
      localStorage.setString('login', "0");

      // print( tok + "moha");

    }
    print(tok);
  }





  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor:Colors.grey[100] ,
      appBar: AppBar(
        backgroundColor: Colors.blue[700],

        title: Text(
          'لوحة التحكم',style: TextStyle(fontFamily: "Cairo",color: Colors.white,fontSize: 13.0.sp,fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        // give the app bar rounded corners
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              PageTransition(
                  curve: Curves.linear,
                  duration: Duration(milliseconds: 900),

                  type: PageTransitionType.bottomToTop,
                  child:Home(0)));

        },
        child: Icon(Icons.home),
        backgroundColor: Colors.blue[700],
      ),
        body:
        ListView(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Stack(

                      alignment: Alignment.center,
                      children: <Widget>[
                        // background image and bottom contents
                        Column(
                          children: <Widget>[
                            SizedBox(height: 50,),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue[800])   ,
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 2,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              child: Container(
                                padding: EdgeInsets.fromLTRB(10, 60, 10, 10),
                                height: 20.0.h,
                                child:
                                Column(
                                  children: [
                                    Center(
                                      child:  Text(
                                        " ${get_by_size(widget.name,30,30,"..")}",
                                        style: TextStyle(
                                          fontSize: 12.0.sp,
                                          color: Colors.indigo,
                                          fontFamily: 'Cairo',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),

                                    Flexible(
                                      child: Center(
                                        child: new Text(
                                          '${get_by_size(widget.job_title,30,30,"..")}  ',
                                          style: TextStyle(
                                              fontSize: 12.0.sp,fontFamily: 'Cairo',
                                              color: Theme.of(context).textTheme.headline6.color),
                                        ),
                                      ),),


                                    SizedBox(height: 5,),







                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                        // Profile image
                        Positioned(
                          top:0, // (background container size) - (circle height / 2)
                          child: Container(
                            height: 110.0,
                            width: 110.0,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue[700])   ,
                                image: DecorationImage(
                                  image: NetworkImage(widget.img),
                                  fit: BoxFit.cover,
                                ),
                                shape: BoxShape.circle,
                                color: Colors.lightBlue[200 ]
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        width: width,

                            child: Column(
                              mainAxisSize: MainAxisSize.min,

                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.blue[800])   ,
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20.0),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 2,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                    child: ListTile(
                                      subtitle: Text('ادارة اوقات العمل والمواعيد المتاحة ',style: TextStyle(color: Colors.black,fontSize: 9.0.sp,fontWeight: FontWeight.bold,fontFamily:"Cairo"),),

                                      leading: Icon(Icons.date_range,color: Colors.indigo,size: 20.0.sp,),
                                      title: Text('المواعيد',style: TextStyle(color: Colors.indigo,fontSize: 13.0.sp,fontWeight: FontWeight.bold,fontFamily:"Cairo"),),
                                      trailing: Icon(Icons.arrow_forward_ios,color: Colors.indigo,),
                                      selected: true,
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                curve: Curves.linear,
                                                duration: Duration(milliseconds: 400),
                                                type: PageTransitionType.leftToRight,
                                                child:My_date(widget.place_id)));
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.blue[800])   ,
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20.0),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 2,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                    child: ListTile(
                                      subtitle: Text('المواعيد التي تم حجزها من قبل العملاء',style: TextStyle(color: Colors.black,fontSize: 9.0.sp,fontWeight: FontWeight.bold,fontFamily:"Cairo"),),

                                      leading: Icon(Icons.alarm,color: Colors.indigo,size: 20.0.sp,),
                                      title: Text('الحجز',style: TextStyle(letterSpacing:5,color: Colors.indigo,fontSize: 13.0.sp,fontWeight: FontWeight.bold,fontFamily:"Cairo"),),
                                      trailing: Icon(Icons.arrow_forward_ios,color: Colors.indigo,),
                                      selected: true,
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                curve: Curves.linear,
                                                duration: Duration(milliseconds: 400),
                                                type: PageTransitionType.leftToRight,
                                                child:Appoinments()));


                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.blue[800])   ,
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20.0),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 2,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                    child: ListTile(
                                      leading: Icon(Icons.location_city,color: Colors.indigo,size: 20.0.sp,),
                                      subtitle: Text('عرض البيانات وتعديلها',style: TextStyle(color: Colors.black,fontSize: 9.0.sp,fontWeight: FontWeight.bold,fontFamily:"Cairo"),),

                                      title: Text('بيانات النشاط',style: TextStyle(letterSpacing:5,color: Colors.indigo,fontSize: width/21,fontWeight: FontWeight.bold,fontFamily:"Cairo"),),
                                      trailing: Icon(Icons.arrow_forward_ios,color: Colors.indigo,),
                                      selected: true,
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                curve: Curves.linear,
                                                duration: Duration(milliseconds: 400),
                                                type: PageTransitionType.leftToRight,
                                                child:Profile()));
                                      },
                                    ),
                                  ),
                                ),

                              ],
                            )
                      ),
                    ],
                  ),
                ],
              ),
      drawer:
      Drawer(
        child:
        My_Drawer(),
      ),



    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context).translate('homePage','exitToastString'),
        backgroundColor: Theme.of(context).textTheme.headline6.color,
        textColor: Theme.of(context).appBarTheme.color,
      );
      return Future.value(false);
    }
    exit(0);
    return Future.value(true);
  }
}
class utils {
  static final Random _random = Random.secure();

  static String CreateCryptoRandomString([int length = 32]) {
    var values = List<int>.generate(length, (i) => _random.nextInt(256));

    return base64Url.encode(values);
  }
}