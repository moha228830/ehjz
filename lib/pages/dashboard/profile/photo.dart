import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_store/functions/localizations.dart';
import 'package:my_store/pages/dashboard/index.dart';
import 'package:my_store/pages/home/home.dart';
import 'package:my_store/pages/login_signup/forgot_password.dart';
import 'package:my_store/pages/login_signup/login.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:page_transition/page_transition.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import 'package:my_store/config.dart';
import 'package:sizer/sizer.dart';

import 'package:http/http.dart' as http;
class Request extends StatefulWidget {
  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> {

  var _currentSelectedValue;
  var _currentSelectedValue2;
  var _currentSelectedValue3;
  final _namecontroller = TextEditingController();
  final _desccontroller = TextEditingController();
  final _jobcontroller = TextEditingController();
  final _addresscontroller = TextEditingController();
  final _pricecontroller = TextEditingController();

  List <String> names = [];
  List cities = [];
  List cats = [];

  List regions = [];
  var city_id = 0 ;
  var region_id= 0 ;
  var cat_id= 0 ;
  String cat_name = "اختر القسم";

  String city_name = "اختر المدينة";
  String region_name = " اختر المنطقة";


  filter_name(){
    if(_namecontroller.text.trim().length > 30 || _namecontroller.text.trim().length<4){
      Fluttertoast.showToast(
        msg: "اسم النشاط من 4 الي 30 حرف",
        backgroundColor: Theme
            .of(context)
            .textTheme
            .headline6
            .color,
        textColor: Theme
            .of(context)
            .appBarTheme
            .color,
      );
      return false ;

    }else{
      return true ;
    }
  }

  filter_desc(){
    if(_desccontroller.text.trim().length > 300 || _desccontroller.text.trim().length<4){
      Fluttertoast.showToast(
        msg: "التخصص من 4 الي 300 حرف",
        backgroundColor: Theme
            .of(context)
            .textTheme
            .headline6
            .color,
        textColor: Theme
            .of(context)
            .appBarTheme
            .color,
      );
      return false ;

    }else{
      return true ;
    }
  }
  filter_job(){
    if(_jobcontroller.text.trim().length > 30 || _jobcontroller.text.trim().length<4){
      Fluttertoast.showToast(
        msg: "المجال او المسمي الوظيفي من 4 الي 30 حرف",
        backgroundColor: Theme
            .of(context)
            .textTheme
            .headline6
            .color,
        textColor: Theme
            .of(context)
            .appBarTheme
            .color,
      );
      return false ;

    }else{
      return true ;
    }
  }
  filter_address(){
    if(_addresscontroller.text.trim().length > 35 || _addresscontroller.text.trim().length<4){
      Fluttertoast.showToast(
        msg: "العنوان من 4 الي 35 حرف",
        backgroundColor: Theme
            .of(context)
            .textTheme
            .headline6
            .color,
        textColor: Theme
            .of(context)
            .appBarTheme
            .color,
      );
      return false ;

    }else{
      return true ;
    }
  }

  bool _load = true;
  bool _isload = false;
  File _image;
  final picker = ImagePicker();


  _imgFromGallery() async {
    // ignore: deprecated_member_use
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    setState(() {
      _image = image;
      print(_image);
    });
  }

  get_cities  () async{
    try{

      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        http.Response response =
        await http.get(Config.url+"get_cities");


        if (response.statusCode == 200) {


          var res = json.decode(response.body);
          if (res["state"]=="1"){
            if (this.mounted) {
              setState(() {
                cities = res["data"]["cities"];
                cats =  res["data"]["cats"];
                Alert(
                  context: context,
                  type: AlertType.info,
                  style:AlertStyle(titleStyle:TextStyle(fontSize:12.0.sp,fontWeight: FontWeight.bold,fontFamily: "Cairo" ,color: Colors.indigo),
                    descStyle: TextStyle(fontSize:12.0.sp,fontWeight: FontWeight.bold,fontFamily: "Cairo" ),
                  ),
                  title: "مرحبا بك معنا",
                  desc:  'سجل نشاطك الان واحصل علي ثلاث اشهر مجانية وبعد الثلاث اشهر قيمة الاشتراك 10 دينار كويتي شهريا',
                  buttons: [
                    DialogButton(
                      child: Text(
                        "موافق",
                        style: TextStyle(color: Colors.white, fontSize: 12.0.sp,fontFamily: "Cairo",fontWeight: FontWeight.bold),
                      ),
                      onPressed: () => Navigator.pop(context),
                      color: Colors.lightBlue,
                    ),

                  ],
                ).show();
              });
            }
            //print(cartItemList.length);

            //  print(tok);

          }else{
            Fluttertoast.showToast(
              msg: 'مشكلة بالشبكة',
              backgroundColor: Theme.of(context).textTheme.headline6.color,
              textColor: Theme.of(context).appBarTheme.color,
            );

          }


        }
      }else{
        Fluttertoast.showToast(
          msg: 'no internet ',
          backgroundColor: Theme.of(context).textTheme.headline6.color,
          textColor: Theme.of(context).appBarTheme.color,
        );
      }
    } on SocketException {

      Fluttertoast.showToast(
        msg: 'no internet ',
        backgroundColor: Theme.of(context).textTheme.headline6.color,
        textColor: Theme.of(context).appBarTheme.color,
      );
    }

    if (this.mounted) {
      setState(() {
        _load = false;
      });
    }
  }
  my_activate() async {


    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var login = localStorage.getString('login');
    var d = jsonDecode(localStorage.getString('user'));
    var user_id = d["id"];
    if (login =="2"){
      var token = localStorage.getString('token');
      try {

        if (_namecontroller.text.trim().isEmpty ||_jobcontroller.text.trim().isEmpty
            || _desccontroller.text.trim().isEmpty || _addresscontroller.text.trim().isEmpty
            || cat_id==0 ||city_id==0||region_id==0 || _image==null
        ) {
          showSimpleNotification(Text('اكمل البيانات', style: TextStyle(fontSize: 12.0.sp,fontFamily: "Cairo"),),
              background: Colors.red);
        }  else {
          // filter_name();
          if(filter_name()==true){
            // filter_job();
            if(filter_job()==true){
              //filter_desc();
              if(filter_desc()==true){
                // filter_address();
                if(filter_address()==true){
                  if (this.mounted) {
                    setState(() {
                      _isload = true;
                    });
                  }

                  //create multipart request for POST or PATCH method
                  var request = http.MultipartRequest("POST", Uri.parse(Config.url + "add_place"));
                  //add text fields
                  request.fields["token"] = token;
                  request.fields["name"] = _namecontroller.text;
                  request.fields["price"] = _pricecontroller.text;
                  request.fields["job_title"] = _jobcontroller.text;
                  request.fields["specialization"] = _desccontroller.text;
                  request.fields["address"] = _addresscontroller.text;
                  request.fields["region_id"] = region_id.toString();
                  request.fields["user_id"] = user_id.toString();
                  request.fields["category_id"] =cat_id.toString();
                  request.fields["city_id"] =city_id.toString();

                  //create multipart using filepath, string or bytes
                  var pic = await http.MultipartFile.fromPath("photo", _image.path);
                  //add multipart to request
                  request.files.add(pic);
                  var streamedResponse = await request.send();
                  var response = await http.Response.fromStream(streamedResponse);
                  print(response.body);


                  var prif = SharedPreferences.getInstance();

                  final data = jsonDecode(response.body);
                  print(data["msg"]);
                  if (data["state"] == "1") {


                    showSimpleNotification(Text('تم تحديث البيانات بنجاح', style: TextStyle(fontSize: 12.0.sp,fontFamily: "Cairo"),),
                        background: Colors.green);

                    return Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child:Index()));
                  }

                  else {
                    AwesomeDialog(
                        context: context,
                        animType: AnimType.LEFTSLIDE,
                        headerAnimationLoop: true,
                        dialogType: DialogType.ERROR,
                        title: 'خطأ',
                        desc:
                        'اكمل البيانات وتاكد ان الصورة لا تزيد عن 4 ميجا و ان الصورة jpg / png /jpeg',
                        btnOkOnPress: () {

                        },
                        btnOkIcon: Icons.error,btnOkColor: Colors.red,
                        onDissmissCallback: () {

                        })
                      ..show();

                    //01155556624
                    if (this.mounted) {
                      setState(() {
                        _isload = false;
                      });
                    }
                  }
                  // _showDialog (data["state"],m);



                }
              }

            }

          }




        }
      } on SocketException catch (_) {
        Fluttertoast.showToast(
          msg: AppLocalizations.of(context).translate('loginPage', 'no_net'),
          backgroundColor: Theme
              .of(context)
              .textTheme
              .headline6
              .color,
          textColor: Theme
              .of(context)
              .appBarTheme
              .color,
        );
      }
    }else{
      Fluttertoast.showToast(
        msg: 'قم بتسجيل الدخول اولا',
        backgroundColor: Theme.of(context).textTheme.headline6.color,
        textColor: Theme.of(context).appBarTheme.color,
      );
    }
  }

  ///end ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  @override
  void initState() {
    get_cities();


    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:Colors.grey[100],

      appBar: AppBar(


        title: Text(
          'طلب تسجيل نشاط',style: TextStyle(fontFamily: "Cairo",color: Colors.white,fontSize: 13.0.sp,fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        elevation: 0,
        // give the app bar rounded corners
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),

      ),
      body: _load?Center(child: CircularProgressIndicator()):
      ListView(
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 10.0),

                InkWell(
                  onTap: _imgFromGallery,
                  child: Container(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:BorderRadius.circular(100)
                        ),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    height: 15.0.h,
                    width: 15.0.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                          image:_image==null? AssetImage(
                              'assets/user_profile/profile.png'
                          ):FileImage(_image),
                          fit: BoxFit.cover
                      ),
                    ),
                  ),
                ),



                Container(
                  width: width - 10,
                  padding: EdgeInsets.only(
                      top: 5.0, bottom: 5.0, right: 10.0, left: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1.5,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 18.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: TextField(
                          controller: _namecontroller,

                          decoration: new InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 1.0.h),
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(width: 2, color: Colors.purple)),
                              fillColor: Colors.white,
                              hintText: "اسم النشاط",
                              labelText:"اسم النشاط"),
                        ),
                      ),
                      SizedBox(
                        height: 18.0,
                      ),
                      RaisedButton(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 2.0.h),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          children: [
                            Text("${cat_name}",style: TextStyle(color: Colors.black,fontSize: 12.0.sp),),
                            Icon(Icons.arrow_downward,color: Colors.black,)
                          ],
                        ),
                        onPressed: () {
                          SelectDialog.showModal(
                            context,
                            label: "  اختر القسم",
                            items: cats,
                            selectedValue: cat_name,
                            itemBuilder:
                                (BuildContext context,  item, bool isSelected) {
                              return Container(
                                decoration: !isSelected
                                    ? null
                                    : BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                child: ListTile(
                                  onTap: (){
                                    setState(() {
                                      cat_name = item["name_ar"];
                                      cat_id = item["id"];

                                    });



                                    Navigator.pop(context);
                                  },
                                  selected: isSelected,
                                  title: Text(item["name_ar"],style: TextStyle(fontFamily: "Cairo",fontSize: 12.0.sp),),
                                ),
                              );
                            },

                          );
                        },
                      ),

                      SizedBox(
                        height: 18.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: TextField(
                          autofocus:false,
                          controller: _jobcontroller,
                          keyboardType: TextInputType.multiline,
                          minLines: 1,//Normal textInputField will be displayed
                          maxLines: 5,// when user presses enter it will adapt to it
                          decoration: new InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 1.0.h),
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(width: 2, color: Colors.purple)),
                              fillColor: Colors.white,
                              hintText: "المجال او المسمي الوظيفي",
                              labelText:"المجال او المسمي الوظيفي"),
                        ),
                      ),
                      SizedBox(
                        height: 18.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: TextField(
                          autofocus:false,
                          controller: _desccontroller,
                          keyboardType: TextInputType.multiline,
                          minLines: 1,//Normal textInputField will be displayed
                          maxLines: 5,// when user presses enter it will adapt to it
                          decoration: new InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 1.0.h),
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(width: 2, color: Colors.purple)),
                              fillColor: Colors.white,
                              hintText: "التخصص بالتفصيل",
                              labelText:"التخصص"),
                        ),
                      ),
                      SizedBox(
                        height: 18.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: TextField(
                          controller: _addresscontroller,
                          autofocus:false,

                          decoration: new InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 1.0.h),
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(width: 2, color: Colors.purple)),
                              fillColor: Colors.white,
                              hintText: "العنوان",
                              labelText:"العنوان"),
                        ),
                      ),

                      SizedBox(
                        height: 18.0,
                      ),
                      RaisedButton(
                        padding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal:2.0.h),
                        color: Colors.white,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          children: [
                            Text("${city_name}",style: TextStyle(color: Colors.black,fontSize: 16),),
                            Icon(Icons.arrow_downward,color: Colors.black,)
                          ],
                        ),
                        onPressed: () {
                          SelectDialog.showModal(
                            context,
                            label: "  اختر المدينة",
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
                                      region_name = "اختر المنطقة";
                                      region_id = 0;
                                    });



                                    Navigator.pop(context);
                                  },
                                  selected: isSelected,
                                  title: Text(item["name"]),
                                ),
                              );
                            },

                          );
                        },
                      ),
                      SizedBox(
                        height: 18.0,
                      ),
                      RaisedButton(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 2.0.h),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          children: [
                            Text("${region_name}",style: TextStyle(color: Colors.black,fontSize: 16),),
                            Icon(Icons.arrow_downward,color: Colors.black,)
                          ],
                        ),
                        onPressed: () {
                          SelectDialog.showModal(
                            context,
                            label: " اختر المنطقة",
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



                                    Navigator.pop(context);
                                  },
                                  selected: isSelected,
                                  title: Text(item["name"]),
                                ),
                              );
                            },

                          );
                        },
                      ),
                      SizedBox(
                        height: 18.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          autofocus:false,
                          controller: _pricecontroller,

                          decoration: new InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 2.0.h),
                            border: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(width: 2, color: Colors.purple)),
                            fillColor: Colors.white,
                            hintText: "سعر الكشف او الخدمة",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),





                      _isload?Center(child: CircularProgressIndicator()) :InkWell(
                        onTap: () {
                          my_activate();
                        },
                        child:Container(
                          height: 8.0.h,
                          width: 190.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.lightBlue,
                            elevation: 7.0,
                            child: GestureDetector(
                              child: Center(
                                child:
                                Text("ارسال الطلب",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Cairo',
                                    fontSize: 12.0.sp,
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "انهاء وتراجع ",
                          style: TextStyle(
                            color:
                            Theme.of(context).textTheme.headline6.color,
                            fontFamily: 'Cairo',
                            fontSize: 12.0.sp,
                            letterSpacing: 0.7,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),

                SizedBox(height: 50.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
