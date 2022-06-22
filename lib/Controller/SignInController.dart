import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tezz_driver_app/BaseUrl.dart';
import 'dart:convert';
import 'package:tezz_driver_app/MyHomePage.dart';
import 'package:tezz_driver_app/OtpScreen.dart';
class SignInController extends GetxController{
  fetchSignIn(String mobile,String validated,BuildContext context) async{
    final resp=await http.post(Uri.parse("${baseUrl}api/loginDriverApi"),
    headers: {
      'Accept': 'application/json',
    },
      body: {
      "mobile":mobile,
        "is_validated":validated,
      },
    );
    Map<String,dynamic> map=jsonDecode(resp.body);
    if(resp.statusCode==200){
      Fluttertoast.showToast(msg: map["message"]);
      if(validated=="false"){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> OtpScreen("", "", mobile, "+91")));
      }
      else {
        if(map["token"]!=null){
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => MyHomePage(token: map["token"])));
        }
      }
    }
    else{
      Fluttertoast.showToast(msg: map["message"]);
    }
  }
}