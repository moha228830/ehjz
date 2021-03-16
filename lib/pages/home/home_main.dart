import 'package:flutter/material.dart';
import 'package:my_store/functions/header.dart';
import 'package:my_store/pages/home/get_data_cat.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:sizer/sizer.dart';

import 'home_component/main_slider.dart';
class HomeMain extends StatefulWidget {

  @override
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {

  @override
  final kHintTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 15.0.sp,
  );

  final kLabelStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  var kBoxDecorationStyle = BoxDecoration(
    color: Colors.purple,
    borderRadius: BorderRadius.circular(10.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 6.0,
        offset: Offset(0, 2),
      ),
    ],
  );
  final controller = ScrollController();
  double offset = 0;
///////////////////////////////////////////////////////

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(onScroll);
  }
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return
      ListView(
children: [
  Stack(
    children: [
      MyHeader(
        image: "assets/2.png",
        textTop: "LOGIN ",
        textBottom: "",
        offset: offset,
      ),
      Center(
        child: Container(
          width: double.infinity,
            margin:EdgeInsets.fromLTRB(10, 80, 10, 0),
              child: MainSlider()),
      )
    ],
  ),


  SizedBox(
    height: width/40,
  ),

   Row(
     children: [
       Expanded(
         child:Text(" "),
       ),
       Expanded(
         flex: 2,
         child: InkWell(
           onTap: (){
             showSimpleNotification(
                 Text("جاري اضافة التذكير بالدواء في التحديث القادم للتطبيق", style: TextStyle(fontSize: 11.0.sp,fontFamily: "Cairo"),),
                 background: Colors.green);
           },
           child: Container(
             height: width/10,
             decoration: BoxDecoration(
               color: Colors.blue[700],
               borderRadius: BorderRadius.circular(10.0),
               boxShadow: [
                 BoxShadow(
                   blurRadius: 1.5,
                   color: Colors.grey[300],
                 ),
               ],
             ),
             child:
             Row(mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Icon(Icons.alarm,color: Colors.white,size: 17.0.sp,),

                 Text(" التذكير بالدواء ",style: TextStyle(letterSpacing:5,color: Colors.white,fontSize: 15.0.sp,fontWeight: FontWeight.bold,fontFamily: "Cairo"),),

               ],),
           ),
         ),
       ),
       Expanded(
         child:Text(" "),
       ),
     ],
   ),
  SizedBox(height: width/22,),

  Padding(
    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
    child: Container(


      child: GetCats(),
    ),
  ),
  SizedBox(height: 20,)
],
    );
  }
}
class _MenuItem {
  final IconData icon;
  final String title;

  _MenuItem(this.icon, this.title);
}