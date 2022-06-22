import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:tezz_driver_app/BaseUrl.dart';
import 'package:tezz_driver_app/Model/MyProfileModel.dart';
class MyProfileController extends GetxController{
  @override
  onInit()  {
   // fetchMyProfile();
    super.onInit();
  }
  List<MyProfileModel> myProfile= <MyProfileModel> [].obs;

  fetchMyProfile(String token)async{
    final res= await http.get(Uri.parse("${baseUrl}api/driverProfileApi"),headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });


    if(res.statusCode==200){
      MyProfileModel list=myProfileModelFromJson(res.body);
      myProfile.clear();
      myProfile.add(list);
      print("main profile :${res.body}");
    }
    else{
      print("main profile :${res.statusCode}");
    }


  }
}
