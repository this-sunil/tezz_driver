// /*
//
// import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:tezz_driver_app/BaseUrl.dart';
// import 'package:tezz_driver_app/Model/RegistrationModel.dart';
// import 'package:http/http.dart'as http;
// import 'package:tezz_driver_app/Model/RegistrationModelError.dart';
// class RegistrationController extends GetxController{
// List<RegistrationModel>register=<RegistrationModel>[].obs;
// List<RegistrationModelErrror> registerError=<RegistrationModelErrror>[].obs;
// List<String> err=<String>[].obs;
// List<String> err1=<String>[].obs;
//  bool isRegister=false;
//  String s1="";
//  String s2="";
// postData(String name,String email,String mobile,)async{
//   print("name $name");
//   print("email $email");
//   print("mobile number $mobile");
//   isRegister=true;
//
//   final res=await http.post(Uri.parse("${baseUrl}api/sendOtpApi"),
//       body:{
//         "name":name,
//         "email":email,
//         "mobile":mobile,
//
//       },headers: {
//         'Accept': 'application/json',
//       });
//   //print("Response body"+res.body);
//   //print("Response ${res.statusCode}");
//   //  print("Response ${res.statusCode}");
//   print("name $name");
//   print("email $email");
//   print("mobile number $mobile");
//   print("Response bodyyy"+res.body);
//   print("status Code ${res.statusCode}");
//
//   if(res.statusCode==200){
//     RegistrationModel registerModel=registrationModelFromJson(res.body);
//     register.add(registerModel);
//     print("status Code ${res.statusCode}");
//    // Fluttertoast.showToast(msg: register.first.message);
//    // print("register token is here ${register.first.token}");
//
//
//     // print("Response ${res.statusCode}");
//     // print("name $name");
//     // print("email $email");
//     // print("mobile number $mobile");
//     // print("Response"+res.body);
//
//     // RegistrationModel registerModel=registrationModelFromJson(res.body);
//     // for(int i=0;i>registerModel.message.length;i++){
//     //   register.add(registerModel);
//     //   print("register value $register");
//     // }
//
//    // return registrationModelFromJson(res.body);
//
//   // try{
//   //
//   //   }
//   //
//   // }catch(e){
//   //   Exception(e);
//   // }
// }else if(res.statusCode==422){
//
//     err.clear();
//     err1.clear();
//     Map<String,dynamic> result=jsonDecode(res.body);
//     Fluttertoast.showToast(msg: result["message"]);
//     s1=result["errors"]["email"][0]??"";
//     s2=result["errors"]["mobile"][0]??"";
//     if(s1.isNotEmpty){
//       err.add(s1);
//     }
//     if(s2.isNotEmpty){
//       err1.add(s2);
//     }
//   */
// /* if(result.isNotEmpty){
//      for(int i=0;i<result.length;i++){
//        s1=result["errors"]["email"][0].toString();
//
//      }
//    }*//*
//
//
//     */
// /*if(s1.isNotEmpty){
//       return err.add(s1);
//     }*//*
//
//
//
//
//    // print(err1);
//
//
//    // registerError.add(RegistrationModelErrror(message: result["message"], errors: result["errors"]));
//    // print(registerError);
//
//
//     //return print("plsease check your Information");
//   }
// }
//
//
// }*/
