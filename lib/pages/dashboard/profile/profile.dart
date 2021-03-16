import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_store/functions/drawer.dart';
import 'package:my_store/functions/localizations.dart';
import 'package:my_store/pages/dashboard/admin/admin.dart' as ad;
import 'package:my_store/pages/dashboard/profile/data.dart';
import 'package:page_transition/page_transition.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:my_store/providers/admin.dart';
import 'package:sizer/sizer.dart';

import '../../../helper.dart';

class Profile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
var data = Provider.of<PostDataProvider>(context, listen: true) ;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor:Colors.grey[100] ,
        appBar: AppBar(
          backgroundColor: Colors.blue[700],

          title: Text(
            '${get_by_size(data.place["name"],30,30,"..")}',style: TextStyle(fontFamily: "Cairo",color: Colors.white,fontSize: 13.0.sp,fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 5,
          // give the app bar rounded corners
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),

        ),

        body:SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
      Container(padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [



              Expanded(child:  Container(
                padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(

                    border: Border.all(color: Colors.white)   ,
                    color: Colors.blue[700],
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft, child:Data()));
                    },
                    child: Center(child:
                  Text("تعديل البيانات",style: TextStyle(color: Colors.white,fontSize: 14.0.sp,fontWeight: FontWeight.bold,fontFamily:"Cairo"),),
                  ),
                  )
              )
              ),

      ],)),
              Container(
                padding:EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 1.0.h),
                child:  Container(
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

                    leading:Text('اسم النشاط :',style: TextStyle(letterSpacing:5,color: Colors.black,fontSize: width/26,fontWeight: FontWeight.bold,fontFamily:"Cairo"),),

                    title:Text('${data.place["name"]}',style: TextStyle(letterSpacing:5,color: Colors.indigo,fontSize: width/26,fontWeight: FontWeight.bold,fontFamily:"Cairo"),),

                    selected: true,
                    onTap: () {

                    },
                  ),
                ),
              ),

              Container(
                padding:EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 1.0.h),
                child:  Container(
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
                    leading:Text('المسمي الوظيفي :',style: TextStyle(color: Colors.black,fontSize: width/26,fontWeight: FontWeight.bold,fontFamily:"Cairo"),),

                    title:Text('${data.place["job_title"]} ',style: TextStyle(letterSpacing:5,color: Colors.indigo,fontSize: width/26,fontWeight: FontWeight.bold,fontFamily:"Cairo"),),

                    selected: true,
                    onTap: () {

                    },
                  ),
                ),
              ),
              Container(
                padding:EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 1.0.h),
                child:  Container(
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
                  ),              child: ListTile(
                    leading:Text('التخصص :',style: TextStyle(color: Colors.black,fontSize: width/26,fontWeight: FontWeight.bold,fontFamily:"Cairo"),),

                    title:Text('${data.place["specialization"]} ',style: TextStyle(letterSpacing:5,color: Colors.indigo,fontSize: width/26,fontWeight: FontWeight.bold,fontFamily:"Cairo"),),

                    selected: true,
                    onTap: () {

                    },
                  ),
                ),
              ),

              Container(
                padding:EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 1.0.h),
                child:  Container(
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
                    leading:Text('سعر الكشف :',style: TextStyle(color: Colors.black,fontSize: width/26,fontWeight: FontWeight.bold,fontFamily:"Cairo"),),

                    title:Text('${data.place["price"]??0.0}  دينار كويتي',style: TextStyle(letterSpacing:5,color: Colors.indigo,fontSize: width/26,fontWeight: FontWeight.bold,fontFamily:"Cairo"),),

                    selected: true,
                    onTap: () {

                    },
                  ),
                ),
              ),
              Container(
                padding:EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 1.0.h),
                child:  Container(
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
                    leading:Text(' القسم :',style: TextStyle(color: Colors.black,fontSize: width/26,fontWeight: FontWeight.bold,fontFamily:"Cairo"),),

                    title:Text('${data.place["category"]} ',style: TextStyle(letterSpacing:5,color: Colors.indigo,fontSize: width/26,fontWeight: FontWeight.bold,fontFamily:"Cairo"),),

                    selected: true,
                    onTap: () {

                    },
                  ),
                ),
              ),
              Container(
                padding:EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 1.0.h),
                child:  Container(
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
                    leading:Text('المدينة :',style: TextStyle(color: Colors.black,fontSize: width/26,fontWeight: FontWeight.bold,fontFamily:"Cairo"),),

                    title:Text('${data.place["city"]} ',style: TextStyle(letterSpacing:5,color: Colors.indigo,fontSize: width/26,fontWeight: FontWeight.bold,fontFamily:"Cairo"),),

                    selected: true,
                    onTap: () {

                    },
                  ),
                ),
              ),
              Container(
                padding:EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 1.0.h),
                child:  Container(
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
                    leading:Text('المنطقة :',style: TextStyle(color: Colors.black,fontSize: width/26,fontWeight: FontWeight.bold,fontFamily:"Cairo"),),

                    title:Text('${data.place["region"]} ',style: TextStyle(letterSpacing:5,color: Colors.indigo,fontSize: width/26,fontWeight: FontWeight.bold,fontFamily:"Cairo"),),

                    selected: true,
                    onTap: () {

                    },
                  ),
                ),
              ),
              Container(
                padding:EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 1.0.h),
                child:  Container(
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
                    leading:Text('هاتف النشاط :',style: TextStyle(color: Colors.black,fontSize: width/26,fontWeight: FontWeight.bold,fontFamily:"Cairo"),),

                    title:Text('${data.place["phone"]} ',style: TextStyle(letterSpacing:5,color: Colors.indigo,fontSize: width/26,fontWeight: FontWeight.bold,fontFamily:"Cairo"),),

                    selected: true,
                    onTap: () {

                    },
                  ),
                ),
              ),
              Container(
                padding:EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 1.0.h),
                child:  Container(
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
                    leading:Text('وقت الانتظار :',style: TextStyle(color: Colors.black,fontSize: width/27,fontWeight: FontWeight.bold,fontFamily:"Cairo"),),

                    title:Text('${data.place["waiting_time"]??0}  دقيقة ',style: TextStyle(letterSpacing:5,color: Colors.indigo,fontSize: width/26,fontWeight: FontWeight.bold,fontFamily:"Cairo"),),

                    selected: true,
                    onTap: () {

                    },
                  ),
                ),
              ),

              SizedBox(height: 10,),

            ],
          ),
        ),
        drawer:
        Drawer(
          child:
          My_Drawer(),
        ),

      ),
    );
  }
}
