import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_store/AppTheme/AppStateNotifier.dart';
import 'package:my_store/AppTheme/appTheme.dart';
import 'package:my_store/AppTheme/my_behaviour.dart';
import 'package:my_store/config.dart';
import 'package:my_store/functions/change_language.dart';
import 'package:my_store/functions/localizations.dart';
import 'package:my_store/pages/booking_home/home.dart';
import 'package:my_store/pages/login_signup/login.dart';
import 'package:my_store/pages/product_list_view/get_function.dart';
import 'package:my_store/providers/admin.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/cupertino.dart';
import './custom_animation.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLanguage appLanguage = AppLanguage();

  await appLanguage.fetchLocale();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AppStateNotifier()),
          ChangeNotifierProvider(create: (context) => PostDataProvider()),
        ],
        child: MyApp(
          appLanguage: appLanguage,
        ),
      ),
    );
    configLoading();
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final AppLanguage appLanguage;

  MyApp({this.appLanguage});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(//return LayoutBuilder
        builder: (context, constraints) {
      return OrientationBuilder(//return OrientationBuilder
          builder: (context, orientation) {
        //initialize SizerUtil()
        SizerUtil().init(constraints, orientation); //initialize SizerUtil
        return Consumer<AppStateNotifier>(
          builder: (context, appState, child) {
            return ChangeNotifierProvider<AppLanguage>(
              create: (_) => appLanguage,
              child: Consumer<AppLanguage>(builder: (context, model, child) {
                return OverlaySupport.global(
                    child: MaterialApp(
                  title: 'MyStore',
                  debugShowCheckedModeBanner: false,
                  locale: model.appLocal,
                  supportedLocales: [
                    Locale('en', 'US'),
                    Locale('hi', ''),
                    Locale('ar', ''),
                    Locale('zh', ''),
                    Locale('id', ''),
                    Locale('ru', ''),
                  ],
                  localizationsDelegates: [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  theme: AppTheme.lightTheme,
                  darkTheme: AppTheme.darkTheme,
                  themeMode:
                      appState.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
                  builder: EasyLoading.init(
                    builder: (context, child) {
                      return ScrollConfiguration(
                        behavior: MyBehavior(),
                        child: child,
                      );
                    },
                  ),
                  home: MyHomePage(),
                ));
              }),
            );
          },
        );
      });
    });
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool progress = true;
  bool load = false;
  @override
  initState() {
    myTimer();
    fetchCats(context);

    super.initState();
  }

  myTimer() {
    Timer(const Duration(seconds: 10), () {
      if (load == true) {
        EasyLoading.show(status: 'بطئ الاتصال بالشبطة جاري الاتصال.....');
      } else {
        EasyLoading.dismiss();
      }
    });
  }

  Future fetchCats(context) async {
    try {
      setState(() {
        load = true;
      });
      final response =
          await http.get(Config.url + 'home?lang=ar&page=100&offset=0');
      if (jsonDecode(response.body)["status"] == 200) {
        print("yes");
        final List data = jsonDecode(response.body)["data"]["categories"];
        final List sliders = jsonDecode(response.body)["data"]["sildes"];
        Provider.of<PostDataProvider>(context, listen: false)
            .set_in_home(data, sliders);

        print(sliders);
        setState(() {
          load = false;
        });
        EasyLoading.dismiss();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
        );
      } else {
        print("no");
        setState(() {
          load = false;
        });
        EasyLoading.dismiss();
        Alert(
          context: context,
          type: AlertType.info,
          style: AlertStyle(
            titleStyle: TextStyle(
                fontSize: 12.0.sp,
                fontWeight: FontWeight.bold,
                fontFamily: "Cairo",
                color: Colors.indigo),
            descStyle: TextStyle(
                fontSize: 12.0.sp,
                fontWeight: FontWeight.bold,
                fontFamily: "Cairo"),
          ),
          title: "خطأ بالشبكة",
          desc:
              'لديك مشكلة في الاتصال بالانترنت تأكد من الاتصال بالانترنت وحاول مرة اخري',
          buttons: [
            DialogButton(
              child: Text(
                "اعادة تحميل",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0.sp,
                    fontFamily: "Cairo",
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                // Navigator.pop(context);
                Navigator.push(
                    context,
                    PageTransition(
                        curve: Curves.linear,
                        duration: Duration(milliseconds: 400),
                        type: PageTransitionType.bottomToTop,
                        child: MyHomePage()));
              },
              color: Colors.lightBlue,
            ),
          ],
        ).show();
      }
    } on SocketException catch (_) {
      print("no internet");
      setState(() {
        load = false;
      });
      EasyLoading.dismiss();
      Alert(
        context: context,
        type: AlertType.info,
        style: AlertStyle(
          titleStyle: TextStyle(
              fontSize: 12.0.sp,
              fontWeight: FontWeight.bold,
              fontFamily: "Cairo",
              color: Colors.indigo),
          descStyle: TextStyle(
              fontSize: 12.0.sp,
              fontWeight: FontWeight.bold,
              fontFamily: "Cairo"),
        ),
        title: "خطأ بالشبكة",
        desc:
            'لديك مشكلة في الاتصال بالانترنت تأكد من الاتصال بالانترنت وحاول مرة اخري',
        buttons: [
          DialogButton(
            child: Text(
              "اعادة تحميل",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0.sp,
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              // Navigator.pop(context);
              Navigator.push(
                  context,
                  PageTransition(
                      curve: Curves.linear,
                      duration: Duration(milliseconds: 400),
                      type: PageTransitionType.bottomToTop,
                      child: MyHomePage()));
            },
            color: Colors.lightBlue,
          ),
        ],
      ).show();
    } // Use the compute function to run parseProducts in a separate isolate.

    // return parseCats(response.body);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // var appLanguage = Provider.of<AppLanguage>(context);

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/333.png"),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
      ),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false
    ..customAnimation = CustomAnimation();
}
