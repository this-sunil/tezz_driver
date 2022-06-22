import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tezz_driver_app/BaseUrl.dart';
import 'package:tezz_driver_app/Model/BookingModel.dart';
import 'package:http/http.dart'as http;
import 'package:tezz_driver_app/Model/BookingModelDemo.dart';

class BookingControllerAirport extends GetxController{

  List<BoookingModelDemo> booking=<BoookingModelDemo>[].obs;
  fetchData(String token)async{
    //booking.clear();
    final res=await http.get(Uri.parse("${baseUrl}api/driverBookingsListApi/airport"),headers:
    {
      'Accept': 'application/json',
      /*'Authorization':'Bearer $token',*/

      'Authorization': 'Bearer $token',
    });
    print("Comming from BookingRound ${res.body}");
    BoookingModelDemo jsonResponse=boookingModelDemoFromJson(res.body) ;

    //print("main check${jsonResponse}");
   if(res.statusCode==200){
     if(jsonResponse.data.isNotEmpty){
       booking.clear();

       for(int i=0;i<jsonResponse.data.length;i++){

         booking.add(jsonResponse);


       }
     }
   }
   else{

     print("server error from Airport ${res.statusCode}");
   }




  }
}