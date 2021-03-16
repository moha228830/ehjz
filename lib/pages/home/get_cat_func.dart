import 'dart:async';
import 'dart:convert';

import 'package:my_store/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_store/functions/category_modle.dart';
import 'package:my_store/pages/product_list_view/product_class.dart';
import 'package:provider/provider.dart';

Future<List<CategoryModel>> fetchCats(http.Client client, page,offset) async {

  final response = await client
      .get(Config.url + 'home?lang=ar&page=' + page.toString()+ '&offset=' + offset.toString());

  // Use the compute function to run parseProducts in a separate isolate.

  return parseCats(response.body);

}

// A function that converts a response body into a List<Product>.
List<CategoryModel> parseCats(responseBody) {
  final parsed =
  jsonDecode(responseBody)["data"]["categories"].cast<Map<String, dynamic>>();
  //print(parsed);

  return parsed.map<CategoryModel>((json) => CategoryModel.fromJson(json)).toList();
}




