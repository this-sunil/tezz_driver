
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tezz_driver_app/BaseUrl.dart';
import 'package:tezz_driver_app/Model/RegistrationModel.dart';
import 'package:http/http.dart'as http;
import 'package:tezz_driver_app/Model/RegistrationModelError.dart';
import 'package:tezz_driver_app/MyHomePage.dart';
import 'package:tezz_driver_app/OtpScreen.dart';
class RegistrationController extends GetxController{
 bool isRegister=false;
 String s1="";
 String s2="";
postData(String name,String email,String mobile,String is_validated,BuildContext context)async{
  print("name $name");
  print("validated $is_validated");
  print("email $email");
  print("mobile number $mobile");
  isRegister=true;

  final res=await http.post(Uri.parse("${baseUrl}api/registerDriverApi",

  ),
      headers: {
        'Accept': 'application/json',
        //'Authorization': 'Bearer 27|Q2a5aQj7Nz8FaH9JLb641QLvPrhbva6ZjTJROJeD'
      },
      body:{
        "name":name,
        "email":email,
        "mobile":mobile,
        "is_validated":is_validated,
      });
  //print("Response body"+res.body);
  //print("Response ${res.statusCode}");
  //  print("Response ${res.statusCode}");
  print("name $name");
  print("is_validate $is_validated");
  print("email $email");
  print("mobile number $mobile");
  print("Response bodyyy"+res.body);
  print("status Code ${res.statusCode}");

  if(res.statusCode==200){
    Map<String,dynamic> result=jsonDecode(res.body);
    Fluttertoast.showToast(msg: result["message"]);

    if(result["message"]==result["message"]){
     if(is_validated=="true"){
       Navigator.push(context,MaterialPageRoute(builder: (context)=>MyHomePage(token:result["token"])));
     }
     else{
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OtpScreen(name, email, mobile, "+91")));
     }
    }
   }
  else{
    Map<String,dynamic> result=jsonDecode(res.body);
    Fluttertoast.showToast(msg: result["message"]);
  }
}


}