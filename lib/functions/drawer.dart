import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_store/pages/dashboard/admin/admin.dart';
import 'package:my_store/pages/dashboard/appoinments/appoinment.dart';
import 'package:my_store/pages/dashboard/profile/profile.dart';
import 'package:my_store/pages/dashboard/my_date/my_date.dart';
import 'package:my_store/pages/dashboard/request.dart';
import 'package:my_store/pages/home/home.dart';
import 'package:my_store/providers/admin.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';


import 'package:http/http.dart' as http;

import '../helper.dart';
class My_Drawer extends StatelessWidget {
  int place_id ;
  var name  ;

  My_Drawer();
  @override
  Widget build(BuildContext context) {
var img =Provider.of<PostDataProvider>(context, listen: true).place["img_full_path"] ;
var job =Provider.of<PostDataProvider>(context, listen: true).place["job_title"] ;
var name =Provider.of<PostDataProvider>(context, listen: true).place["name"] ;
var place_id =Provider.of<PostDataProvider>(context, listen: true).place["id"] ;

    return
      Container(
        color: Colors.blue[700],
        child: SafeArea(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '${get_by_size(name,26,26,"..")}',style: TextStyle(fontFamily: "Cairo",fontWeight: FontWeight.bold,color: Colors.black,fontSize: 12.0.sp),),
              ),
              Divider(
                height: 1,
                thickness: 1,
              ),
              ListTile(
                leading: Icon(Icons.dashboard,color: Colors.white,size: 15.0.sp,),
                title: Text('لوحة التحكم',style: TextStyle(fontFamily: "Cairo",fontWeight: FontWeight.bold,color: Colors.white,fontSize: 12.0.sp),),
                //selected: _selectedDestination == 1,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>Admin(name, place_id, img, job),
                    ),
                  );
                },
              ),
              Divider(
                height: 1,
                thickness: 1,
              ),
              ListTile(
                leading: Icon(Icons.date_range,color: Colors.white,size: 15.0.sp,),
                title: Text('المواعيد',style: TextStyle(fontFamily: "Cairo",fontWeight: FontWeight.bold,color: Colors.white,fontSize: 12.0.sp),),
                //selected: _selectedDestination == 1,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>My_date(place_id),
                    ),
                  );
                },
              ),
              Divider(
                height: 1,
                thickness: 1,
              ),
              ListTile(
                leading: Icon(Icons.alarm,color: Colors.white,size: 15.0.sp),
                title: Text('الحجز',style: TextStyle(fontFamily: "Cairo",fontWeight: FontWeight.bold,color: Colors.white,fontSize: 12.0.sp),),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context)=>Appoinments(),
                    ),
                  );
                },
              ),
              Divider(
                height: 1,
                thickness: 1,
              ),

              ListTile(
                leading: Icon(Icons.location_city,color: Colors.white,size: 15.0.sp),
                title: Text('بيانات النشاط',style: TextStyle(fontFamily: "Cairo",fontWeight: FontWeight.bold,color: Colors.white,fontSize: 12.0.sp),),
                //selected: _selectedDestination == 3,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context)=>Profile(),
                    ),
                  );
                },
              ),
              Divider(
                height: 1,
                thickness: 1,
              ),

              ListTile(
                leading: Icon(Icons.home,color: Colors.white,size: 15.0.sp),
                title: Text('الصفحة الرئيسية',style: TextStyle(fontFamily: "Cairo",fontWeight: FontWeight.bold,color: Colors.white,fontSize: 12.0.sp),),
                //selected: _selectedDestination == 3,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>Home(0),
                    ),
                  );
                },
              ),

              Divider(
                height: 1,
                thickness: 1,
              ),

              ListTile(
                leading: Icon(Icons.add,color: Colors.white,size: 15.0.sp),
                title: Text('تسجيل نشاط جديد',style: TextStyle(fontFamily: "Cairo",fontWeight: FontWeight.bold,color: Colors.white,fontSize: 12.0.sp),),
                //selected: _selectedDestination == 3,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>Request(),
                    ),
                  );
                },
              ),
              Divider(
                height: 1,
                thickness: 1,
              ),
            ],
          ),
        ),
      );
  }
}
