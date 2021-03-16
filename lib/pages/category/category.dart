import 'package:flutter/material.dart';
import 'package:my_store/functions/localizations.dart';
import 'package:my_store/pages/category/get_data_cat.dart';
import 'package:sizer/sizer.dart';

class Category extends StatefulWidget {
  int id ;
  String name;
    Category(this.id,this.name);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();




  bool _isload = false;
  final TextEditingController _codeControl = new TextEditingController();


  //////////////login //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


  ///end ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blue[700],

        title: Text(
          '${widget.name}',style: TextStyle(fontFamily: "Cairo",color: Colors.white,fontSize: 14.0.sp,fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        // give the app bar rounded corners
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),

      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 10,),

          Container(

              child: GetCats(widget.id)),

        ],
      ),
      bottomNavigationBar: new Container(
        padding: EdgeInsets.all(0.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[

            Expanded(
             child:SizedBox(height: 10,)
            ),
          //  Expanded(
            //  flex: 1,
            //  child: FlatButton.icon(
               // onPressed: () {
              //  },
              //  icon: Icon(Icons.search),
             //   label: Text("Search"),
              //),
           // ),
          ],
        ),
      ),

    );

  }
  _appBar(height) =>
      PreferredSize(
    preferredSize:  Size(MediaQuery.of(context).size.width, height+80 ),
    child: Stack(
      children: <Widget>[
        Container(     // Background
          child: Row(

            children: [
              SizedBox(width: 20,),

              InkWell(onTap: (){
                Navigator.of(context).pop();
              },
                  child: Icon(Icons.arrow_back_ios,color: Colors.black,)),
              SizedBox(width: 30,),
              Center(
                child: Text("المراكز الطبية ", style: TextStyle(fontSize: 20,fontFamily: "Lemonada",
                    fontWeight: FontWeight.w600,
                    color: Colors.white),),),
            ],
          ),
          color:Colors.lightBlue[400],
          height: height+75,
          width: MediaQuery.of(context).size.width,
        ),

        Container(),   // Required some widget in between to float AppBar

        Positioned(    // To take AppBar Size only
          top: 100.0,
          left: 20.0,
          right: 20.0,
          child: AppBar(
            backgroundColor: Colors.white,
            leading: Icon(Icons.menu, color:Colors.indigo,),
            primary: false,
            title: TextField(
                decoration: InputDecoration(
                    hintText: "ما الذي تبحث عنه",
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey))),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search, color: Colors.indigo), onPressed: () {},),
           //   IconButton(icon: Icon(Icons.notifications, color: Theme.of(context).primaryColor),
               // onPressed: () {},)
            ],
          ),
        ),
        SizedBox(height: 10,)

      ],
    ),
  );

}
