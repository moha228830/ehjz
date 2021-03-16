import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class NewMainSlider extends StatefulWidget {
  List sliders ;
  List items ;
  NewMainSlider(this.sliders,this.items);
  @override
  _NewMainSliderState createState() => _NewMainSliderState();
}

class _NewMainSliderState extends State<NewMainSlider> {

  List items = [];
  List sliders = [];




  @override
  void initState() {

    sliders = widget.sliders;
    items = widget.items;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height/3,
      width: width,
      child:
      items.length ==0?
      Carousel(
        dotSize: 4.0,
        dotSpacing: 15.0,
        dotColor: Theme.of(context).primaryColor,
        indicatorBgPadding: 5.0,
        dotBgColor: Colors.transparent,
        borderRadius: true,
        dotVerticalPadding: 5.0,
        dotPosition: DotPosition.bottomRight,
        images: [
          InkWell(
            onTap: () {

            },
            child:Container(color: Colors.grey,width: width/2.6,height: height/6,),
          ),
          InkWell(
            onTap: () {

            },
            child:Container(color: Colors.grey,width: width/2.6,height: height/6,),
          ),
          InkWell(
            onTap: () {

            },
            child:Container(color: Colors.grey,width: width/2.6,height: height/6,),
          ),
        ],
      ):
          Carousel(
            dotSize: 4.0,
            dotSpacing: 15.0,
            dotColor: Theme.of(context).primaryColor,
            indicatorBgPadding: 5.0,
            dotBgColor: Colors.transparent,
            borderRadius: true,
            dotVerticalPadding: 5.0,
            dotPosition: DotPosition.bottomRight,
            images: items,
          )
    );
  }
}
