import 'dart:async';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_store/functions/place_modle.dart';
import 'package:my_store/pages/place/get_place_func.dart';
import 'package:my_store/pages/place/one_place.dart';
import 'package:my_store/pages/place/se.dart';


import 'dart:async' show Future, Timer;




import 'package:shimmer/shimmer.dart';


class GetCats extends StatefulWidget {
  var id;
  GetCats(this.id);

  @override
  _GetCatsState createState() => _GetCatsState();
}

class _GetCatsState extends State<GetCats> {
  bool loading = true;

  static const _pageSize = 2;

  final PagingController<int, PlaceModel> _pagingController =
  PagingController(firstPageKey: 0);

  String _searchTerm;

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

    _pagingController.addStatusListener((status) {
      if (status == PagingStatus.subsequentPageError) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Something went wrong while fetching a new page.',
            ),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: () => _pagingController.retryLastFailedRequest(),
            ),
          ),
        );
      }
    });

    super.initState();
  }

  Future<void> _fetchPage(pageKey) async {
    try {
      final newItems = await fetchCats(http.Client(), _pageSize,pageKey,widget.id.toString(),_searchTerm);


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
      CustomScrollView(
    slivers: <Widget>[
      CharacterSearchInputSliver(
        onChanged: (searchTerm) => _updateSearchTerm(searchTerm),
      ),
      PagedSliverList<int, PlaceModel>(
        pagingController: _pagingController,

        builderDelegate: PagedChildBuilderDelegate<PlaceModel>(

  itemBuilder: (context, item, index) =>

  (loading)
  ? Container(

  margin: EdgeInsets.only(top: 10.0),
  child: Shimmer.fromColors(
  baseColor: Colors.grey[300],
  highlightColor: Colors.white,
  child:CatGridView(cats: item),

  ),
  )
      :

  CatGridView(cats: item,)
  ),
        ),

    ],
  );

  void _updateSearchTerm(String searchTerm) {
    _searchTerm = searchTerm;
    _pagingController.refresh();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}