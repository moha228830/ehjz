import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_store/functions/place_modle.dart';
import 'dart:async';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'dart:convert';
import 'package:select_dialog/select_dialog.dart';
import 'package:my_store/config.dart';
import 'package:http/http.dart' as http;
import 'package:my_store/pages/place/one_place.dart';
import 'package:my_store/pages/place/se.dart';
import 'package:sizer/sizer.dart';


import 'dart:async' show Future, Timer;




import 'package:shimmer/shimmer.dart';

import '../../helper.dart';
class Place extends StatefulWidget {
  var id ;
  Place(this.id);

  @override
  _PlaceState createState() => _PlaceState();
}

class _PlaceState extends State<Place> {
  Map emp = {
    "id": 0,
    "name":  "المدن" ,
    "name_en": "all cities",
    "regions": [],
  };
  Map emp2 = {
    "id": 0,
    "name": "المناطق",
    "name_en": "all regions",
    "regions": [],
  };
  int type_id = 0;
  List filter = [
  {
  "type": 1,
  "name": "السعر من الاقل الي الاعلي "
  }, {
      "type": 2,
      "name": "السعر من الاعلي الي الاقل "
    },
    {
      "type": 3,
      "name": "اقل وقت انتظار"
    },

  ];
  List cities = [];
  List regions = [];
  var city_id = 0 ;
  var region_id= 0 ;
  String city_name = "المدن";
  String region_name = "المناطق";

  int num ;
  //////////////////////////////////////show city//////////////////////////////


  //////////////////////////////////////////////////////////////////////
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  Future<List<PlaceModel>> fetchCats(http.Client client, page,offset,id,keyword) async {

    if(keyword == null){
      keyword = " ";
    }
    print(id);
var data ='id='+id +'&page=' + page.toString()+
'&offset=' + offset.toString() +"&keyword="+keyword.toString()+"&city_id="+city_id.toString()
    +"&region_id="+region_id.toString()+"&type_id="+type_id.toString()
   ;
    print(data);

    final response = await client
        .get(Config.url + 'search?'+data);
    if(num !=1){

      setState(() {

        cities= jsonDecode(response.body)["data"]["cities"];
        cities.insert(0, emp);
        num = 1;
   //   print(cities);
    });
    }
    // Use the compute function to run parseProducts in a separate isolate.
    return parseCats(response.body);
  }

// A function that converts a response body into a List<Product>.
  List<PlaceModel> parseCats(responseBody) {
    final parsed =
    jsonDecode(responseBody)["data"]["all_results"].cast<Map<String, dynamic>>();
    print(parsed);

    return parsed.map<PlaceModel>((json) => PlaceModel.fromJson(json)).toList();
  }

  bool _isload = false;
  final TextEditingController _codeControl = new TextEditingController();


  bool loading = true;

  static const _pageSize = 10;

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

  void _updateSearchTerm(String searchTerm) {
    _searchTerm = searchTerm;
    _pagingController.refresh();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(pageKey) async {
    try {
      final newItems = await fetchCats(
          http.Client(), _pageSize, pageKey, widget.id.toString(), _searchTerm);


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
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
        backgroundColor: Colors.grey[100],

        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.blue[700],
          title:
          Container(
            padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
            child: Row(
              children: [


                Expanded(
                  flex: 2,
                  child: InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white)   ,
                         borderRadius: BorderRadius.circular(10.0),

                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          getDeviceType()=="small"?
                          Text("${get_by_size(city_name,7,7,"")}",style: TextStyle(color: Colors.white,fontSize: 9.0.sp,fontFamily: "Cairo"),)

                        :Text("${get_by_size(city_name,8,8,"")}",style: TextStyle(color: Colors.white,fontSize: 10.0.sp,fontFamily: "Cairo"),),
                          Icon(Icons.arrow_downward,color: Colors.white,)
                        ],
                      ),
                    ),
                    onTap: () {
                      SelectDialog.showModal(
                        context,
                        label: "اختر المدينة",
                        items: cities,
                        selectedValue: city_name,
                        itemBuilder:
                            (BuildContext context,  item, bool isSelected) {
                          return Container(
                            decoration: !isSelected
                                ? null
                                : BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            child: ListTile(
                              onTap: (){
                                setState(() {
                                  city_name = item["name"];
                                  city_id = item["id"];
                                  regions = item["regions"];
                                  regions.insert(0, emp2);
                                  region_name = "المناطق";
                                  region_id = 0;
                                });

                                _pagingController.refresh();

                                Navigator.pop(context);
                              },
                              selected: isSelected,
                              title: Text(item["name"],style: TextStyle(fontFamily: "Cairo",fontWeight: FontWeight.bold,fontSize: 12.0.sp),),
                            ),
                          );
                        },

                      );
                    },
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  flex: 2,
                  child: InkWell(

                    child:
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white)   ,
                        borderRadius: BorderRadius.circular(10.0),

                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          getDeviceType()=="small"?
                          Text("${get_by_size(region_name,7,7,"")}",style: TextStyle(color: Colors.white,fontSize:  9.0.sp,fontFamily: "Cairo"),)
                          :

                          Text("${get_by_size(region_name,8,8,"")}",style: TextStyle(color: Colors.white,fontSize:  10.0.sp,fontFamily: "Cairo"),),
                          Icon(Icons.arrow_downward,color: Colors.white,)
                        ],
                      ),
                    ),
                    onTap: () {
                      SelectDialog.showModal(
                        context,
                        label: "اختر المنطقة ",
                        items: regions,
                        selectedValue: region_name,
                        itemBuilder:
                            (BuildContext context,  item, bool isSelected) {
                          return Container(
                            decoration: !isSelected
                                ? null
                                : BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            child: ListTile(
                              onTap: (){
                                setState(() {
                                  region_name = item["name"];
                                  region_id = item["id"];
                                });
                                _pagingController.refresh();

                                Navigator.pop(context);
                              },
                              selected: isSelected,
                              title: Text(item["name"],style: TextStyle(fontFamily: "Cairo",fontWeight: FontWeight.bold,fontSize: 12.0.sp)
                            ),
                            ),
                          );
                        },

                      );
                    },
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  flex: 1,
                  child: InkWell(


                    child: Center(child: Icon(Icons.sort,color: Colors.white, size: 15.0.sp,),),
                    onTap: () {
                      SelectDialog.showModal(
                        context,
                        label: "ترتيب البيانات حسب ",
                        items: filter,
                        itemBuilder:
                            (BuildContext context,  item, bool isSelected) {
                          return Container(
                            decoration: !isSelected
                                ? null
                                : BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            child: ListTile(
                              onTap: (){
                                setState(() {

                                  type_id = item["type"];
                                });
                                _pagingController.refresh();

                                Navigator.pop(context);
                              },
                              selected: isSelected,
                              title: Text(item["name"],style: TextStyle(fontFamily: "Cairo",fontWeight: FontWeight.bold,fontSize: 12.0.sp)
                            ),
                            ),
                          );
                        },

                      );
                    },
                  ),
                ),

              ],
            ),
          ),
          titleSpacing: 0.0,
        ),

        body:
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
                      child: CatGridView(cats: item),

                    ),
                  )
                      :

                  CatGridView(cats: item,)
              ),
            ),

          ],
        )


    );
  }


}





