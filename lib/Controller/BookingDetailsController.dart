import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:tezz_driver_app/BaseUrl.dart';
import 'package:tezz_driver_app/Model/BookingDetailsModel.dart';
class BookingDetailsController extends GetxController{
  @override
  onInIt(){
    bookingDetailsGet(1162);
    super.onInit();
  }
  List<BookingDetailsModel> bookingDetailsModel=<BookingDetailsModel>[].obs;
  bookingDetailsGet(int id) async{
    final res =await http.get(Uri.parse("${baseUrl}api/bookingDetailsApi/$id"),headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer 39|LXUiX6vPDXWdQTmfAEWiThiZkQgnYLNYXK42coFr'
    });
    BookingDetailsModel list=bookingDetailsModelFromJson(res.body);
    bookingDetailsModel.add(list);
    print("Booking details Coming from Body ${res.body}");
    return bookingDetailsModelFromJson(res.body);
  }
}