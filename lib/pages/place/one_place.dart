import 'package:flutter/material.dart';
import 'package:my_store/helper.dart';

import 'package:my_store/functions/place_modle.dart';

import 'package:sizer/sizer.dart';

import 'package:my_store/config.dart';
import 'package:my_store/pages/singlePlace/index.dart';


class CatGridView extends StatefulWidget {
  var cats;

  CatGridView({Key key, this.cats}) : super(key: key);

  @override
  _CatGridViewState createState() => _CatGridViewState();
}

class _CatGridViewState extends State<CatGridView> {

  getStructuredGridCell(PlaceModel products) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    return
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue[800])   ,
          color: Theme.of(context).appBarTheme.color,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              color: Colors.white,
            ),
          ],
        ),
        padding: EdgeInsets.all(0),
        width: width,
       // height:  (52.0.h * get_val_size() ) / 392.722,        //getDeviceType()=="tablet"?55.0.h :getDeviceType()=="phone"? 50.0.h:52.0.h,
        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 27.0.w,
                          height: 15.0.h,
                          decoration: BoxDecoration(


                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image: NetworkImage(widget.cats.imgFullPath),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        widthSpace,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Text(
                              " ${get_by_size(products.name,26,26,"..")}",
                              style: TextStyle(
                                fontSize: 13.0.sp,
                                color: Colors.blue[800],
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                              ),
                            ),


                            SizedBox(height: 5,),
                            Text(
                              "${get_by_size(products.jobTitle,26,26,"...")}",
                              style: TextStyle(
                                fontSize: 13.0.sp,
                                color: Colors.black,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5,),

                            Row(
                              children: [
                                Container(
                                  padding:EdgeInsets.all(10),
                                  color: Colors.grey[100],
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[

                                      Icon(Icons.star,
                                          color: ( products.stars==0)
                                              ? Colors.grey[500]
                                              : Colors.orange,
                                          size: 18.0),
                                      Icon(Icons.star,
                                          color: (products.stars == 1 || products.stars== 0)
                                              ? Colors.grey[500]
                                              : Colors.orange,
                                          size: 18.0),
                                      Icon(Icons.star,
                                          color: (products.stars == 1 ||
                                              products.stars == 2 || products.stars==0)
                                              ? Colors.grey[500]
                                              : Colors.orange,
                                          size: 18.0),
                                      Icon(Icons.star,
                                          color: (products.stars == 1 ||
                                              products.stars == 2 ||
                                              products.stars == 3 || products.stars==0)
                                              ? Colors.grey[500]
                                              : Colors.orange,
                                          size: 18.0),
                                      Icon(Icons.star,
                                          color: (products.stars == 1 ||
                                              products.stars == 2 ||
                                              products.stars == 3 ||
                                              products.stars == 4 || products.stars==0)
                                              ? Colors.grey[500]
                                              : Colors.orange,
                                          size: 18.0),

                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child:products.sum==0?Text("انضم حديثا",style: TextStyle(color: Colors.red[700],fontSize: width/28,fontWeight: FontWeight.bold,fontFamily: "Cairo"),):
                                  Text(" من ${products.sum}  زائر ",style: TextStyle(color: Colors.red[700],fontSize: width/28,fontWeight: FontWeight.bold,fontFamily: "Cairo"),),
                                )
                              ],

                            ),


                          ],
                        ),
                      ],
                    ),

                  ],
                ),
              ),
              SizedBox(height: 15,),
              ListTile(
                contentPadding: EdgeInsets.only(left: 5, right: 5),
                dense:true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(Icons.location_city,color: Colors.lightBlue,size: 18.0.sp,),
                title: Text(' ${get_by_size(products.specialization,30,30,"...")} ',style: TextStyle(color: Colors.black,fontSize: 12.0.sp,fontWeight: FontWeight.bold,fontFamily: "Cairo"),),
                //trailing: Icon(Icons.arrow_forward_ios,color: Colors.lightBlue,),
                selected: true,
                onTap: () {

                },
              ),


              ListTile(
                contentPadding: EdgeInsets.only(left: 5, right: 5),
                dense:true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(Icons.location_on,color: Colors.lightBlue,size: 18.0.sp,),
                title: Text(' ${get_by_size(products.address,30,30,"...")} ',style: TextStyle(color: Colors.black,fontSize: 12.0.sp,fontWeight: FontWeight.bold,fontFamily: "Cairo"),),
                //trailing: Icon(Icons.arrow_forward_ios,color: Colors.lightBlue,),
                selected: true,
                onTap: () {

                },
              ),

              ListTile(
                contentPadding: EdgeInsets.only(left: 5, right: 5),
                dense:true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(Icons.monetization_on,color: Colors.lightBlue,size: 18.0.sp,),
                title: Row(
                  children: [
                    Text(' سعر الكشف ',style: TextStyle(color: Colors.black ,fontSize: 12.0.sp,fontWeight: FontWeight.bold,fontFamily: "Cairo"),),
                    Text('  ${products.price}  د.كـ  ',style: TextStyle(color: Colors.black,fontSize: 12.0.sp,fontWeight: FontWeight.bold,fontFamily: "Cairo"),),

                  ],
                ),
                //trailing: Icon(Icons.arrow_forward_ios,color: Colors.lightBlue,),
                selected: true,
                onTap: () {

                },
              ),



              ListTile(
                contentPadding: EdgeInsets.only(left: 5, right: 5),
                dense:true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(Icons.alarm,color: Colors.lightBlue,size: 19.0.sp,),
                title: Text(' مدة الانتظار ${products.waitingTime} دقيقة ',style: TextStyle(color: Colors.red[700],fontSize: 12.0.sp,fontWeight: FontWeight.bold,fontFamily: "Cairo"),),
                //trailing: Icon(Icons.arrow_forward_ios,color: Colors.lightBlue,),
                selected: true,
                onTap: () {

                },
              ),

              Row(
                children: [

                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                      child: InkWell(
                        child: Container(
                          height: width/9,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),

                          ),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Text("اقرب موعد  ${widget.cats.time.first}  ",style: TextStyle(color: Colors.blue[800],fontSize: width/24,fontWeight: FontWeight.bold,fontFamily: "Cairo"),),

                            ],),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                      child: InkWell(
                        onTap: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return Index(widget.cats);
                              },
                            ),
                          );
                        },
                        child: Container(
                          height: width/9,
                          decoration: BoxDecoration(
                            color: Colors.blue[700],
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 1.5,
                                color: Colors.grey[300],
                              ),
                            ],
                          ),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Text("احجز",style: TextStyle(color: Colors.white,fontSize: 12.0.sp,fontWeight: FontWeight.bold,fontFamily: "Cairo"),),

                            ],),
                        ),
                      ),
                    ),
                  ),

                ],
              ),


            ],
          ),
        ),
      );


  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return getStructuredGridCell(widget.cats);
  }
}
