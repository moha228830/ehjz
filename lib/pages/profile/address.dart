import 'package:flutter/material.dart';
import 'package:my_store/functions/localizations.dart';
import 'package:my_store/pages/home/home.dart';
import 'package:page_transition/page_transition.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io' ;
import 'package:my_store/config.dart';


import 'package:shared_preferences/shared_preferences.dart';
// My Own Imports

class Address extends StatefulWidget {


  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
String govern ;
  set_token() async{
    SharedPreferences localStorage =
    await SharedPreferences.getInstance();
    localStorage.setString('city', _citycontroller.text);
    localStorage.setString('price', price.toString());

    localStorage.setString('govern', _currentSelectedValue);
    localStorage.setString('address',_addresscontroller.text);
    Fluttertoast.showToast(
      msg: "تمت العملية بنجاح",
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
  var token = utils.CreateCryptoRandomString();

  // Initially password is obscure
  get_shard() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var d = localStorage.getString('user');
    var my_city = localStorage.getString('city');
    var my_govern = localStorage.getString('govern');
    var my_address = localStorage.getString('address');
    var my_price = localStorage.getString('price');
      print(names);
    setState(() {
       price =  double.parse(my_price);
        govern = my_govern;
      _citycontroller.text = my_city;
      _addresscontroller.text = my_address;
      if(names.contains(my_govern)){
        _currentSelectedValue = my_govern;
      }
    });
    print(price);
  }

  var _currentSelectedValue;
  final _addresscontroller = TextEditingController();
  final _citycontroller = TextEditingController();
  final _phonecontroller = TextEditingController();
  List governs = [];
  int len ;
  bool _load = true ;
  double price  ;
  Map map = {};
  List <String> names = [];
  //////////////////////////////////////////////////////////////////////////////////////////////////////
  get_carts  () async{
    try{
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        http.Response response =
        await http.get(Config.url+"get_governs");


        if (response.statusCode == 200) {


          var res = json.decode(response.body);
          if (res["state"]=="1"){
            if (this.mounted) {
              setState(() {
                governs = res["data"];
               // print(governs);
                len = governs.length;
                for (int i = 0; i < len; i++) {
                  names.add(governs[i]["name"]);
                  map[governs[i]["name"]] = governs[i]["price"];
                  if(names.contains(govern)){
                    _currentSelectedValue = govern;
                  }
                }
              });
            }
            //print(cartItemList.length);

            //  print(tok);

          }else{
            Fluttertoast.showToast(
              msg: '${res["msg"]}',
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

  go_pay(){
    if(_currentSelectedValue=="" || _citycontroller.text ==""   || _addresscontroller.text==""  )
    {

      Fluttertoast.showToast(
        msg: 'اكمل البيانات ',
        backgroundColor: Theme.of(context).textTheme.headline6.color,
        textColor: Theme.of(context).appBarTheme.color,
      );
      return false ;
    }else{
      return true ;



    }

  }
  @override
  void initState() {
    get_shard();
    _load = true ;
    get_carts  ();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text(
          "عنوان التوصيل",
          style: TextStyle(
            fontFamily: 'Jost',
            color: Colors.white,
            fontSize: width/24,
            letterSpacing: 1.7,
            fontWeight: FontWeight.bold,
          ),
        ),
        titleSpacing: 0.0,
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          !_load?
          Container(
            padding: EdgeInsets.all(15.0),
            child:   Container(
              width: width - 40.0,
              padding: EdgeInsets.only(
                  top: 20.0, bottom: 20.0, right: 10.0, left: 10.0),
              decoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.color,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 1.5,
                    color: Colors.grey[300],
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "ادخل او عدل عنوان التوصيل",
                    style: TextStyle(
                        fontSize: width/20,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Alatsi',
                        height: 1.6),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(
                    height: 26.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius:
                      BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: FormField<String>(
                      builder: (FormFieldState<String> state) {
                        return
                          InputDecorator(
                            decoration: new InputDecoration(
                                contentPadding: const EdgeInsets.all(12.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(width: 2, color: Colors.purple)),
                                fillColor: Colors.white,
                                hintText: "محافظة/مدينة",
                                labelText:"محافظة/مدينة"),
                            isEmpty: _currentSelectedValue == null,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: _currentSelectedValue,
                                isDense: true,
                                onChanged: ( newValue) {
                                  if (this.mounted) {
                                    setState(() {
                                      _currentSelectedValue = newValue ;
                                      price = map[newValue].toDouble();
                                      print(price);
                                      state.didChange(newValue);
                                    });
                                  }
                                },
                                items: names.map(( value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                      },
                    ),
                  ),

                  SizedBox(
                    height: 18.0,
                  ),


                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius:
                      BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: TextField(
                      controller: _citycontroller,

                      decoration: new InputDecoration(
                          contentPadding: const EdgeInsets.all(12.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(width: 2, color: Colors.purple)),
                          fillColor: Colors.white,
                          hintText: "منطقة",
                          labelText:"منطقة"),
                    ),
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius:
                      BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: TextField(
                      controller: _addresscontroller,

                      decoration: new InputDecoration(
                          contentPadding: const EdgeInsets.all(12.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(width: 2, color: Colors.purple)),
                          fillColor: Colors.white,

                          hintText: "العنوان التفصيلي",
                          labelText: "قطعة - شارع - بناية  او عمارة وشقة"),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    child: InkWell(
                      onTap: () {

                        if(go_pay()){
                          set_token();
                              //PaymentPage(widget.total,price,_phonecontroller.text,_currentSelectedValue,_citycontroller.text,_addresscontroller.text)));
                        }
                      },
                      child: Container(
                        width: width - 40.0,
                        padding: EdgeInsets.all(15.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.pinkAccent,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Text(
                          "حفظ ",
                          style: TextStyle(
                              color: Theme.of(context).appBarTheme.color,
                              fontFamily: 'Jost',
                              letterSpacing: 0.7,
                              fontSize: width/25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),


                  ),
                  SizedBox(
                    height: 30.0,
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: Home(0)));
                    },
                    child: Text(
                      "الرئيسية",
                      style: TextStyle(
                        color:
                        Theme.of(context).textTheme.headline6.color,
                        fontFamily: 'Jost',
                        fontSize: 17.0,
                        letterSpacing: 0.7,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ):
          Center(child:  LinearProgressIndicator(
            backgroundColor: Colors.pinkAccent,
            valueColor: AlwaysStoppedAnimation(Colors.purpleAccent),
            minHeight: 20,
          )),
        ],
      ),
    );
  }
}
