import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tezz_driver_app/BaseUrl.dart';
import 'package:tezz_driver_app/Model/BookingModel.dart';
import 'package:http/http.dart'as http;
import 'package:tezz_driver_app/Model/BookingModelDemo.dart';

class BookingControllerHourly extends GetxController{

  List<BoookingModelDemo> booking=<BoookingModelDemo>[].obs;
  fetchData(String token)async{
    final res=await http.get(Uri.parse("${baseUrl}api/driverBookingsListApi/hourly"),headers:
    {
      'Accept': 'application/json',
      /*'Authorization':'Bearer $token',*/

      'Authorization': 'Bearer $token',
    });
    Map<String,dynamic> result=jsonDecode(res.body);
    print("Comming from Booking hourly ${res.body}");


    //print("main check${jsonResponse}");
    if(res.statusCode==200){
      BoookingModelDemo jsonResponse=boookingModelDemoFromJson(res.body) ;
     if(jsonResponse.data.isNotEmpty){
       booking.clear();

       for(int i=0;i<jsonResponse.data.length;i++){

         booking.add(jsonResponse);
         //Fluttertoast.showToast(msg: result["message"]);
       }
     }
    }
    else{

      Fluttertoast.showToast(msg: result["message"]);
    }
  }
}