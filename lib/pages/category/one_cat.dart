import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async' show Future, Timer;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_store/functions/category_modle.dart';
import 'package:my_store/pages/place/place.dart';


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


    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: InkWell(

        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).appBarTheme.color,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                color: Colors.grey[300],
              ),
            ],
          ),

          child:  CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: widget.cats.imgFullPath,
              placeholder: (context, url) =>  Center(child: Container(height: 80,width: 80, child: CircularProgressIndicator())),
              errorWidget: (context, url, error) =>  Center(child: Icon(Icons.error)),
            ),


        ),

        onTap: () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child:Place(products.id) ));
        },
      ),
    );


  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return getStructuredGridCell(widget.cats);
  }
}
