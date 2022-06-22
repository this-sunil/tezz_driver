import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';
import 'package:tezz_driver_app/BaseUrl.dart';
class WithdrawAmountController extends GetxController{
  List<Massage> massageError=<Massage>[].obs;

  postWithdrowAmount(String amount,String note,String token)async{

    final res=await http.post(Uri.parse("${baseUrl}api/requestToWithdrawApi"),
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    },
    body: {
      "amount":amount,
      "note":note,
    });
   Map<String,dynamic> map=jsonDecode(res.body);
    print(res.body);
    print(map["messege"]);
    massageError.clear();
    massageError.add(Massage(message: map["messege"]));
   //Fluttertoast.showToast(msg: map["messege"]);
   // print(massageError.first.message.toString());
    //print("coming from map ${map["message"]}");

   // massageError.add(map["message"]);
   // print(massageError);

   // print(map);
   // print("response staus :${map[0]}");
   //print("coming from map ${map["message"]}");
   if(res.statusCode==200){

     //print(massageError);
    //massageError.add(map.toString());

    // print(massageError);
     return jsonDecode(res.body);
   }


    
  }
}
class Massage{
   String message;
  Massage({required this.message});

}