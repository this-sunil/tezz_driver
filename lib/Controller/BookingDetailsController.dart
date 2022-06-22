import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:tezz_driver_app/BaseUrl.dart';
import 'package:tezz_driver_app/Model/BookingDetailsModel.dart';
class BookingDetailsController extends GetxController{


  List<BookingDetailsModel> bookingDetailsModel=<BookingDetailsModel>[].obs;
  bookingDetailsGet(int id,String token) async{
    final res =await http.get(Uri.parse("${baseUrl}api/bookingDetailsApi/$id"),headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    BookingDetailsModel list=bookingDetailsModelFromJson(res.body);

    if(res.statusCode==200){
      bookingDetailsModel.clear();

        print("Booking details Coming from Body ${res.body}");
        bookingDetailsModel.add(list);
   }
   else{



     Fluttertoast.showToast(msg:"Server failed: ${res.statusCode}");
   }
  }
}