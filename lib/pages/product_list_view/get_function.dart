import 'dart:async';
import 'dart:convert';

import 'package:my_store/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_store/pages/product_list_view/product_class.dart';
import 'package:provider/provider.dart';

Future<List<Product>> fetchProducts(http.Client client, id, type,page,offset) async {
  final response = await client
      .get(Config.url + 'items?type=' + type + '&sub_id=' + id.toString()
      +  '&page=' + page.toString()+ '&offset=' + offset.toString());

  // Use the compute function to run parseProducts in a separate isolate.
  return parseProducts(response.body);
}

// A function that converts a response body into a List<Product>.
List<Product> parseProducts(responseBody) {
  final parsed =
      jsonDecode(responseBody)["data"]["items"].cast<Map<String, dynamic>>();
  print(parsed);

  return parsed.map<Product>((json) => Product.fromJson(json)).toList();
}


Future  cart_num(token) async {
  final response = await http
      .get(Config.url + 'cart_num?token='+token) ;

  // Use the compute function to run parseProducts in a separate isolate.
  var res=jsonDecode(response.body);
  if( res["state"]=="1"){
    return res["data"];
  }
  return "0";

}

class PostDataProvider2 with ChangeNotifier {
  var num ;
  String m = "fefefe";
  List<Product> post = [];
  bool loading = false;

  getPostData(http.Client client, id, type,page,offset) async {
    loading = true;
    post = await fetchProducts(client, id, type,page,offset);

    loading = false;
    return post;

    notifyListeners();
  }

   cat_num(token) async {

    num = await cart_num(token);

     notifyListeners();

  }

  c (){
    print (num);
    return num ;
  }

  second() {
    return post;
    notifyListeners();
  }
}
