import 'dart:async';
import 'dart:convert';

import 'package:my_store/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_store/functions/place_modle.dart';
import 'package:my_store/pages/product_list_view/product_class.dart';
import 'package:provider/provider.dart';

Future<List<PlaceModel>> fetchCats(http.Client client, page,offset,id,keyword) async {
  print(page.toString());
  print(keyword.toString().trim());
  if(keyword == null){
    keyword = " ";
  }
  final response = await client
      .get(Config.url + 'search?id='+id +'&page=' + page.toString()+
      '&offset=' + offset.toString() +"&keyword="+keyword.toString()??" ");

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



