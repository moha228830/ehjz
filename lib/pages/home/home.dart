import 'dart:io';
import 'package:badges/badges.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_store/functions/localizations.dart';
import 'package:my_store/pages/dashboard/index.dart' as dash;
import 'package:my_store/pages/my_account/visitor.dart';
import 'package:my_store/pages/my_booking/index.dart';
import 'package:my_store/pages/my_account/my_account.dart';
import 'package:sizer/sizer.dart';

import 'package:my_store/providers/admin.dart';

import 'package:my_store/pages/product_list_view/get_function.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'dart:convert';

// My Own Imports
import 'package:my_store/pages/home/home_main.dart';
import 'package:my_store/pages/login_signup/login.dart';

class Home extends StatefulWidget {
  int index;
  Home(this.index);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex;
  var num = "!";
  var token = utils.CreateCryptoRandomString();

  DateTime currentBackPressTime;
  @override
  void initState() {
    super.initState();
    currentIndex = widget.index;
    set_token_not_register(context);
    m();
    EasyLoading.dismiss();
  }

  String m() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    var n = data.size.shortestSide;
    print(n);
  }

  set_token_not_register(context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var tok = localStorage.getString('token');
    var login = localStorage.getString('login');

    //if(login=="2"){
    //var data_user = localStorage.getString('user_id');
    //print(data_user);
    //}

    if (login == null || login == "0") {
      Provider.of<PostDataProvider>(context, listen: false)
          .get_shard("0", "0", "0", null);
      print(Provider.of<PostDataProvider>(context, listen: false).login);
    } else {
      var user = jsonDecode(localStorage.getString('user'));
      var user_id = user["id"];
      Provider.of<PostDataProvider>(context, listen: false)
          .get_shard(login, tok, user_id, user);
      print(Provider.of<PostDataProvider>(context, listen: false).login);
    }
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    String login2 = Provider.of<PostDataProvider>(context, listen: true).login;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(login2.toString());
          return login2 == "0"
              ? Navigator.push(
                  context,
                  PageTransition(
                      curve: Curves.linear,
                      duration: Duration(milliseconds: 400),
                      type: PageTransitionType.bottomToTop,
                      child: LoginPage()))
              : Navigator.push(
                  context,
                  PageTransition(
                      curve: Curves.linear,
                      duration: Duration(milliseconds: 900),
                      type: PageTransitionType.bottomToTop,
                      child: dash.Index()));
        },
        child: Icon(
          Icons.dashboard,
          size: 18.0.sp,
          color: Colors.blue[800],
        ),
        backgroundColor: Colors.grey[400],
      ),
      backgroundColor: Colors.grey[200],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,

        currentIndex: currentIndex,
        onTap: changePage,
        // borderRadius: BorderRadius.vertical(
        //  top: Radius.circular(
        //  16)), //border radius doesn't work when the notch is enabled.
        elevation: 8,
        type: BottomNavigationBarType.fixed,
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home,
                size: 15.0.sp,
                color: currentIndex == 0 ? Colors.blue[700] : Colors.black),
            title: Text(
              'الرئيسية',
              style: TextStyle(
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0.sp,
                  color: currentIndex == 0 ? Colors.blue[700] : Colors.black),
            ),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.date_range,
                size: 15.0.sp,
                color: currentIndex == 1 ? Colors.blue[700] : Colors.black),
            title: Text(
              'مواعيدي',
              style: TextStyle(
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0.sp,
                  color: currentIndex == 1 ? Colors.blue[700] : Colors.black),
            ),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.person,
                size: 15.0.sp,
                color: currentIndex == 2 ? Colors.blue[700] : Colors.black),
            title: Text(
              'حسابي',
              style: TextStyle(
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0.sp,
                  color: currentIndex == 2 ? Colors.blue[700] : Colors.black),
            ),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz_outlined,
                size: 15.0.sp,
                color: currentIndex == 3 ? Colors.blue[700] : Colors.black),
            title: Text(
              'المزيد',
              style: TextStyle(
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0.sp,
                  color: currentIndex == 3 ? Colors.blue[700] : Colors.black),
            ),
          )
        ],
      ),
      body: WillPopScope(
        child: (currentIndex == 0)
            ? HomeMain()
            : (currentIndex == 1)
                ? Provider.of<PostDataProvider>(context, listen: false).login ==
                        "2"
                    ? Index()
                    : LoginPage()
                : (currentIndex == 2)
                    ? Provider.of<PostDataProvider>(context, listen: false)
                                .login ==
                            "2"
                        ? MyAccount()
                        : LoginPage()
                    : (currentIndex == 3)
                        ? Visitor()
                        : HomeMain(),
        onWillPop: onWillPop,
      ),
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: "اضغط مرتين لاغلاق التطبيق",
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
