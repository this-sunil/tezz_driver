import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:tezz_driver_app/BaseUrl.dart';
import 'package:tezz_driver_app/Model/AssignOrderModel.dart';
class AssignOrderController extends GetxController{
  List<AssignOrderModel> assignOrderList=<AssignOrderModel>[].obs;
  fetchData(String token) async{
    final res= await http.get(Uri.parse("${baseUrl}api/assignedBookingApi"),headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    final assignOrderData=assignOrderModelFromJson(res.body);
    if(res.statusCode==200){
      assignOrderList.clear();
        if(assignOrderData.isNotEmpty){
          assignOrderList.addAll(assignOrderData);
          print("Response Assign Order ${res.body}");
        }
    }
    else{
      print("Server error assignOrder Controller:${res.statusCode}");
    }
  }
}

