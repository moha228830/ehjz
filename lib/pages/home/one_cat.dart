import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async' show Future, Timer;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_store/functions/category_modle.dart';
import 'package:my_store/pages/category/category.dart';
import 'package:my_store/pages/place/place.dart';
import 'package:sizer/sizer.dart';

import 'package:my_store/pages/product_list_view/filter_row.dart';
import 'package:my_store/functions/passDataToProducts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';
import 'package:my_store/pages/product_list_view/product_class.dart';
import 'package:my_store/pages/product_list_view/get_function.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

class CatGridView extends StatefulWidget {
  var cats;

  CatGridView({Key key, this.cats}) : super(key: key);

  @override
  _CatGridViewState createState() => _CatGridViewState();
}

class _CatGridViewState extends State<CatGridView> {
   getStructuredGridCell(CategoryModel products) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    return
      Container(
        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(width/35),
          boxShadow: [
            BoxShadow(
              blurRadius: 1.5,
              color: Colors.grey[200],
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 2.0.h),
        child: Container(
          decoration: BoxDecoration(
            // color: Colors.lightBlue,
            borderRadius: BorderRadius.circular(width/40),
            boxShadow: [
              BoxShadow(
                blurRadius: 1.5,
                color: Colors.grey[200],
              ),
            ],
          ),

            child: Container(
              decoration: BoxDecoration(
                // color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 1.5,
                    color: Colors.white,
                  ),
                ],
              ),
              child: InkWell(
                  onTap: () {
                    if(widget.cats.hasChild==1){
                      Navigator.push(
                          context,
                          PageTransition(
                              curve: Curves.linear,
                              duration: Duration(milliseconds: 400),

                              type: PageTransitionType.bottomToTop,
                              child:Category(widget.cats.id,widget.cats.nameAr)));
                    }else{
                      Navigator.push(
                          context,
                          PageTransition(
                              curve: Curves.linear,
                              duration: Duration(milliseconds: 400),

                              type: PageTransitionType.bottomToTop,
                              child:Place(widget.cats.id)));
                    }

                  },
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 1.0.h,),
                          Center(
                            child: Card(

                              color: Colors.blue[700],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100.0)),
                              child: Padding(
                                padding:  EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 1.0.h),
                                child:  Container(
                                  margin:  EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 1.0.h),
                                  height: 7.0.h,
                                  width: 7.0.h,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.blue[700])   ,
                                      image: DecorationImage(
                                        image: NetworkImage(widget.cats.imgFullPath),
                                        fit: BoxFit.fill,
                                      ),

                                      //color: Colors.blue[700 ]
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 0.5.h),
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                widget.cats.nameAr,
                                textAlign: TextAlign.center,
                                style: TextStyle(letterSpacing:5,color: Colors.black,fontSize: 12.0.sp,fontWeight: FontWeight.w500,fontFamily: "Cairo"),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
            ),

        ));


  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return getStructuredGridCell(widget.cats);
  }
}
