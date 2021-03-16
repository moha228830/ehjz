import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_store/functions/category_modle.dart';
import 'package:my_store/functions/localizations.dart';
import 'package:my_store/pages/home//get_cat_func.dart';
import 'package:my_store/pages/home//one_cat.dart';
import 'package:my_store/providers/admin.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:my_store/helper.dart';


import 'dart:async' show Future, Timer;




import 'package:shimmer/shimmer.dart';

import '../../config.dart';

class GetCats extends StatefulWidget {


  @override
  _GetCatsState createState() => _GetCatsState();
}

class _GetCatsState extends State<GetCats> {
  bool loading = true;
  static const _pageSize = 6 ;
  int num = 0;
 List cats=[];
  List sliders=[];
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      if (this.mounted) {
        setState(() {
          loading = false;
        });
      }
    });
    cats = Provider.of<PostDataProvider>(context, listen: false).home_category ;
    super.initState();
  }




  @override
  Widget build(BuildContext context) =>
      GridView.builder(
  itemCount: cats.length,
  shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 2,

  ),

  itemBuilder: (BuildContext context, int index) {
  return Container(

            child:CatGridView(cats: CategoryModel.fromJson(cats[index]) ),
          );




});

}
