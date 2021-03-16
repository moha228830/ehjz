import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_store/functions/place_modle.dart';
import 'dart:async';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:my_store/pages/login_signup/activation.dart';
import 'package:my_store/pages/login_signup/login.dart';
import 'package:my_store/pages/singlePlace/appoinment.dart';
import 'package:my_store/pages/singlePlace/future_houer.dart';
import 'dart:convert';
import 'package:select_dialog/select_dialog.dart';
import 'package:my_store/config.dart';
import 'package:http/http.dart' as http;
import 'package:my_store/pages/place/one_place.dart';
import 'package:my_store/pages/place/se.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'dart:async' show Future, Timer;

import 'package:shimmer/shimmer.dart';

import '../../helper.dart';

class Index extends StatefulWidget {
  var cats;
  Index(this.cats);
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  List days = [];
  var select;
  bool load = true;
  Future<List> fetchCats() async {
    final response =
        await http.get(Config.url + 'place/id/' + widget.cats.id.toString());
    setState(() {
      days = jsonDecode(response.body)["data"]["days"];
      print(days);
      load = false;

      //   print(cities);
    });
  }
  // Use the compute function to run parseProducts in a separate isolate.

  bool _isload = false;
  final double circleRadius = 110.0;
  final double circleBorderWidth = 8.0;

  //////////////is_login //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  get_shard(place_id, date) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var login = localStorage.getString('login');
    //var user =localStorage.getString('user');

    print(login);
    if (login == "0") {
      return Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return LoginPage();
          },
        ),
      );
    } else if (login == "1") {
      return Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return Activation();
          },
        ),
      );
    } else if (login == "2") {
      var d = localStorage.getString('user');
      var data = jsonDecode(d) ?? [];
      return Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return Future_houer(widget.cats, data, select, place_id, date);
          },
        ),
      );
    } else {
      return Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return LoginPage();
          },
        ),
      );
    }
  }

  ///end ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  @override
  void initState() {
    fetchCats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: Text(
          "${get_by_size(widget.cats.name, 32, 32, "...")}",
          style: TextStyle(
            fontFamily: 'Cairo',
            color: Colors.white,
            fontSize: 14.0.sp,
            letterSpacing: 1.7,
            fontWeight: FontWeight.bold,
          ),
        ),
        titleSpacing: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: ListView(
          children: [
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                // background image and bottom contents
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue[800]),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            color: Colors.grey[300],
                          ),
                        ],
                      ),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10, 60, 10, 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Center(
                              child: Text(
                                " ${get_by_size(widget.cats.name, 32, 32, "...")}",
                                style: TextStyle(
                                  fontSize: 14.0.sp,
                                  color: Colors.indigo,
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    new Text(
                                      '${get_by_size(widget.cats.specialization, 30, 30, "...")}',
                                      style: TextStyle(
                                          fontSize: 10.0.sp,
                                          fontFamily: 'Cairo',
                                          color: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .color),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        my_showDialog(
                                            "تفاصيل النشاط",
                                            widget.cats.specialization,
                                            context);
                                      },
                                      child: new Text(
                                        '..المزيد',
                                        style: TextStyle(
                                            fontSize: 10.0.sp,
                                            fontFamily: 'Cairo',
                                            color: Colors.blue[700]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Flexible(
                                child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  color: Colors.grey[200],
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.star,
                                          color: (widget.cats.stars == 0)
                                              ? Colors.grey[500]
                                              : Colors.orange,
                                          size: 18.0),
                                      Icon(Icons.star,
                                          color: (widget.cats.stars == 1 ||
                                                  widget.cats.stars == 0)
                                              ? Colors.grey[500]
                                              : Colors.orange,
                                          size: 18.0),
                                      Icon(Icons.star,
                                          color: (widget.cats.stars == 1 ||
                                                  widget.cats.stars == 2 ||
                                                  widget.cats.stars == 0)
                                              ? Colors.grey[500]
                                              : Colors.orange,
                                          size: 18.0),
                                      Icon(Icons.star,
                                          color: (widget.cats.stars == 1 ||
                                                  widget.cats.stars == 2 ||
                                                  widget.cats.stars == 3 ||
                                                  widget.cats.stars == 0)
                                              ? Colors.grey[500]
                                              : Colors.orange,
                                          size: 18.0),
                                      Icon(Icons.star,
                                          color: (widget.cats.stars == 1 ||
                                                  widget.cats.stars == 2 ||
                                                  widget.cats.stars == 3 ||
                                                  widget.cats.stars == 4 ||
                                                  widget.cats.stars == 0)
                                              ? Colors.grey[500]
                                              : Colors.orange,
                                          size: 18.0),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: widget.cats.sum == 0
                                      ? Text(
                                          "انضم حديثا",
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: width / 28,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Cairo',
                                          ),
                                        )
                                      : Text(
                                          " من ${widget.cats.sum}  زائر ",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: width / 28,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Cairo"),
                                        ),
                                )
                              ],
                            )),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            ListTile(
                              contentPadding:
                                  EdgeInsets.only(left: 5, right: 5),
                              dense: true,
                              visualDensity:
                                  VisualDensity(horizontal: 0, vertical: -4),
                              leading: Icon(
                                Icons.add_location_alt,
                                color: Colors.lightBlue,
                                size: 15.0.sp,
                              ),
                              title: Text(
                                ' ${widget.cats.address} ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10.0.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Cairo"),
                              ),
                              //trailing: Icon(Icons.arrow_forward_ios,color: Colors.lightBlue,),
                              selected: true,
                              onTap: () {},
                            ),
                            ListTile(
                              contentPadding:
                                  EdgeInsets.only(left: 5, right: 5),
                              dense: true,
                              visualDensity:
                                  VisualDensity(horizontal: 0, vertical: -4),
                              leading: Icon(
                                Icons.monetization_on,
                                color: Colors.lightBlue,
                                size: 15.0.sp,
                              ),
                              title: Row(
                                children: [
                                  Text(
                                    ' سعر الكشف ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10.0.sp,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Cairo"),
                                  ),
                                  Text(
                                    '  ${widget.cats.price} د.كـ ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10.0.sp,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Cairo"),
                                  ),
                                ],
                              ),
                              //trailing: Icon(Icons.arrow_forward_ios,color: Colors.lightBlue,),
                              selected: true,
                              onTap: () {},
                            ),
                            ListTile(
                              contentPadding:
                                  EdgeInsets.only(left: 5, right: 5),
                              dense: true,
                              visualDensity:
                                  VisualDensity(horizontal: 0, vertical: -4),
                              leading: Icon(
                                Icons.alarm_on,
                                color: Colors.lightBlue,
                                size: 15.0.sp,
                              ),
                              title: Text(
                                ' مدة الانتظار ${widget.cats.waitingTime} دقيقة ',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 10.0.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Cairo"),
                              ),
                              //trailing: Icon(Icons.arrow_forward_ios,color: Colors.lightBlue,),
                              selected: true,
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // Profile image
                Positioned(
                  top: 0, // (background container size) - (circle height / 2)
                  child: Container(
                    height: 110.0,
                    width: 110.0,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue[700]),
                        image: DecorationImage(
                          image: NetworkImage(widget.cats.imgFullPath),
                          fit: BoxFit.cover,
                        ),
                        shape: BoxShape.circle,
                        color: Colors.lightBlue[200]),
                  ),
                ),
                Positioned(
                    left: 15,
                    top:
                        60, // (background container size) - (circle height / 2)
                    child: Icon(
                      Icons.favorite,
                      color: Colors.grey,
                    ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Container(
                  width: width,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue[800]),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2,
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                  height:
                      getDeviceType() != "small" ? height / 2 : height / 1.8,
                  child: Container(
                      child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: new Text(
                          ' احجز الان وسيتم ارسال العنوان ورقم المركز والتواصل معك',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              fontSize: 10.0.sp,
                              color:
                                  Theme.of(context).textTheme.headline6.color,
                              fontFamily: "Cairo"),
                        ),
                      ),
                      load
                          ? Container(
                              height: 100,
                              child: Center(child: CircularProgressIndicator()))
                          : days.length == 0
                              ? Container(
                                  height: 200,
                                  child: Center(
                                      child: Text(
                                    "لا يوجد مواعيد متاحة",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontFamily: "Cairo",
                                        fontSize: 12.0.sp),
                                  )))
                              : Container(
                                  height: height / 2.3,
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Center(
                                              child:
                                                  Icon(Icons.arrow_back_ios))),
                                      Expanded(
                                        flex: 13,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount:
                                              days == null ? 0 : days.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            Map cat = days[index];
                                            return Row(
                                              children: [
                                                SizedBox(width: 5.0),
                                                InkWell(
                                                  onTap: () {},
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height: 20.0,
                                                      ),
                                                      Column(
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                select = cat;
                                                              });
                                                              return get_shard(
                                                                  cat["place_id"],
                                                                  cat["date"]);
                                                            },
                                                            child: Container(
                                                              width:
                                                                  width / 2.6,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .lightBlue,
                                                              ),
                                                              child: Center(
                                                                child:
                                                                    Container(
                                                                  color: Colors
                                                                      .lightBlue,
                                                                  padding: EdgeInsets.fromLTRB(
                                                                      width /
                                                                          20,
                                                                      height /
                                                                          80,
                                                                      width /
                                                                          20,
                                                                      height /
                                                                          80),
                                                                  child: Text(
                                                                    "${cat["first"]}",
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          "Cairo",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          width /
                                                                              27,
                                                                      color: Colors
                                                                          .white,
                                                                      letterSpacing:
                                                                          1.5,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                select = cat;
                                                              });
                                                              return get_shard(
                                                                  cat["place_id"],
                                                                  cat["date"]);
                                                            },
                                                            child: Container(
                                                              width:
                                                                  width / 2.6,
                                                              height:
                                                                  getDeviceType() ==
                                                                          "tablet"
                                                                      ? 18.0.h
                                                                      : 15.0.h,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              child: Center(
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Container(
                                                                      color: Colors
                                                                          .white,
                                                                      padding: EdgeInsets.fromLTRB(
                                                                          width /
                                                                              20,
                                                                          height /
                                                                              80,
                                                                          width /
                                                                              20,
                                                                          height /
                                                                              80),
                                                                      child:
                                                                          Text(
                                                                        "من ${cat["start"]}",
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'Cairo',
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontSize:
                                                                              width / 28,
                                                                          color:
                                                                              Colors.black,
                                                                          letterSpacing:
                                                                              1.5,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      color: Colors
                                                                          .white,
                                                                      padding: EdgeInsets.fromLTRB(
                                                                          width /
                                                                              20,
                                                                          height /
                                                                              80,
                                                                          width /
                                                                              20,
                                                                          height /
                                                                              80),
                                                                      child:
                                                                          Text(
                                                                        "الي ${cat["finsh"]}",
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'Cairo',
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontSize:
                                                                              width / 28,
                                                                          color:
                                                                              Colors.black,
                                                                          letterSpacing:
                                                                              1.5,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                select = cat;
                                                              });
                                                              return get_shard(
                                                                  cat["place_id"],
                                                                  cat["date"]);
                                                            },
                                                            child: Container(
                                                              width:
                                                                  width / 2.6,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    Colors.red,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                ],
                                                              ),
                                                              child: Center(
                                                                child:
                                                                    Container(
                                                                  color: Colors
                                                                      .red,
                                                                  padding: EdgeInsets.fromLTRB(
                                                                      width /
                                                                          20,
                                                                      height /
                                                                          80,
                                                                      width /
                                                                          20,
                                                                      height /
                                                                          80),
                                                                  child: Text(
                                                                    "احجز",
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Cairo',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          width /
                                                                              27,
                                                                      color: Colors
                                                                          .white,
                                                                      letterSpacing:
                                                                          1.5,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 5.0),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                      Expanded(
                                          child: Center(
                                              child: Icon(
                                                  Icons.arrow_forward_ios))),
                                    ],
                                  ),
                                ),
                    ],
                  )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
