// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart'as http;
// import 'package:tezz_driver_app/BaseUrl.dart';
// import 'package:tezz_driver_app/Model/WalletModel.dart';
//
// class WalletNextPageController extends GetxController{
//   @override
//   onInIt(){
//     //fetchWallet();
//     super.onInit();
//   }
//   List<WalletBalance> walletModel=<WalletBalance>[].obs;
//   fetchWalletNextPage(String url)async{
//
//     try{
//       final res= await http.get(Uri.parse(url),
//           headers: {
//             'Accept': 'application/json',
//             'Authorization': 'Bearer 39|LXUiX6vPDXWdQTmfAEWiThiZkQgnYLNYXK42coFr'
//           }
//       );
//       print(res.statusCode);
//       print("Wallet Next Page Api Body ${res.body}");
//       WalletBalance list=walletControllerFromJson(res.body);
//       walletModel.add(list);
//       return walletControllerFromJson(res.body);
//     }
//     catch(e){
//       print("error $e");
//     }
//
//
//   }
//
// }