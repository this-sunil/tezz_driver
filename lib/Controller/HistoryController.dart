import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:tezz_driver_app/BaseUrl.dart';
class HistoryController extends GetxController{
  List<String> historyList=<String>[].obs;
  fetchHistoryData(String token) async{
    final resp=await http.get(Uri.parse("${baseUrl}"),headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    final HistoryData=jsonDecode(resp.body);
    if(resp.statusCode==200){
      historyList.clear();
      print("Response ${resp.body}");
      historyList.add(HistoryData);
    }
    else{
      print("Server issue ${resp.statusCode}");
    }
  }
}