import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:tezz_driver_app/BaseUrl.dart';
import 'package:tezz_driver_app/Model/VehicleDataModel.dart';
class VehicleModelController extends GetxController{
  List<VehicleDataModel> vehicleList=<VehicleDataModel>[].obs;
  fetchVehicleData(String token,String id) async{
    final resp=await http.get(Uri.parse("${baseUrl}api/getVehicleModelApi/$id"),
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }

    );
    final vehicleData=vehicleDataModelFromJson(resp.body);
    if(resp.statusCode==200){
      vehicleList.clear();
      vehicleList.add(vehicleData);

      print("Vehicle Model List:${resp.body}");
    }
    else{
      print("Vehicle Model List:${resp.statusCode}");
    }
  }
}