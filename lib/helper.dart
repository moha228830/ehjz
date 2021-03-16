import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

String get_by_size(name,check,print,dot){
  if(name.length > check){
    return name.substring(0, print) + dot;
  }
  return name ;

 }


String getDeviceType() {
  final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  return data.size.shortestSide >= 600 ? 'tablet':
  data.size.shortestSide >= 412 ?
  'phone' : "small";
}


 get_val_size() {
  final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  return   data.size.shortestSide ;

}
my_showDialog(title,body,context) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text(title,style: TextStyle(color: Colors.blue[700] ,fontSize: 12.0.sp,fontWeight: FontWeight.bold,fontFamily: "Cairo"),),
        content: new Text(body,style: TextStyle(color: Colors.black ,fontSize: 10.0.sp,fontWeight: FontWeight.bold,fontFamily: "Cairo"),),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("اغلاق",style: TextStyle(color: Colors.red ,fontSize: 10.0.sp,fontWeight: FontWeight.bold,fontFamily: "Cairo"),),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
