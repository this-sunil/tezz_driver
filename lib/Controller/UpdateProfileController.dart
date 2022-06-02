import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:tezz_driver_app/BaseUrl.dart';
import 'package:tezz_driver_app/Model/UpdateProfileModel.dart';
class UpdateProfileController extends GetxController{

  List<UpdateProfileModel> updateProfile=<UpdateProfileModel>[].obs;


  UpdateProfile(String token) async{
    final res=await http.get(Uri.parse("${baseUrl}api/editProfileApi"),
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    );
    Map<String,dynamic> map=jsonDecode(res.body);
    print("data "+res.body);
    final updateProfileData=updateProfileModelFromJson(res.body);
    if(res.statusCode==200){
      updateProfile.clear();
      updateProfile.add(updateProfileData);
      print("show Data ${res.body}");
    }
    else{
      print("show Data ${res.statusCode}");
    }
  }
}