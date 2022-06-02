import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_place/google_place.dart';
import 'package:http/http.dart' as http;
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tezz_driver_app/BaseUrl.dart';
import 'package:tezz_driver_app/Controller/UpdateProfileController.dart';
import 'package:tezz_driver_app/Controller/VehicleModelController.dart';
import 'package:tezz_driver_app/Model/UpdateProfileModel.dart';
import 'package:tezz_driver_app/Model/VehicleDataModel.dart';

class UpdateProfilePage extends StatefulWidget {
  final String token;
  const UpdateProfilePage({Key? key,required this.token}) : super(key: key);

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> with SingleTickerProviderStateMixin{
  int index=0;
  late AnimationController animationController;
  final GlobalKey<FormState> profileKey = GlobalKey<FormState>();
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController mobile;
  late TextEditingController birthdate;
  late TextEditingController address;
  late TextEditingController pinCode;
  late TextEditingController bankName;
  late TextEditingController accHolderName;
  late TextEditingController accNumber;
  late TextEditingController branch;
  late TextEditingController ifsc;
  late TextEditingController vehicleName;
  late TextEditingController vehicleNumber;
  late TextEditingController multipleCities;
  List<UpdateProfileModel> updateProfile=[];
  bool spinner=false;
  bool success=false;
  late GooglePlace googlePlace;
  List<String> selectCity=[];
  List<AutocompletePrediction> predictions = [];
  searchLocation(String value) async {

    print("Search Value $value");
    await googlePlace.autocomplete.get(value,components: [Component("country","in")]).then((value){

      if (value != null && value.predictions != null && mounted) {
        setState(() {
          print("Result data:${value}");
          predictions = value.predictions!;
          Fluttertoast.showToast(msg: predictions[0].description.toString());


        });
      }
    });

  }
 VehicleModelController vehicleModelController=Get.put(VehicleModelController());
  final ImagePicker imagePicker=ImagePicker();
  DateTime selectedDate = DateTime.now();
  List<String> selectMenu=[];
  List<VehicleDataModel> vehicleList=<VehicleDataModel>[];
  var vehicleModel;
  var vehicleType;
  bool flag=false;
  fetchVehicleData(String token,String id) async{
    final resp=await http.get(Uri.parse("${baseUrl}api/getVehicleModelApi/$id"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }

    );
    final vehicleData=vehicleDataModelFromJson(resp.body);
    if(resp.statusCode==200){
      flag=true;

      setState(() {

        vehicleList.add(vehicleData);

      });

      print("Vehicle Model List:${resp.body}");
    }
    else{
      print("Vehicle Model List:${resp.statusCode}");
    }
  }

   UpdateProfile(String token) async{

    final res=await http.get(Uri.parse("${baseUrl}api/editProfileApi"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    //Map<String,dynamic> map=jsonDecode(res.body);
    print("data "+res.body);
    final updateProfileData=updateProfileModelFromJson(res.body);
    if(res.statusCode==200){
      updateProfile.clear();
      selectCity.clear();
     setState(() {
       updateProfile.add(updateProfileData);
     });

        name.text=updateProfile.first.data.name.toString();

        email.text=updateProfile.first.data.email.toString();
        mobile.text=updateProfile.first.data.mobile.toString();
        birthdate.text=updateProfile.first.data.dob.toString();
        address.text=updateProfile.first.data.address.toString();
        pinCode.text=updateProfile.first.data.pinCode.toString();
        bankName.text=updateProfile.first.data.bankName.toString();
        accNumber.text=updateProfile.first.data.accountNumber.toString();
        accHolderName.text=updateProfile.first.data.accountHolderName.toString();
        branch.text=updateProfile.first.data.ifsc.toString();
        ifsc.text=updateProfile.first.data.mobile.toString();


           if(updateProfile.first.data.multipleCities.isNotEmpty) {
             var result = jsonDecode(updateProfile.first.data.multipleCities);

             for (int i = 0; i < result.length; i++) {
               print("select city" + result[i]);
               selectCity.add(result[i]);
             }
             Fluttertoast.showToast(msg: "Multiple :${result[0]}");
           }

            //selectCity.add(updateProfile.first.data.multipleCities);


        
        vehicleName.text=updateProfile.first.data.vehicleName.toString();
        vehicleNumber.text=updateProfile.first.data.vehicleNumber.toString();

      print("show Data ${res.body}");
    }
    else{
      print("show Data ${res.statusCode}");
    }
  }

  @override
  void initState() {

    setState(() {
      UpdateProfile(widget.token);
      googlePlace=GooglePlace("AIzaSyCFEIrn6AL1cAcPrJQmF5a7pfExyp-7Cvk");
      animationController=AnimationController(vsync: this,duration: const Duration(seconds: 5000));
    });
    name = TextEditingController();
    email = TextEditingController();
    mobile = TextEditingController();
    birthdate = TextEditingController();
    address = TextEditingController();
    pinCode=TextEditingController();
    bankName = TextEditingController();
    accHolderName=TextEditingController();

    accNumber = TextEditingController();
    branch=TextEditingController();
    ifsc = TextEditingController();
    vehicleName=TextEditingController();
    vehicleNumber=TextEditingController();
    multipleCities=TextEditingController();
    super.initState();
  }


  String male="Male";
  String female="Female";
  String loading="loading";
  File? selectImage;
  File? selectImage1;
  File? selectImage2;
  File? selectImage3;
  File? selectImage4;
  File? selectImage5;
  File? selectImage6;
  File? selectImage7;
  uploadData(String token,String name,String email,String gender,
      String ifsc,
      String mobile,String birthdate,String address,String pinCode,
      String bankName,String accNumber,String accHolderName,String branch,
      String vehicleName,String vehicleNumber,String vehicleTypeId,String vehicleModelId,List<String> city) async{
   print("Upload Data $token");
   print(name);
   print(email);
   print(gender);
   print(mobile);
   print(birthdate);
   print(address);
   print(pinCode);
   print(bankName);
   print(accHolderName);
   print(accNumber);
   print(branch);
   print("ifsc code:"+ifsc);
   print(vehicleName);
   print(vehicleNumber);

    setState(() {
      spinner=true;
    });

    var request=http.MultipartRequest("POST",Uri.parse("${baseUrl}api/updateProfileApi"));
    request.headers.addAll({
      'Accept': 'application/json',
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $token',
    });
   request.fields["Name"]=name;
   request.fields["Gender"]=gender;
   request.fields["DOB"]=birthdate;
   request.fields["Address"]=address;
   request.fields["IFSC"]=ifsc;
   request.fields["PinCode"]=pinCode;
   request.fields["VehicleName"]=vehicleName;
   request.fields["VehicleNumber"]=vehicleNumber;
   request.fields["BankName"]=bankName;
   request.fields["AccountHolderName"]=accHolderName;
   request.fields["BranchName"]=branch;
   request.fields["AccountNumber"]=accNumber;
   request.fields["VehicleTypeId"]=vehicleTypeId;
   request.fields["VehicleModelId"]=vehicleModelId;
  for(int i=0;i<selectCity.length;i++){
    print("city"+i.toString());

    request.fields["MultipleCities[$i]"]=selectCity[i];
    print(selectCity[i]);
  }
    if(selectImage!=null){
      request.fields["Adhar"]="${selectImage!.path}";
      request.files.add(await http.MultipartFile.fromPath('Adhar', '${selectImage!.path}'));
    }
    if(selectImage1!=null){
      request.fields["Licence"]="${selectImage1!.path}";
      request.files.add(await http.MultipartFile.fromPath('Licence', '${selectImage1!.path}'));
    }
    if(selectImage2!=null){
      request.fields["Pan"]="${selectImage2!.path}";
      request.files.add(await http.MultipartFile.fromPath('Pan', '${selectImage2!.path}'));
    }
    if(selectImage3!=null){
      request.fields["Photo"]="${selectImage3!.path}";
      request.files.add(await http.MultipartFile.fromPath('Photo', '${selectImage3!.path}'));
    }
    if(selectImage4!=null){

      request.fields["Insurance"]="${selectImage4!.path}";
      request.files.add(await http.MultipartFile.fromPath('Insurance', '${selectImage4!.path}'));

    }
    if(selectImage5!=null){

      request.fields["WorkPermit"]="${selectImage5!.path}";
      request.files.add(await http.MultipartFile.fromPath('WorkPermit', '${selectImage5!.path}'));

    }
    if(selectImage6!=null){

      request.fields["JoiningForm"]="${selectImage6!.path}";
      request.files.add(await http.MultipartFile.fromPath('JoiningForm', '${selectImage6!.path}'));

    }
    if(selectImage7!=null){
      request.fields["BankPassbook"]="${selectImage7!.path}";
      request.files.add(await http.MultipartFile.fromPath('BankPassbook', '${selectImage7!.path}'));
    }
    var res = await request.send();
    print("Response +${res.statusCode}");
    if (res.statusCode == 200) {
      http.Response response=await http.Response.fromStream(res);
      Map<String,dynamic> result=jsonDecode(response.body);
      Fluttertoast.showToast(msg: "${result["message"]}");
      print(response.body);
      print("Response Multiple images:${res.statusCode}");
      setState(() {
        spinner=false;
        success=true;
      });
      setState(() {

        selectImage=null;
        selectImage1=null;
        selectImage2=null;
        selectImage3=null;
        selectImage4=null;
        selectImage5=null;
        selectImage6=null;
        selectImage7=null;

      });
    } else {
      setState(() {
        spinner=false;
      });
      http.Response response=await http.Response.fromStream(res);
      Map<String,dynamic> result=jsonDecode(response.body);
      Fluttertoast.showToast(msg:"failed ${result["errors"]}");
      print("failed ${result["errors"]}");

    }


  }
  @override
  void dispose() {
    updateProfile.clear();
    animationController.dispose();
  vehicleList.clear();
    super.dispose();
  }
  /*start choose image*/
  adhaarCard() async{
    final image=await imagePicker.pickImage(source: ImageSource.gallery);
    if(image!=null){
      setState(() {
        selectImage=File(image.path).absolute;
      });
    }
    else {
      return Text("No Image Selected");
    }
  }
  drivingLicense() async{
    final image=await imagePicker.pickImage(source: ImageSource.gallery);
    if(image!=null){
      setState(() {
        selectImage1=File(image.path).absolute;
      });
    }
    else {
      return Text("No Image Selected");
    }
  }
  panCard() async{
    final image=await imagePicker.pickImage(source: ImageSource.gallery);
    if(image!=null){
      setState(() {
        selectImage2=File(image.path).absolute;
      });
    }
    else {
      return Text("No Image Selected");
    }
  }
  driverImage() async{
    final image=await imagePicker.pickImage(source: ImageSource.gallery);
    if(image!=null){
      setState(() {
        selectImage3=File(image.path).absolute;
      });
    }
    else {
      return Text("No Image Selected");
    }
  }
  bankPassbook() async{
    final image=await imagePicker.pickImage(source: ImageSource.gallery);
    if(image!=null){
      setState(() {
        selectImage4=File(image.path).absolute;
      });
    }
    else {
      return Text("No Image Selected");
    }
  }
  joiningForm() async{
    final image=await imagePicker.pickImage(source: ImageSource.gallery);
    if(image!=null){
      setState(() {
        selectImage5=File(image.path).absolute;
      });
    }
    else {
      return Text("No Image Selected");
    }
  }
  workPermit() async{
    final image=await imagePicker.pickImage(source: ImageSource.gallery);
    if(image!=null){
      setState(() {
        selectImage6=File(image.path).absolute;
      });
    }
    else {
      return Text("No Image Selected");
    }
  }
  insuranceCertificate() async{
    final image=await imagePicker.pickImage(source: ImageSource.gallery);
    if(image!=null){
      setState(() {
        selectImage7=File(image.path).absolute;
      });
    }
    else {
      return Text("No Image Selected");
    }
  }
  /*end image*/

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Profile"),
      ),
      body: ModalProgressHUD(

        inAsyncCall:spinner,
        progressIndicator: Lottie.asset("images/loading.json",
          controller: animationController,
          width: 200,
          height: 100,
          onLoaded: (composition){
          animationController.duration=composition.duration;
          animationController.forward();

        }
        ),

        child: RefreshIndicator(
          onRefresh: ()=>UpdateProfile(widget.token),
          child: SingleChildScrollView(
            child: Form(
                key: profileKey,
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: name,
                      decoration: InputDecoration(
                        label: Text("Name"),
                        prefixIcon: Icon(Icons.person_outline_sharp,color: Colors.deepOrangeAccent,),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined,color: Colors.deepOrangeAccent,),
                        label: Text("Email"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: mobile,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      decoration: InputDecoration(
                        label: Text("Mobile"),
                        prefixIcon: Icon(Icons.call,color: Colors.deepOrangeAccent,),
                        border: OutlineInputBorder(),
                        counterText: "",
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DateTimeField(
                        controller: birthdate,
                        format: DateFormat("dd/MM/yyyy"),

                        decoration: InputDecoration(
                            label: Text("Birthday"),
                            prefixIcon: Icon(Icons.calendar_today_rounded,color: Colors.deepOrangeAccent,),
                            border: OutlineInputBorder()),
                        onShowPicker: (context, date) async {
                          final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime(2015, 8),
                              lastDate: DateTime(2101));
                          if (picked != null && picked != selectedDate) {
                            setState(() {
                              selectedDate = picked;
                              final date =DateTime.parse("$selectedDate");

                              birthdate.text="${date.day.toString().padLeft(2,"0")}/${date.month.toString().padLeft(2,'0')}/${date.year.toString().padLeft(2,'0')}";
                              Fluttertoast.showToast(msg:"selectDate:${birthdate.text}");
                            });
                          }
                          return selectedDate;
                        },
                      )),
                  Padding(padding: EdgeInsets.all(8.0),child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:20.0),
                        child: Text("Gender",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
                      ),
                    ],
                  ),),
                  Padding(padding: EdgeInsets.all(8.0),child: Row(
                    children: [
                      Flexible(
                        child: RadioListTile(
                          title: Text("Male"), groupValue: male, value: "male",onChanged: (val){
                            setState(() {
                              male=val.toString();
                              Fluttertoast.showToast(msg:male);
                            });

                        },


                        ),
                      ),
                      Flexible(
                        child: RadioListTile(
                          title: Text("Female"), groupValue: male, value: "female",onChanged: (val){
                            setState(() {
                              male=val.toString();
                              Fluttertoast.showToast(msg:male);
                            });
                        },


                        ),
                      ),
                    ],
                  ),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: address,

                      decoration: InputDecoration(
                        label: Text("Address"),
                        prefixIcon: Icon(Icons.location_on_outlined,color: Colors.deepOrangeAccent,),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: pinCode,
                      decoration: InputDecoration(
                        label: Text("PinCode"),
                       // prefixIcon: Icon(Icons,color: Colors.deepOrangeAccent,),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: bankName,
                      decoration: InputDecoration(
                        label: Text("Bank Name"),
                       // prefixIcon: Icon(Icons.bank,color: Colors.deepOrangeAccent,),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: accHolderName,
                      decoration: InputDecoration(
                        label: Text("Account Holder Name"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: accNumber,
                      decoration: InputDecoration(
                        label: Text("Account number"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: branch,
                      decoration: InputDecoration(
                        label: Text("Branch"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: ifsc,
                      decoration: InputDecoration(
                        label: Text("IFSC Code"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: vehicleName,
                      decoration: InputDecoration(
                        label: Text("Vehicle Name"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: vehicleNumber,
                      decoration: InputDecoration(
                        label: Text("Vehicle Number"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(8.0),
                  child: Container(

                    width: MediaQuery.of(context).size.width,
                    child:
                    Card(
                      child:
                      DropdownButtonHideUnderline(

                        child:
                        updateProfile.isEmpty?
                        DropdownButton<String>(
                          onChanged: (value){},
                          hint: Center(child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Select Vehicle Type"),
                          )),
                          items: selectMenu.map((e){
                            return DropdownMenuItem(
                                value: e,
                                child: Text(e));
                          }).toList(),
                        ):
                        DropdownButton(
                          value: vehicleType,



                          hint: Center(child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Select Vehicle Type"),
                          )),


                          items:updateProfile.first.data.vehicleType.map((value) {
                            return DropdownMenuItem(

                              value: value.vehicleTypeId,
                              child: Text(value.vehicleTypeName),
                            );
                          }).toList(),
                          onChanged: (values) {

                             if(values!=null){
                              vehicleType=values;

                              setState(() {
                                flag?vehicleList.clear():false;

                                fetchVehicleData(widget.token, values.toString());

                              });

                              print(values);
                             }









                          },
                        ),
                      ),
                    ),
                  ),
                  ),
                  vehicleList.isEmpty?Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: "Please Select Vehicle Model",
                            onChanged: (value){

                            },
                            hint: Center(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Select Vehicle Model"),
                            )),
                            items: selectMenu.map((e){
                              return DropdownMenuItem(
                                  value: e,

                                  child: Text(e));
                            }).toList(),

                          ),
                        ),
                      ),
                    ),
                  ):Padding(padding: EdgeInsets.all(8.0),
                    child: Container(

                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        child: DropdownButtonHideUnderline(

                          child: DropdownButtonFormField(

                            hint: Center(child: Text("Select Vehicle Model")),
                            items:vehicleList.first.data.map((value) {
                              return DropdownMenuItem(

                                value: value.vehicleModelId,
                                child: Text(value.vehicleModelName),
                              );
                            }).toList(),
                            onChanged: (values) {
                             if(values!=null){
                               setState(() {
                                 vehicleModel=values;
                                 print(vehicleModel);
                               });
                             }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      controller:multipleCities,
                      decoration: const InputDecoration(
                        labelText: "Multiple Cities",
                      ),

                      onChanged: (value) {
                        setState(() {
                          if(value.isNotEmpty){
                            print(value);
                            searchLocation(multipleCities.text);

                          }
                          if(value.isEmpty){
                            predictions.clear();
                          }
                             else {
                               if (predictions.isNotEmpty && mounted) {
                                 setState(() {
                                   predictions = [];
                                 });
                               }
                             }


                        });
                      },
                    ),
                  ),
                  Card(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: predictions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: Icon(
                              Icons.location_on_outlined,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(predictions[index].description.toString()),
                          onTap: () {
                            setState(() {

                             multipleCities.text=predictions[index].description.toString();
                             selectCity.add(multipleCities.text);
                             multipleCities.text="";
                             predictions.clear();


                            });
                            /*  Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsPage(
                                placeId: predictions[index].placeId,
                                googlePlace: googlePlace,
                              ),
                            ),
                          );*/
                          },
                        );
                      },
                    ),
                  ),
                 Column(
                   children: selectCity.map((e){
                     return Padding(
                       padding: const EdgeInsets.only(left:40.0,right:40),
                       child: Chip(
                           backgroundColor: Colors.pink,
                           deleteIconColor: Colors.white,

                           onDeleted: (){
                             setState(() {
                               selectCity.remove(e);
                             });
                           },


                           deleteIcon: CircleAvatar(
                               backgroundColor: Colors.white,
                               child: Icon(Icons.close)),
                           label: Text(e.toString(),

                               style: TextStyle(

                               color:Colors.white))),
                     );
                   }).toList(),
                 ),

                  //Chip(label: Text(predictions[0].description!)),
                  Divider(),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Adhaar Card"),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: selectImage==null?DottedBorder(

                        radius:const Radius.circular(5.0),
                        dashPattern: [5,4],
                        borderType: BorderType.RRect,
                        child: Stack(

                            children: [
                              Image.asset("images/upload_image.jpg"),
                              Positioned(
                                  top: 50,
                                  left: 50,
                                  child: FloatingActionButton(
                                    heroTag: "adhaarcard",
                                    mini: true,
                                    onPressed: () {
                                      setState(() {
                                        adhaarCard();
                                      });
                                    },child: Icon(Icons.add),)),

                            ])):Image.file(File(selectImage!.path)),
                  ),
                  Divider(),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Driving license"),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: selectImage1==null?DottedBorder(

                        radius:const Radius.circular(5.0),
                        dashPattern: [5,4],
                        borderType: BorderType.RRect,
                        child: Stack(

                            children: [
                              Image.asset("images/upload_image.jpg"),
                              Positioned(
                                  top: 50,
                                  left: 50,
                                  child: FloatingActionButton(
                                    heroTag: "drivingLicense",
                                    mini: true,
                                    onPressed: () {
                                      setState(() {
                                        drivingLicense();
                                      });
                                    },child: Icon(Icons.add),)),

                            ])):Image.file(File(selectImage1!.path)),
                  ),
                  Divider(),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Pan Card"),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: selectImage2==null?DottedBorder(

                        radius:const Radius.circular(5.0),
                        dashPattern: [5,4],
                        borderType: BorderType.RRect,
                        child: Stack(

                            children: [
                              Image.asset("images/upload_image.jpg"),
                              Positioned(
                                  top: 50,
                                  left: 50,
                                  child: FloatingActionButton(
                                    heroTag: "pan card",
                                    mini: true,
                                    onPressed: () {
                                      setState(() {
                                        panCard();
                                      });
                                    },child: Icon(Icons.add),)),

                            ])):Image.file(File(selectImage2!.path)),
                  ),
                  Divider(),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Driver Image"),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: selectImage3==null?DottedBorder(

                        radius:const Radius.circular(5.0),
                        dashPattern: [5,4],
                        borderType: BorderType.RRect,
                        child: Stack(

                            children: [
                              Image.asset("images/upload_image.jpg"),
                              Positioned(
                                  top: 50,
                                  left: 50,
                                  child: FloatingActionButton(
                                    heroTag: "driver image",
                                    mini: true,
                                    onPressed: () {
                                      setState(() {
                                        driverImage();
                                      });
                                    },child: Icon(Icons.add),)),

                            ])):Image.file(File(selectImage3!.path)),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Bank Passbook"),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: selectImage4==null?DottedBorder(

                        radius:const Radius.circular(5.0),
                        dashPattern: [5,4],
                        borderType: BorderType.RRect,
                        child: Stack(

                            children: [
                              Image.asset("images/upload_image.jpg"),
                              Positioned(
                                  top: 50,
                                  left: 50,
                                  child: FloatingActionButton(
                                    heroTag: "bankPassbook",
                                    mini: true,
                                    onPressed: () {
                                      setState(() {
                                       bankPassbook();
                                      });
                                    },child: Icon(Icons.add),)),

                            ])):Image.file(File(selectImage4!.path)),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Joining Form"),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: selectImage5==null?DottedBorder(

                        radius:const Radius.circular(5.0),
                        dashPattern: [5,4],
                        borderType: BorderType.RRect,
                        child: Stack(

                            children: [
                              Image.asset("images/upload_image.jpg"),
                              Positioned(
                                  top: 50,
                                  left: 50,
                                  child: FloatingActionButton(
                                    heroTag: "joiningForm",
                                    mini: true,
                                    onPressed: () {
                                      setState(() {
                                       joiningForm();
                                      });
                                    },child: Icon(Icons.add),)),

                            ])):Image.file(File(selectImage5!.path)),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Work Permit"),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: selectImage6==null?DottedBorder(

                        radius:const Radius.circular(5.0),
                        dashPattern: [5,4],
                        borderType: BorderType.RRect,
                        child: Stack(

                            children: [
                              Image.asset("images/upload_image.jpg"),
                              Positioned(
                                  top: 50,
                                  left: 50,
                                  child: FloatingActionButton(
                                    heroTag: "work Permit",
                                    mini: true,
                                    onPressed: () {
                                      setState(() {
                                        workPermit();
                                      });
                                    },child: Icon(Icons.add),)),

                            ])):Image.file(File(selectImage6!.path)),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Insurance Certificate"),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: selectImage7==null?DottedBorder(

                        radius:const Radius.circular(5.0),
                        dashPattern: [5,4],
                        borderType: BorderType.RRect,
                        child: Stack(

                            children: [
                              Image.asset("images/upload_image.jpg"),
                              Positioned(
                                  top: 50,
                                  left: 50,
                                  child: FloatingActionButton(
                                    heroTag: "insuranceCertificate",
                                    mini: true,
                                    onPressed: () {
                                      setState(() {
                                        insuranceCertificate();
                                      });
                                    },child: Icon(Icons.add),)),

                            ])):Image.file(File(selectImage7!.path)),
                  ),

                  Padding(padding: EdgeInsets.all(8.0),
                  child:FloatingActionButton.extended(
                    splashColor: Colors.white.withOpacity(.5),
                    extendedPadding: EdgeInsets.symmetric(horizontal: 100),
                    onPressed: () {
                      setState(() {
                        print(vehicleType);
                        print(vehicleModel);
                        if(profileKey.currentState!.validate()){
                          uploadData(widget.token, name.text, email.text,male, ifsc.text, mobile.text, birthdate.text, address.text, pinCode.text, bankName.text, accNumber.text, accHolderName.text, branch.text, vehicleName.text, vehicleNumber.text,"$vehicleType",  "$vehicleModel",selectCity);
                          profileKey.currentState!.save();
                        }
                      });
                    },
                    label: const Text("Submit"),
                  ),
                  ),

                ])),
          ),
        ),
      ),
    );

  }
}
