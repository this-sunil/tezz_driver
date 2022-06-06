import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:tezz_driver_app/BaseUrl.dart';
class WithdrawMaxController extends GetxController{
  List<int> withdrawMaxModel=<int>[].obs;

  getWithdrawMax()async{
    //
     var res=await http.get(Uri.parse("${baseUrl}api/checkMaxWithdrawApi"),
    headers: {
    'Accept': 'application/json',
    'Authorization': 'Bearer 39|LXUiX6vPDXWdQTmfAEWiThiZkQgnYLNYXK42coFr'
    });
     Map<String,dynamic> map= jsonDecode(res.body);
     if(res.statusCode==200){
       withdrawMaxModel.clear();


         withdrawMaxModel.add(map["maxWithdraw"]);
         print(map);
         print(withdrawMaxModel);

     }
     else{
       print("withdraw error");
     }
    
  }
  
}