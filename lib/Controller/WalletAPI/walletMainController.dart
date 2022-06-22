import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:tezz_driver_app/BaseUrl.dart';
import 'package:tezz_driver_app/Model/WalletModel.dart';

class WalletController extends GetxController{
  @override
  onInIt(){
    //fetchWallet();
    super.onInit();
  }
  List<WalletBalance> walletModel=<WalletBalance>[].obs;
  fetchWallet(String token)async{

 try{
   final res= await http.get(Uri.parse("${baseUrl}api/driverWalletBalanceApi"),
       headers: {
         'Accept': 'application/json',
         'Authorization': 'Bearer $token'
       }
   );
   print(res.statusCode);
   print(" From Wallet Controller${res.body}");
   WalletBalance list=walletBalenceFromJson(res.body);
   walletModel.add(list);
   return walletBalenceFromJson(res.body);
 }
 catch(e){
   print("error $e");
 }


  }
  
}