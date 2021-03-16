
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PostDataProvider with ChangeNotifier {

  var name="";
  var img ="";
  var job = "";
  var place ;
  ///////////////////
  String login = "0";
  String token ="";
  String user_id = "";
  var user = {} ;

  List home_category =[];
  List sliders = [];

  set_in_home(cats,slid){
    home_category = cats;
    sliders =slid;
    notifyListeners();
  }

  set_data(name1,img1,job1,place1)  {
    name = name1;
    img = img1;
    job=job1;
    place=place1;
    notifyListeners();
  }

  get_shard(my_login,my_token,my_user_id,my_user) {
    login=my_login.toString();
    user = my_user;
    user_id = my_user_id.toString();
    token = my_token.toString();

    notifyListeners();

  }




}