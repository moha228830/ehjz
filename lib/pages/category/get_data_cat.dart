import 'dart:async';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_store/functions/category_modle.dart';
import 'package:my_store/pages/category/get_cat_func.dart';
import 'package:my_store/pages/category/one_cat.dart';
import 'package:sizer/sizer.dart';


import 'dart:async' show Future, Timer;




import 'package:shimmer/shimmer.dart';

import '../../helper.dart';

class GetCats extends StatefulWidget {
  int id;
  GetCats(this.id);

  @override
  _GetCatsState createState() => _GetCatsState();
}

class _GetCatsState extends State<GetCats> {
  bool loading = true, all = true, men = false, women = false;
  static const _pageSize = 8;
  int num = 0;
  final PagingController<int, CategoryModel> _pagingController =
  PagingController(firstPageKey: 0);

  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      if (this.mounted) {
        setState(() {
          loading = false;
        });
      }
    });
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await fetchCats(http.Client(), _pageSize,pageKey,widget.id.toString());
      setState(() {
        num = newItems.length;
      });
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) =>
      PagedListView<int, CategoryModel>(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),

        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<CategoryModel>(
          itemBuilder: (context, item, index) =>

          (loading)
              ? Container(

            margin: EdgeInsets.only(top: 20.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.white,
              child:CatGridView(cats: item),
            ),
          )
              : Container(
            height:getDeviceType()=="tablet"?20.0.h:getDeviceType()=="phone"?19.2.h:19.0.h,
            margin:getDeviceType()=="tablet"?  EdgeInsets.only(top: 12)
                :getDeviceType()=="phone"?EdgeInsets.only(top: 10):EdgeInsets.only(top: 10),
            child:CatGridView(cats: item),
          ),



        ),
      );



}
