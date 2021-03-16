import 'package:flutter/material.dart';
import 'package:my_store/functions/localizations.dart';

// My Own Imports
import 'package:my_store/pages/product_list_view/test.dart';

class ProductListView extends StatefulWidget {
  int id ;
  String type ;
  ProductListView(this.id ,this.type);
  @override
  _ProductListViewState createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              AppLocalizations.of(context)
                  .translate('productListViewPage', 'productString'),
              style: TextStyle(
                fontFamily: 'Jost',
                fontWeight: FontWeight.bold,
                fontSize: width/25,
                letterSpacing: 1.7,
                color:Colors.white
              ),
            ),
          // Text(
           //   '37024 ${AppLocalizations.of(context).translate('productListViewPage', 'itemsString')}',
             // style: TextStyle(
               // fontFamily: 'Jost',
               // fontWeight: FontWeight.bold,
               // fontSize: 12.0,
               // letterSpacing: 1.5,
               // color: Colors.white,
            //  ),
           // )
          ],
        ),
        titleSpacing: 0.0,
       // actions: <Widget>[
         // IconButton(
            //icon: Icon(
            //  Icons.search,
          //  ),
           // onPressed: () {
           //   Navigator.push(
               // context,
               // MaterialPageRoute(
                //    builder: (context) => Search()),
             // );
           // },
         // ),
       // ],
      ),
      body:
      Container(

          child: GetProducts(widget.id, widget.type)),
    );
  }
}
