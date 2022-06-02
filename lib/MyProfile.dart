import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tezz_driver_app/BaseUrl.dart';
import 'package:tezz_driver_app/Controller/MyProfileController.dart';
import 'package:tezz_driver_app/Pages/CurvePainter.dart';
import 'package:tezz_driver_app/Pages/UpdateProfilePage.dart';
import 'package:tezz_driver_app/constant.dart';
import 'constant.dart';
class MyProfileDetails extends StatefulWidget {
  final String token;
  const MyProfileDetails({Key? key,required this.token}) : super(key: key);

  @override
  State<MyProfileDetails> createState() => _MyProfileDetailsState();
}

class _MyProfileDetailsState extends State<MyProfileDetails> {

  MyProfileController myProfileController =Get.put(MyProfileController());
@override
  void initState() {

  myProfileController.fetchMyProfile(widget.token);
  print(myProfileController.myProfile.length);
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
  myProfileController.myProfile.clear();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Scolor,
        title: const Text("My Profile "),
        actions: [
          IconButton(onPressed: (){
            setState(() {
              Navigator.push(context,MaterialPageRoute(builder: (context)=>UpdateProfilePage(token: widget.token)));
            });
          }, icon: Icon(Icons.edit))

        ],
      ),
      body: RefreshIndicator(
        onRefresh: ()=>myProfileController.fetchMyProfile(widget.token),
        child: Center(
          child: SingleChildScrollView(
            child: Obx((){
              return  myProfileController.myProfile.isNotEmpty
                  ?Card(
                    margin: EdgeInsets.zero,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Stack(
                          alignment: Alignment.topCenter,
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                             decoration: BoxDecoration(
                               image: DecorationImage(
                                 fit: BoxFit.cover,
                                 image: AssetImage("images/background.jpg"),
                               )
                             ),
                            ),
                            Positioned(
                              top: 120,

                              child: Card(
                                shape: StadiumBorder(),
                                child: const CircleAvatar(
                                  radius: 80,
                                  backgroundImage: AssetImage("images/taxi1.jpg"),
                                ),
                              ),
                            )

                          ],),



                        Padding(
                          padding: const EdgeInsets.only(left:10,top:100.0),
                          child: Text("Personal Information",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Scolor),),
                        ),
                        Divider(),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(top: 8.0,left: 15,bottom: 8),
                                  child: Text("Name :",style: TextStyle(color: KColor),),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(top: 8.0,left: 15,bottom: 8),
                                  child: Text("Email :",style: TextStyle(color: KColor)),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(top: 8.0,left: 15,bottom: 8),
                                  child: Text("Mobile :",style: TextStyle(color: KColor)),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(top: 8.0,left: 15,bottom: 8),
                                  child: Text("Gender :",style: TextStyle(color: KColor)),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(top: 8.0,left: 15,bottom: 8),
                                  child: Text("DOB :",style: TextStyle(color: KColor)),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(top: 8.0,left: 15,bottom: 8),
                                  child: Text("Address :",style: TextStyle(color: KColor)),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(top: 8.0,left: 15,bottom: 8),
                                  child: Text("Pin :",style: TextStyle(color: KColor)),
                                ),


                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(myProfileController.myProfile.first.data.name??"-"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(myProfileController.myProfile.first.data.email??"-"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(myProfileController.myProfile.first.data.mobile??""),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(myProfileController.myProfile.first.data.gender??"-"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(myProfileController.myProfile.first.data.dob??"-"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(myProfileController.myProfile.first.data.address??"-"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(myProfileController.myProfile.first.data.pinCode??"-"),
                                ),




                              ],
                            )
                          ],
                        ),
                       /* SizedBox(height: 40,),*/

                        Padding(
                          padding:  EdgeInsets.only(top: 8.0,left: 15,bottom: 8),
                          child: Text("Vehicle Details",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Scolor),),
                        ),

                        Divider(),
                        Row(

                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(top: 8.0,left: 15,bottom: 8),
                                  child: Text("VehicleName :",style: TextStyle(color: KColor)),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(top: 8.0,left: 15,bottom: 8),
                                  child: Text("VehicleNumber :",style: TextStyle(color: KColor)),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(top: 8.0,left: 15,bottom: 8),
                                  child: Text("VehicleType :",style: TextStyle(color: KColor)),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(top: 8.0,left: 15,bottom: 8),
                                  child: Text("VehicleModelName :",style: TextStyle(color: KColor)),
                                ),


                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(myProfileController.myProfile.first.data.vehicleName??"-"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(myProfileController.myProfile.first.data.vehicleNumber??"-"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(myProfileController.myProfile.first.data.vehicleType??"-"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(myProfileController.myProfile.first.data.vehicleModelName??"-"),
                                ),






                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 40,),

                        Padding(
                          padding:  EdgeInsets.only(top: 8.0,left: 15,bottom: 8),
                          child: Text("Bank Details",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Scolor),),
                        ),
                        Divider(thickness: 2,),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(top: 8.0,left: 15,bottom: 8),
                                  child: Text("BankName :",style: TextStyle(color: KColor)),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(top: 8.0,left: 15,bottom: 8),
                                  child: Text("AccountHolderName :",style: TextStyle(color: KColor)),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(top: 8.0,left: 15,bottom: 8),
                                  child: Text("BranchName :",style: TextStyle(color: KColor)),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(top: 8.0,left: 15,bottom: 8),
                                  child: Text("AccountNumber :",style: TextStyle(color: KColor)),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(top: 8.0,left: 15,bottom: 8),
                                  child: Text("IFSC Code :",style: TextStyle(color: KColor)),
                                ),



                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(myProfileController.myProfile.first.data.bankName??"-"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(myProfileController.myProfile.first.data.accountHolderName??"-"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(myProfileController.myProfile.first.data.branchName??"-"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(myProfileController.myProfile.first.data.accountNumber??"-"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(myProfileController.myProfile.first.data.ifsc??"-"),
                                ),







                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 40,),
                        Padding(
                          padding:  EdgeInsets.only(top: 8.0,left: 15,bottom: 8),
                          child: Text("Uploaded Documents",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Scolor),),
                        ),
                        Divider(thickness: 2,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Aadhar :"),
                            Container(
                              height: 150,
                              width: 150,
                              child:  myProfileController.myProfile.first.data.adhar!.isEmpty?Image.asset("images/no-data.png"):Image.network("${baseUrl}"+"${myProfileController.myProfile.first.data.adhar.toString()}"),
                            )

                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Pan Card :"),
                            Container(
                              height: 150,
                              width: 150,
                              child:   myProfileController.myProfile.first.data.pan!.isEmpty?Image.asset("images/no-data.png"):Image.network("${baseUrl}"+"${myProfileController.myProfile.first.data.pan.toString()}"),
                            )

                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Insurance :"),
                            Container(
                              height: 150,
                              width: 150,
                              child:  myProfileController.myProfile.first.data.insurance!.isEmpty?Image.asset("images/no-data.png"): Image.network("${baseUrl}"+"${myProfileController.myProfile.first.data.insurance.toString()}"),
                            )

                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Licence :"),
                            Container(
                              height: 150,
                              width: 150,
                              child:   myProfileController.myProfile.first.data.licence!.isEmpty?Image.asset("images/no-data.png"):Image.network("${baseUrl}"+"${myProfileController.myProfile.first.data.licence.toString()}"),
                            )

                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("WorkPermit :"),
                            Container(
                              height: 150,
                              width: 150,
                              child:   myProfileController.myProfile.first.data.workPermit!.isEmpty?Image.asset("images/no-data.png"):Image.network("${baseUrl}"+"${myProfileController.myProfile.first.data.workPermit.toString()}"),
                            )

                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("JoiningForm :"),
                            Container(
                              height: 150,
                              width: 150,
                              child:  myProfileController.myProfile.first.data.joiningForm!.isEmpty?Image.asset("images/no-data.png"): Image.network("${baseUrl}"+"${myProfileController.myProfile.first.data.joiningForm.toString()}"),
                            )

                          ],
                        ), SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("BankPassbook :"),
                            Container(
                              height: 150,
                              width: 150,
                              child:  myProfileController.myProfile.first.data.bankPassbook!.isEmpty?Image.asset("images/no-data.png"): Image.network("${baseUrl}"+"${myProfileController.myProfile.first.data.bankPassbook.toString()}"),
                            )

                          ],
                        ),
                      ],
                    ),
                  ):
             CircularProgressIndicator();
            }),
          ),
        ),
      ),
    );
  }
}
