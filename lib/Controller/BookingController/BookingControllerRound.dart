import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tezz_driver_app/BaseUrl.dart';
import 'package:tezz_driver_app/Model/BookingModel.dart';
import 'package:http/http.dart'as http;
import 'package:tezz_driver_app/Model/BookingModelDemo.dart';

class BookingControllerRound extends GetxController{
  @override
  onInit()  {
    // fetchData();
    super.onInit();
  }
  List<BoookingModelDemo> booking=<BoookingModelDemo>[].obs;
  fetchData(String token)async{

    final res=await http.get(Uri.parse("${baseUrl}api/driverBookingsListApi/round"),headers:
    {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    Map<String,dynamic> result=jsonDecode(res.body);


    //print("main check${jsonResponse}");
  if(res.statusCode==200){
    BoookingModelDemo jsonResponse=boookingModelDemoFromJson(res.body) ;
    booking.clear();
    for(int i=0;i<jsonResponse.data.length;i++){
      booking.add(jsonResponse);
      Fluttertoast.showToast(msg: result["message"]);
    }
    return boookingModelDemoFromJson(res.body);
  }
  else{
    print("Server isuue ${result["message"]}");
    }



  }
}