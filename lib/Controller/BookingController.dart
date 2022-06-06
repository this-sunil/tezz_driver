import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tezz_driver_app/BaseUrl.dart';
import 'package:tezz_driver_app/Model/BookingModel.dart';
import 'package:http/http.dart'as http;

import '../Model/BookingModelDemo.dart';
class BookingController extends GetxController{
  @override
  onInit()  {
    // fetchData();
    super.onInit();
  }
  List<BoookingModelDemo> booking=<BoookingModelDemo>[].obs;
  fetchData(String token)async{

    final res=await http.get(Uri.parse("${baseUrl}api/driverBookingsListApi/oneway"),headers:
    {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if(res.statusCode==200){
      booking.clear();
      print("Coming from oneway here ${res.body}");
      BoookingModelDemo jsonResponse=boookingModelDemoFromJson(res.body);
     if(jsonResponse.data.isNotEmpty){
       for(int i=0;i<jsonResponse.data.length;i++){
         booking.add(jsonResponse);
         print("Response Booking Lists:${res.body}");
       }
     }
    }
    else{
      Map<String,dynamic> result=jsonDecode(res.body);
      print("Response Booking Lists:${result["message"]}");
    }




  }
}