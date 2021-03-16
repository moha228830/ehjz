import 'dart:async';
import 'dart:convert';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:my_store/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_store/pages/product_list_view/product_class.dart';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async' show Future, Timer;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_spinkit/flutter_spinkit.dart';


import 'package:my_store/pages/product_list_view/filter_row.dart';
import 'package:my_store/functions/passDataToProducts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:my_store/pages/product_list_view/product_class.dart';
import 'package:my_store/pages/product_list_view/get_function.dart';
import 'package:my_store/pages/product_list_view/one_product.dart';

import 'dart:async';
import 'package:http/http.dart' as http;
class GetProducts extends StatefulWidget {
  int id;
  String type;
  GetProducts(this.id, this.type);
  @override
  _GetProductsState createState() => _GetProductsState();
}

class _GetProductsState extends State<GetProducts> {
  bool loading = true, all = true, men = false, women = false;
  static const _pageSize = 2;
int num = 0;
  final PagingController<int, Product> _pagingController =
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
      final newItems = await fetchProducts(http.Client(), widget.id, widget.type,_pageSize,pageKey);
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
      PagedGridView<int, Product>(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
          childAspectRatio: (MediaQuery.of(context).size.width/1.3 / MediaQuery.of(context).size.width),

        ),
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Product>(
          itemBuilder: (context, item, index) =>

                  (loading)
                      ? Container(

                    margin: EdgeInsets.only(top: 10.0),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.white,
                      child: ProductsGridView(products: item,num:num),
                    ),
                  )
                      : Container(
                    height: MediaQuery.of(context).size.height/2.7,

                    child: ProductsGridView(products: item,num:num),
                  ),


        ),
      );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

}
