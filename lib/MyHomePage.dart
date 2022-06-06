import 'dart:convert';

import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tezz_driver_app/BaseUrl.dart';
import 'package:http/http.dart' as http;

import 'package:tezz_driver_app/Controller/BookingController.dart';

import 'package:tezz_driver_app/Pages/AssignOrderPage.dart';
import 'package:tezz_driver_app/Pages/HomePage.dart';

import 'package:tezz_driver_app/Pages/OrderHistoryPage.dart';


import 'package:tezz_driver_app/constant.dart';

import 'package:tezz_driver_app/drawer.dart';

class MyHomePage extends StatefulWidget {
  static String id="HomePage";
  final String token;
  const MyHomePage({Key? key,  required this.token}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();

}


class _MyHomePageState extends State<MyHomePage> {


  String username="";
  String email="";
  String contact="";
  BookingController bookingController =Get.put(BookingController());
  //MyProfileController myProfileController=Get.put(MyProfileController());
 late String uid;
 List<Widget> pages=[];
 int currentIndex=0;
 Widget? currentPage;
 final key=GlobalKey<ScaffoldState>();
 late HomePage dashBoardPage;
 AssignOrderPage assignOrderPage=AssignOrderPage();
 OrderHistoryPage orderHistoryPage=OrderHistoryPage();
  DateTime? backButtonPressTime;
  final snackBar = const SnackBar(
    content: Text('Press back again to leave'),
    duration: Duration(seconds: 3),
  );
  Future<bool> handleWillPop(BuildContext context) async {
    final now = DateTime.now();
    final backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
        backButtonPressTime == null ||
            now.difference(backButtonPressTime!) > const Duration(seconds: 3);

    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
      backButtonPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }

    return true;
  }
  var data;
  storeData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("key", widget.token);

    data = sharedPreferences.getString("key");
    print("Token data into sharedPreferences:$data");
    fetchData(widget.token);
  }
  fetchData(String token) async{
    final res= await http.get(Uri.parse("${baseUrl}api/driverProfileApi"),headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print("Drawer Response :${res.body}");
    Map<String,dynamic> result=jsonDecode(res.body);
    if(res.statusCode==200){
     setState(() {
       username=result["data"]["Name"];
       email=result["data"]["Email"];
       contact=result["data"]["Mobile"];
     });
      print("list"+contact);
      print("Main Profile Response${res.body}");
    }
    else{
      print("Main Profile Response ${res.statusCode}");
    }
  }
  @override
  void initState() {

    setState(() {
      storeData();
      dashBoardPage=HomePage(token: widget.token);
      pages=[dashBoardPage,assignOrderPage,orderHistoryPage];
      currentPage=pages[currentIndex];
      bookingController.fetchData(widget.token);
      //myProfileController.fetchMyProfile(token);

    });
    // print(DateTime.parse("27-2-2021"));
   // print(bookingController.booking.first.data.length);
    //print("main token from home page ${widget.tokenId}");
    //uid=FirebaseAuth.instance.currentUser!.uid;

    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    bookingController.booking.clear();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(

      onWillPop:()=>handleWillPop(context),
      child: Scaffold(
        appBar:AppBar(
          actions: <Widget>[
            IconButton(onPressed: (){

              //Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchLocation()));
      }, icon: const Icon(Icons.search))
          ],
          backgroundColor: Scolor,
          title: const Text("Tezz Driver"),

        ),
        drawer: SizedBox(
          width: 250,
          child: Drawer(
            child:DrawerWidget(token: widget.token,username: "$username",email: "$email",contact: "$contact",),
          ),
        ),
        body: currentPage,
        bottomNavigationBar:FancyBottomNavigation(
          inactiveIconColor: Colors.black45,
          textColor: Colors.black,

          initialSelection: currentIndex,


          tabs: [
            TabData(iconData:Icons.home, title: "Home"),
            TabData(iconData: Icons.local_taxi_sharp, title: "Assign Order"),
            TabData(iconData:Icons.history, title: "History"),
          ],
          circleColor: Colors.deepOrangeAccent,
          onTabChangedListener: (index){
            setState(() {
              setState(() {
                currentIndex=index;
                currentPage=pages[currentIndex];
              });
            });
          },
          activeIconColor: Colors.white,
        ),

        /*Obx((){
          return ListView.builder(
              itemCount: bookingController.booking.length,
              itemBuilder: (context, index) =>
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailOrder()));
                      },
                      child: Container(
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height*0.24,
                        width: 150,
                        child: Card(
                          elevation: 5,
                          child: Column(
                            children: [
                              Padding(
                                padding:  const EdgeInsets.only(left: 15.0,right: 15,top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 2,),
                                          Text("ID: ${bookingController.booking[index].data[index].id}",style: const TextStyle(fontSize: 10),),
                                          const SizedBox(height: 2,),
                                          Text("Date :${bookingController.booking[index].data[index].startDate}",style: const TextStyle(fontSize: 10),),
                                          const SizedBox(height: 2,),
                                          Text("End Date ${bookingController.booking[index].data[index].endDate}",style: const TextStyle(fontSize: 10),),
                                          const SizedBox(height: 2,),
                                          Text("TripType :${bookingController.booking[index].data[index].rideType}",style: const TextStyle(fontSize: 10),),
                                        ],
                                      ),
                                    ),
                                    Card(
                                      elevation: 5,
                                      child: Container(

                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                            border: Border.all(
                                                color: Colors.white,width: 0
                                            ),
                                            borderRadius: BorderRadius.circular(10) ,

                                        ),
                                        child: Column(
                                          children: [
                                            Container(

                                              height: 15,
                                              width: 80,
                                              child: const Center(child: Text("PickUp Date",style: TextStyle(fontSize: 11,color: Colors.white),)),color: Scolor,),
                                            Text("${bookingController.booking[index].data[index].startDate}",style: const TextStyle(fontSize: 12)),
                                            const Text("Monday",style: TextStyle(fontSize: 8),),
                                            Text("${bookingController.booking[index].data[index].time}",style: const TextStyle(fontSize: 12),),

                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:  const EdgeInsets.only(left: 15.0,right: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.location_on,color: Scolor,),
                                    Text("${bookingController.booking[index].data[index].destinationAddress}",style: const TextStyle(fontSize: 12),)
                                  ],
                                ),
                              ),
                              const Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [

                                      Text("Fare Amount  ",style: TextStyle(fontSize: 10),),
                                      Text("${bookingController.booking[index].data[index].totalAmount} \u{20B9} ",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),

                                    ],

                                  ),
                                  Container(
                                    height: 30,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Scolor,
                                      borderRadius: BorderRadius.circular(10)


                                    ),
                                   child: const Center(child: Text("Get Details",style: TextStyle(color: Colors.white),)),

                                  )

                                ],
                              )
                            ],
                          ),


                        ),
                      ),
                    ),
                  ));
        })*/
      ));
  }
}
