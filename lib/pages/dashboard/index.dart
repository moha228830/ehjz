import 'dart:async';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sizer/sizer.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:my_store/functions/localizations.dart';
import 'package:my_store/pages/dashboard/admin/admin.dart' as ad;
import 'package:my_store/pages/dashboard/request.dart';
import 'package:my_store/pages/home/home.dart';
import 'package:my_store/pages/login_signup/forgot_password.dart';
import 'package:my_store/pages/login_signup/login.dart';
import 'package:page_transition/page_transition.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:my_store/providers/admin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import 'package:my_store/config.dart';

import 'package:http/http.dart' as http;

import '../../helper.dart';
class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  var token = utils.CreateCryptoRandomString();
  bool _load = true;
  List data =[];
  get_data  () async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var login = localStorage.getString('login');
    //var user_id = localStorage.getString('user_id');

    if (login =="2"){
      var d = jsonDecode(localStorage.getString('user'));
      var user_id = d["id"]??"";
      try{

        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          http.Response response =
          await http.get(Config.url+"get_user_place?user_id="+user_id.toString());

        print(user_id);
          if (response.statusCode == 200) {


            var res = json.decode(response.body);
           // print(res);
            if (res["state"]=="1"){
              if (this.mounted) {
                setState(() {
                  data = res["data"];
                });
              }
              print(data);

              //  print(tok);

            }else{
              Fluttertoast.showToast(
                msg: 'مشكلة بالشبكة',
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

      if (this.mounted) {
        setState(() {
          _load = false;
        });
      }

    }else{
      if (this.mounted) {
        setState(() {
          _load = false;
        });
      }
      return false;
    }
  }

  ///end ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  @override
  void initState() {
    get_data();
    super.initState();


  }
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:Colors.grey[100] ,
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
        backgroundColor: Colors.blue[800],
      ),
      appBar: AppBar(


        title: Text(
          'ادارة نشاطاتك',style: TextStyle(fontFamily: "Cairo",color: Colors.white,fontSize: 14.0.sp,fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[700],
        elevation: 0,
        // give the app bar rounded corners
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),

      ),

      body:
      ListView(
        children: <Widget>[

          SizedBox(
            height: 1.0.h,
          ),


          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 2.0.h),
            child: Divider(
              height: 1.0,
            ),
          ),
          SizedBox(height: 10,),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft, child:Request()));
            },
            child:
            Center(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue[800])   ,
                  color: Colors.blue[700],
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2,
                      color: Colors.white,
                    ),
                  ],
                ),
              width: width-100,
                padding: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 1.0.h),

                child: Row(
                  children: [

                Expanded(flex:1,child:  Center(
                  child: Container(color: Colors.blue[700],

                    child: Icon(Icons.add,size: 30.0.sp,color: Colors.white,),
                  ),
                )),
                    Expanded(flex:4,child:  Container(

                      color: Colors.blue[700],

                        child: Container(
                          child: Text("تسجيل نشاط جديد",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.0.sp,fontFamily: "Cairo",color: Colors.white),),

                      ),
                    ))

                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 2.0.h),
            child: Divider(
              color: Colors.grey,
              height: 1.0,
            ),
          ),
          SizedBox(height: 20,),

          Center(
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
              width: width-100,
              padding: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 1.0.h),

              child:
              Row(
                children: [
                  Expanded(flex:1,child:  Center(
                    child: Container(



                      child: Container(
                        child: Text("لوحة تحكم حساب",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.0.sp,fontFamily: "Cairo",color: Colors.blue[700]),),

                      ),
                    ),
                  )),
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),

          _load?Center(child: CircularProgressIndicator()):
          data.length==0?
          Padding(
            padding:  EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 2.0.h),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 1.5,
                    color: Colors.grey[300],
                  ),
                ],
              ),
              child: ListTile(

                title: Text('لا تمتلك اي نشاط يسعدنا اشتراكك',style: TextStyle(letterSpacing:5,color: Colors.red,fontSize:13.0.sp,fontWeight: FontWeight.bold,fontFamily:"Cairo"),),
                selected: true,

                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft, child:Request()));

                },
              ),
            ),
          ):
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 2.0.h),
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
                      title:
                      Text('${get_by_size(data[index]["name"],30,30,"..") }',style: TextStyle(letterSpacing:5,color: Colors.indigo,fontSize:14.0.sp,fontWeight: FontWeight.bold,fontFamily:"Cairo"),),
                      subtitle:data[index]["activity"]==1?
                      Text('  صالح حتي ${ data[index]["end"]}  ',style: TextStyle(color: Colors.black,fontSize:11.0.sp,fontWeight: FontWeight.bold,fontFamily:"Cairo"),)
                      :Text('انتظار التفعيل ',style: TextStyle(color: Colors.red,fontSize:11.0.sp,fontWeight: FontWeight.bold,fontFamily:"Cairo"),),

                      trailing:data[index]["activity"]==1? Icon(Icons.arrow_forward_ios,color: Colors.indigo,size: 20.0.sp,)
                      :Icon(Icons.error,color: Colors.red,size: 20.0.sp,),
                      selected: true,
                      onTap: () {
                        if(data[index]["activity"]==0){
                          Alert(
                            context: context,
                            type: AlertType.warning,
                            style:AlertStyle(titleStyle:TextStyle(fontSize:12.0.sp,fontWeight: FontWeight.bold,fontFamily: "Cairo" ,color: Colors.indigo),
                              descStyle: TextStyle(fontSize:10.0.sp,fontWeight: FontWeight.bold,fontFamily: "Cairo" ),
                            ),
                            title: " عذرا",
                            desc:  'نشاطك لم يفعل بعد جاري دراسة طلبك من قبل الادارة وسيتم التواصل معك قريبا',
                            buttons: [
                              DialogButton(
                                child: Text(
                                  "اغلاق",
                                  style: TextStyle(color: Colors.white, fontSize: 12.0.sp,fontFamily: "Cairo",fontWeight: FontWeight.bold),
                                ),
                                onPressed: () => Navigator.pop(context),
                                color: Colors.lightBlue,
                              ),

                            ],
                          ).show();

                        }else{
                          Provider.of<PostDataProvider>(context, listen: false).set_data(data[index]["name"], data[index]["img_full_path"], data[index]["job_title"],data[index]);
                          Navigator.push(
                              context,
                              PageTransition(
                                  curve: Curves.linear,
                                  duration: Duration(milliseconds: 400),
                                  type: PageTransitionType.leftToRight,
                                  child:ad.Admin(data[index]["name"],data[index]["id"],data[index]["img_full_path"],data[index]["job_title"])));

                        }


                      },
                    ),
                  ),
                );

            },

          )
        ],
      ),
    );
  }
}
