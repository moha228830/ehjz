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
import 'package:overlay_support/overlay_support.dart';
import 'package:sizer/sizer.dart';

import 'package:http/http.dart' as http;


class Add_appoinment extends StatefulWidget {
 List all_day ;
  var cats ;
  var type;
  int place_id;
  var token ;
  Add_appoinment(this.cats,this.type,this.place_id,this.token,this.all_day);

  @override
  _Add_appoinmentState createState() => _Add_appoinmentState();
}

class _Add_appoinmentState extends State<Add_appoinment> {
  bool _isload = false;

  final format = DateFormat("HH:mm");
  TextEditingController _startTimeController = TextEditingController();
  TextEditingController _endTimeController = TextEditingController();
  @override
  void initState() {


    super.initState();
  }
  add_data() async {



      try {

        if (_startTimeController.text
            .trim()
            .isEmpty ||  _endTimeController.text
            .trim()
              .isEmpty  ) {
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
              .post(Config.url + "add_appointment", headers: {
            "Accept": "application/json"
          }, body: {
            "strat_in": _startTimeController.text,
            "end_in": _endTimeController.text,
            "place_id": widget.place_id.toString(),
            "token":widget.token,
            "date":widget.cats["date"].toString(),
            "day":widget.cats["day"],
            "only_day":widget.cats["only_day"].toString(),
            "only_month":widget.cats["only_month"].toString(),
            "only_year":widget.cats["only_year"].toString(),


          });



          final data = jsonDecode(response.body);
       print(data);
          if (data["state"] == "1") {

            showSimpleNotification(
                Text("تمت الاضافة بنجاح", style: TextStyle(fontSize: 12.0.sp,fontFamily: "Cairo"),),
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
                Text("الموعد موجود بالفعل", style: TextStyle(fontSize: 12.0.sp,fontFamily: "Cairo"),),
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
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(padding: EdgeInsets.fromLTRB(20, 2, 20, 2),
                      child: Text(" الموعد من ",style: TextStyle(fontFamily: "Cairo",fontSize: 12.0.sp),)),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Row(
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
                          child:  DateTimeField(
                            controller: _startTimeController,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                            style: TextStyle(color: Colors.blue[700], fontSize: 32),
                            format: format,
                            onShowPicker: (context, currentValue) async {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                              );
                              return DateTimeField.convert(time);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(padding: EdgeInsets.fromLTRB(20, 2, 20, 2),
                      child: Text("الموعد الي",style: TextStyle(fontFamily: "Cairo",fontSize: 12.0.sp),)),

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
                          ),                   width: width-50,
                          child:  DateTimeField(
                            controller: _endTimeController,
                            decoration: InputDecoration(
//        suffixIcon: IconButton(icon: Icon(Icons.close, color: Colors.white,), onPressed: state.clear,),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
//                                      initialValue: yesterday10pm,
                            style: TextStyle(color: Colors.blue[700], fontSize: 32),
                            format: format,
                            onShowPicker: (context, currentValue) async {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                              );
                              return DateTimeField.convert(time);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(),

              SizedBox(height: 20,),

             _isload?Center(child: CircularProgressIndicator()): InkWell(
                onTap: () {
                  if(widget.type !=1){
                    add_data();
                  }else{
                    showSimpleNotification(
                        Text("لا يمكنك اضافة موعد في تاريخ ماضي", style: TextStyle(fontSize: 12.0.sp,fontFamily: "Cairo"),),
                        background: Colors.red);
                  }
                },
                child:Container(
                  height: 6.0.h,
                  width: width/2,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),

                    color: Colors.blue[700],
                    elevation: 6.0,
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