import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_store/pages/product_list_view/product_list_view.dart';
import 'package:my_store/providers/admin.dart';
import 'package:provider/provider.dart';

class MainSlider extends StatefulWidget {

  @override
  _MainSliderState createState() => _MainSliderState();
}

class _MainSliderState extends State<MainSlider> {
  List sliders ;
  @override
  void initState() {
    sliders = Provider.of<PostDataProvider>(context, listen: false).sliders ;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return sliders.length > 0?
    Container(
      // height: 305.0,
      padding: EdgeInsets.only(bottom: 0.0),
      child: Column(
        children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
              height: height/3.5 ,
              autoPlay: true,
              aspectRatio: 16/9,
              autoPlayInterval: const Duration(seconds: 6),
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 1.0,
              enlargeCenterPage: true,
            ),
            items: [
              for (var i = 0; i < sliders.length; i++)
              InkWell(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => ProductListView()));
                },
                child: Container(
                  margin: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    image: DecorationImage(
                      image: NetworkImage("${sliders[i]["img_full_path"]}"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),


            ],

          ),
        ],
      ),
    )
      :Container(
      // height: 305.0,
      padding: EdgeInsets.only(bottom: 0.0),
      child: Column(
        children: <Widget>[
          CarouselSlider(
      options: CarouselOptions(
            height: height/3.5 ,
            autoPlay: true,
            aspectRatio: 16/9,
            autoPlayInterval: const Duration(seconds: 6),
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            viewportFraction: 1.0,
            enlargeCenterPage: true,
      ),
            items: [
              InkWell(
                onTap: () {
                 // Navigator.push(context, MaterialPageRoute(builder: (context) => ProductListView()));
                },
                child: Container(
                  margin: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    image: DecorationImage(
                        image: AssetImage("assets/home_slider/e.png"),
                        fit: BoxFit.cover,
                      ),
                  ),
                ),
              ),

              InkWell(
                onTap: () {
                 // Navigator.push(context, MaterialPageRoute(builder: (context) => ProductListView()));
                },
                child: Container(
                  margin: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    image: DecorationImage(
                        image: AssetImage("assets/home_slider/e.png"),
                        fit: BoxFit.cover,
                      ),
                  ),
                ),
              ),

              InkWell(
                onTap: () {
                //  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductListView()));
                },
                child: Container(
                  margin: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    image: DecorationImage(
                        image: AssetImage("assets/home_slider/e.png"),
                        fit: BoxFit.cover,
                      ),
                  ),
                ),
              ),
            ],

          ),
        ],
      ),
    );
  }
}