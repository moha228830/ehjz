import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async' show Future, Timer;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_spinkit/flutter_spinkit.dart';


import 'package:my_store/pages/product_list_view/filter_row.dart';
import 'package:my_store/functions/passDataToProducts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:my_store/pages/product_list_view/product_class.dart';
import 'package:my_store/pages/product_list_view/get_function.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class ProductsGridView extends StatefulWidget {
   var products;
   int num;

  ProductsGridView({Key key, this.products,this.num}) : super(key: key);

  @override
  _ProductsGridViewState createState() => _ProductsGridViewState();
}

class _ProductsGridViewState extends State<ProductsGridView> {
  InkWell getStructuredGridCell(Product products) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).appBarTheme.color,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              blurRadius: 0.7,
              color: Colors.grey,
            ),
          ],
        ),

          child: SingleChildScrollView(
            child: Column(

              children: <Widget>[
                Hero(
                  tag: Text("${products.id}"),
                  child: Container(
                    height: ((height - 160) / 3.5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: NetworkImage(products.imgFullPath),
                        fit: BoxFit.fill,
                      ),
                    ),
                    margin: EdgeInsets.all(6.0),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: 6.0, left: 6.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Text(
                          products.name,
                          style: TextStyle(
                            fontSize: width / 25,
                            fontFamily: 'Jost',
                            letterSpacing: 0.8,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.headline6.color,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "${products.overPrice} KW ",
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                fontSize: width / 25,
                                fontWeight: FontWeight.bold,
                                color:
                                    Theme.of(context).textTheme.headline6.color,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              width: 6.0,
                            ),
                            Text(
                              "${products.price.toString()} KW ",
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  fontSize: width / 25,
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              width: 6.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

      ),
      onTap: () {
        if(products.type==1) {

        }else{

        }

      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return getStructuredGridCell(widget.products);
  }
}
