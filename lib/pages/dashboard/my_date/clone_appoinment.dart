import 'dart:math';
import 'package:overlay_support/overlay_support.dart';
import 'package:sizer/sizer.dart';

import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:my_store/functions/localizations.dart';
import 'package:my_store/pages/dashboard/my_date/my_houer.dart';
import 'package:numberpicker/numberpicker.dart';
import 'dart:convert';
import 'dart:io';
import 'package:my_store/config.dart';
import 'package:select_dialog/select_dialog.dart';

import 'package:http/http.dart' as http;



class Clone extends StatefulWidget {
  List all_day ;
  var token ;
  var cats ;
  var type;
  int place_id;
  Clone(this.cats,this.type,this.place_id,this.token, this.all_day);

  @override
  _CloneState createState() => _CloneState();
}

class _CloneState extends State<Clone> {
  bool _isload = false;
  List<String> val=[] ;


  List<String> ex5 = [];
  map(){
    for (int i = 0; i < widget.all_day.length; i++) {

        val.add(widget.all_day[i]["day"].toString() + " " +widget.all_day[i]["date"]);

    }
   // print(val);
  }

  add_data() async {



    try {

      if (ex5.length==0) {
        showSimpleNotification(
            Text("اكمل البيانات", style: TextStyle(fontSize: 12.0.sp,fontFamily: "Cairo"),),
            background: Colors.red);
      }  else {
        if (this.mounted) {
          setState(() {
            _isload = true;
          });
        }
        final response = await http
            .post(Config.url + "add_clone", headers: {
          "Accept": "application/json"
        }, body: {

          "place_id": widget.place_id.toString(),
          "token":widget.token,
          "date":widget.cats["date"].toString(),
          "days":ex5.join(","),



        });



        final data = jsonDecode(response.body);
        print(data);
        if (data["state"] == "1") {

          showSimpleNotification(
              Text("تم نسخ المواعيد بنجاح", style: TextStyle(fontSize: 12.0.sp,fontFamily: "Cairo"),),
              background: Colors.green);

          return Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return My_houer(widget.place_id, widget.cats["date"], widget.cats["day"], widget.cats, widget.token,widget.all_day,widget.type);
              },
            ),
          );


        }

        else if (data["state"] == "404") {
          showSimpleNotification(
              Text("هذا اليوم لا يحتوي علي اي مواعيد", style: TextStyle(fontSize: 12.0.sp,fontFamily: "Cairo"),),
              background: Colors.red);
        }
        else {
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


    if (this.mounted) {
      setState(() {
        _isload = false;
      });
    }
  }
  @override
  void initState() {
map();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Text("سيتم نسخ مواعيد هذا اليوم الي اليوم الذي تحدده",style: TextStyle(fontFamily: "Cairo",fontWeight: FontWeight.bold,color: Colors.blue,fontSize: 12.0.sp),)),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 3.0.h,),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),

                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
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
                          width: width-50,
                          height: 8.0.h,

                          child:
                          InkWell(
                            child: Center(
                              child: Text(
                                ex5.isEmpty ? "اختر الايام " : ex5.join(", "),style:TextStyle(fontFamily: "Cairo"
                              ,fontSize: 14.0.sp,fontWeight: FontWeight.bold,color: Colors.blue[700]),
                              ),
                            ),
                            onTap: () {
                              SelectDialog.showModal<String>(
                                context,
                                label: "انسخ بيانات هذا اليوم الي",
                                multipleSelectedValues: ex5,
                                items: val,
                                itemBuilder: (context, item, isSelected) {
                                  return ListTile(
                                    trailing: isSelected ? Icon(Icons.check) : null,
                                    title: Text( item,style: TextStyle(fontSize: 12.0.sp,fontFamily: "Cairo",fontWeight: FontWeight.bold),),
                                    selected: isSelected,
                                  );
                                },
                                onMultipleItemsChange: (List selected) {
                                  setState(() {
                                    ex5 = selected;
                                    print(ex5.join(","));
                                  });
                                },
                                okButtonBuilder: (context, onPressed) {
                                  return Align(
                                    alignment: Alignment.centerRight,
                                    child: FloatingActionButton(
                                      onPressed: onPressed,
                                      child: Icon(Icons.check),
                                      mini: true,
                                    ),
                                  );
                                },
                              );
                            },
                          ),

                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20,),

              _isload?Center(child: CircularProgressIndicator()):InkWell(
                onTap: () {
                  add_data();
                },
                child:Container(
                  height: 7.0.h,
                  width: width/2,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.blue[700],
                    elevation: 7.0,
                    child: GestureDetector(
                      child: Center(
                        child:
                        Text("اضافة",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Cairo',
                            fontSize: 12.0.sp,
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}