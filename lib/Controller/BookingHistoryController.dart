import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:tezz_driver_app/BaseUrl.dart';
import 'package:tezz_driver_app/Model/BookingHistory.dart';
class BookingHistoryController extends GetxController{
  List<BookingHistory> bookingHistoryList=<BookingHistory>[].obs;
  fetchData(String token) async{
    final res= await http.get(Uri.parse("${baseUrl}api/bookingHistoryApi"),headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print("Response Booking History${res.body}");
    final bookingHistory=bookingHistoryFromJson(res.body);
    if(res.statusCode==200){
      bookingHistoryList.clear();
      print("Server connect ${res.statusCode}");
         if(bookingHistory.isNotEmpty){
           bookingHistoryList.addAll(bookingHistory);
         }
    }
    else{
      print("Server error Booking History Controller:${res.statusCode}");
    }
  }
}

