import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tezz_driver_app/Controller/BookingController.dart';
import 'package:tezz_driver_app/Controller/BookingController/BookingControllerHourly.dart';
import 'package:tezz_driver_app/Controller/BookingController/BookingControllerOneWay.dart';
import 'package:tezz_driver_app/Controller/BookingController/BookingControllerRound.dart';
import 'package:tezz_driver_app/Controller/RegistrationOTPController.dart';
import 'package:tezz_driver_app/Pages/DetailPage.dart';
import 'package:tezz_driver_app/constant.dart';
import 'package:tezz_driver_app/drawer.dart';

import '../Controller/WalletAPI/walletMainController.dart';

class DashBoardPage extends StatefulWidget {
  final String token;
  const DashBoardPage({Key? key,required this.token}) : super(key: key);

  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage>
    with SingleTickerProviderStateMixin {
  final drawerKey=GlobalKey<ScaffoldState>();
  WalletController walletController=Get.put(WalletController());
  BookingControllerOneWay bookingControllerOneWay =
      Get.put(BookingControllerOneWay());
  BookingControllerHourly bookingControllerHourly =
      Get.put(BookingControllerHourly());
  BookingControllerRound bookingControllerRound =
      Get.put(BookingControllerRound());


  late TabController tabController;
  bool showCircular=true;

  @override
  void initState() {
    // token=registrationController.register.first.token;
    tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    setState(() {
      bookingControllerOneWay.fetchData(widget.token);
      bookingControllerHourly.fetchData(widget.token);
      bookingControllerRound.fetchData(widget.token);
    });
    Timer(const Duration(seconds: 5,),(){
    setState(() {
      showCircular=false;
    });

    });
    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(
              height: 60,
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child:Padding(
                    padding: const EdgeInsets.only(left:10.0,right:10),
                    child: TabBar(

                      indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Colors.black,

                    controller: tabController, tabs: [
                const Tab(

                    child: Text("OneWay",style: TextStyle(color: Colors.black,fontSize: 12)),
                    icon: const Icon(Icons.double_arrow_rounded, size: 16,color: Colors.black,),
                ),
                const Tab(
                     child: Text(
                      "Round",
                         style: TextStyle(color: Colors.black,fontSize: 12)
                    ),
                    icon: Icon(Icons.compare_arrows_rounded, size: 16,color: Colors.black),
                ),
                const Tab(
                    child: Text("Hourly",
                        style: const TextStyle(color: Colors.black,fontSize: 12)
                    ),
                    icon: Icon(Icons.lock_clock_rounded, size: 16,color: Colors.black,),
                ),
                const Tab(
                    child: Text(
                        "AirPort",
                        style: const TextStyle(color: Colors.black,fontSize: 12)
                      ),
                      icon: const Icon(Icons.airplanemode_active,
                        size: 16,
                        color: Colors.black,)),
              ]),
                  )),
            ),
            Expanded(
              child: TabBarView(controller: tabController,
                  children: [
                Obx(() {
                  if (bookingControllerOneWay.booking.isEmpty) {
                    return
                      showCircular==true
                          ?Center(
                          child: Container(
                              height: 60,
                              width: 60,
                              child: Image.asset(
                                "images/spin.gif",
                              )))
                          :Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                             Lottie.asset("images/no-ride.json"),

                              const Center(child: const Text("No ride Available")),
                            ],
                          );
                  }
                  return ListView.builder(
                      itemCount: bookingControllerOneWay.booking.length,
                      itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              color: Colors.white,
                              //height: MediaQuery.of(context).size.height * 0.24,
                              width: 150,
                              child: InkWell(
                                onTap: () {
                                  // int? id =bookingController.booking[index].data[index].id;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailOrder(
                                              id: bookingControllerOneWay
                                                  .booking[index].data[index].id)));
                                },
                                child: Card(
                                  elevation: 5,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, right: 15, top: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [

                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      "Trip Type : ${bookingControllerOneWay.booking[index].data[index].rideType}",

                                                    ),
                                                  ),

                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      "Date :${bookingControllerOneWay.booking[index].data[index].startDate}",

                                                    ),
                                                  ),

                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      "End Date ${bookingControllerOneWay.booking[index].data[index].endDate}",


                                                    ),
                                                  ),

                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 120,
                                              child: Card(
                                                elevation: 5,
                                                child: Column(

                                                  children: [

                                                   Container(
                                                     width: MediaQuery.of(context).size.width,
                                                     color:Colors.deepOrange,
                                                     child: Center(child: const Padding(
                                                       padding: EdgeInsets.all(8.0),
                                                       child: Text("PickUp Date",style: const TextStyle(color: Colors.white)),
                                                     )),
                                                   ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(4.0),
                                                      child: Text(
                                                          "${bookingControllerOneWay.booking[index].data[index].startDate}",
                                                          style: const TextStyle(
                                                              fontSize: 12)),
                                                    ),
                                                    const Padding(
                                                      padding: EdgeInsets.all(4.0),
                                                      child: Text(
                                                        "Monday",
                                                        style: TextStyle(fontSize: 14),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(4.0),
                                                      child: Text(
                                                        "${bookingControllerOneWay.booking[index].data[index].time}",
                                                        style: const TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, right: 12),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              Icons.location_on_outlined,

                                            ),
                                            Text(
                                              "${bookingControllerOneWay.booking[index].data[index].destination}",
                                              style: const TextStyle(fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),
                                      const Divider(),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: <Widget>[
                                                const Text("Fare Amount -",),
                                                Text(
                                                  " \u{20B9} ${bookingControllerOneWay.booking[index].data[index].totalAmount}",
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              height: 30,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  color: Scolor,
                                                  borderRadius:
                                                      BorderRadius.circular(10)),
                                              child: const Center(
                                                  child: Text(
                                                "Get Details",
                                                style: TextStyle(color: Colors.white),
                                              )),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ));
                }),
                ////////////////////////////////////////////////
                //////////////Tab Bar 2 begin//////////////////////
                ///////////////////////////////////////////////
                Obx(() {
                  if (bookingControllerRound.booking.isEmpty) {
                    return

                      showCircular==true
                          ?Center(
                              child: Container(
                                  height: 60,
                                  width: 60,
                                  child: Image.asset(
                                    "images/spin.gif",
                                  )))
                          :Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset("images/no-ride.json"),

                              const Center(child: const Text("No ride Available")),
                            ],
                          );
                  }
                  return ListView.builder(
                      itemCount: bookingControllerRound.booking.length,
                      itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              color: Colors.white,
                              width: 150,
                              child: InkWell(
                                onTap: () {
                                  // int? id =bookingController.booking[index].data[index].id;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailOrder(
                                              id: bookingControllerRound
                                                  .booking[index].data[index].id)));
                                },
                                child: Card(
                                  elevation: 5,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, right: 15, top: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                    "ID: ${bookingControllerRound.booking[index].data[index].id}",
                                                    style:
                                                        const TextStyle(fontSize: 10),
                                                  ),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                    "Date :${bookingControllerRound.booking[index].data[index].startDate}",
                                                    style:
                                                        const TextStyle(fontSize: 10),
                                                  ),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                    "End Date ${bookingControllerRound.booking[index].data[index].endDate}",
                                                    style:
                                                        const TextStyle(fontSize: 10),
                                                  ),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                    "TripType :${bookingControllerRound.booking[index].data[index].rideType}",
                                                    style:
                                                        const TextStyle(fontSize: 10),
                                                  ),
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
                                                      color: Colors.white, width: 0),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: 15,
                                                      width: 80,
                                                      child: const Center(
                                                          child: Text(
                                                        "PickUp Date",
                                                        style: TextStyle(
                                                            fontSize: 11,
                                                            color: Colors.white),
                                                      )),
                                                      color: Scolor,
                                                    ),
                                                    Text(
                                                        "${bookingControllerRound.booking[index].data[index].startDate}",
                                                        style: const TextStyle(
                                                            fontSize: 12)),
                                                    const Text(
                                                      "Monday",
                                                      style: TextStyle(fontSize: 8),
                                                    ),
                                                    Text(
                                                      "${bookingControllerRound.booking[index].data[index].time}",
                                                      style: const TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, right: 12),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              Icons.location_on_outlined,

                                            ),
                                            Text(
                                              "${bookingControllerRound.booking[index].data[index].destination}",
                                              style: const TextStyle(fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),
                                      const Divider(),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: <Widget>[
                                                const Text("Fare Amount  ",
                                                    style: TextStyle(fontSize: 10)),
                                                Text(
                                                  "${bookingControllerRound.booking[index].data[index].totalAmount} \u{20B9} ",
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              height: 30,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  color: Scolor,
                                                  borderRadius:
                                                      BorderRadius.circular(10)),
                                              child: const Center(
                                                  child: Text(
                                                "Get Details",
                                                style: TextStyle(color: Colors.white),
                                              )),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ));
                }),
                //////////////////////////////////////////////////
                //////// TabBar 3 Begin/////////////////
                /////////////////////////////////
                Obx(() {
                  if (bookingControllerHourly.booking.isEmpty) {
                    return
                      showCircular==true
                          ?Center(
                          child: Container(
                              height: 60,
                              width: 60,
                              child: Image.asset(
                                "images/spin.gif",
                              )))
                          :Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset("images/no-ride.json"),

                              const Center(child: const Text("No ride Available")),
                            ],
                          );
                  }
                  return ListView.builder(
                      itemCount: bookingControllerHourly.booking.length,
                      itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              color: Colors.white,
                              width: 150,
                              child: InkWell(
                                onTap: () {
                                  // int? id =bookingController.booking[index].data[index].id;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailOrder(
                                              id: bookingControllerHourly
                                                  .booking[index].data[index].id)));
                                },
                                child: Card(
                                  elevation: 5,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, right: 15, top: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                    "ID: ${bookingControllerHourly.booking[index].data[index].id}",
                                                    style:
                                                        const TextStyle(fontSize: 10),
                                                  ),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                    "Date :${bookingControllerHourly.booking[index].data[index].startDate}",
                                                    style:
                                                        const TextStyle(fontSize: 10),
                                                  ),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                    "End Date ${bookingControllerHourly.booking[index].data[index].endDate}",
                                                    style:
                                                        const TextStyle(fontSize: 10),
                                                  ),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                    "TripType :${bookingControllerHourly.booking[index].data[index].rideType}",
                                                    style:
                                                        const TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 120,
                                              child: Card(
                                                elevation: 5,
                                                child: Column(

                                                  children: [

                                                    Container(
                                                      decoration:const BoxDecoration(
                                                        color:Colors.deepOrange,

                                                      ),
                                                      width: MediaQuery.of(context).size.width,

                                                      child: Center(child: const Padding(
                                                        padding: EdgeInsets.all(8.0),
                                                        child: Text("PickUp Date",style: TextStyle(color: Colors.white)),
                                                      )),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(4.0),
                                                      child: Text(
                                                          "${bookingControllerHourly.booking[index].data[index].startDate}",
                                                          style: const TextStyle(
                                                              fontSize: 12)),
                                                    ),
                                                    const Padding(
                                                      padding: EdgeInsets.all(4.0),
                                                      child: Text(
                                                        "Monday",
                                                        style: TextStyle(fontSize: 14),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(4.0),
                                                      child: Text(
                                                        "${bookingControllerHourly.booking[index].data[index].time}",
                                                        style: const TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, right: 12),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              Icons.location_on_outlined,

                                            ),
                                            Text(
                                              "${bookingControllerHourly.booking[index].data[index].destinationAddress}",
                                              style: const TextStyle(fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),

                                      const Divider(),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: <Widget>[
                                                  const Text("Fare Amount  ",
                                                      style: TextStyle(fontSize: 10)),
                                                  Text(
                                                    "${bookingControllerHourly.booking[index].data[index].totalAmount} \u{20B9} ",
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 30,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  color: Scolor,
                                                  borderRadius:
                                                      BorderRadius.circular(10)),
                                              child: const Center(
                                                  child: Text(
                                                "Get Details",
                                                style: TextStyle(color: Colors.white),
                                              )),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ));
                }),
                ///////////////////////////////////
                    //tab4 begin

                //////////////////////////////
                Obx(() {
                  if (bookingControllerRound.booking.isEmpty) {
                    return

                      showCircular==true
                          ?Center(
                          child: Container(
                              height: 60,
                              width: 60,
                              child: Image.asset(
                                "images/spin.gif",
                              )))
                          :Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset("images/no-ride.json"),

                              const Center(child: const Text("No ride Available")),
                            ],
                          );
                  }
                  return ListView.builder(
                      itemCount: bookingControllerRound.booking.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          color: Colors.white,
                          width: 150,
                          child: InkWell(
                            onTap: () {
                              // int? id =bookingController.booking[index].data[index].id;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailOrder(
                                          id: bookingControllerRound
                                              .booking[index].data[index].id)));
                            },
                            child: Card(
                              elevation: 5,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15, top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                "ID: ${bookingControllerRound.booking[index].data[index].id}",
                                                style:
                                                const TextStyle(fontSize: 10),
                                              ),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                "Date :${bookingControllerRound.booking[index].data[index].startDate}",
                                                style:
                                                const TextStyle(fontSize: 10),
                                              ),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                "End Date ${bookingControllerRound.booking[index].data[index].endDate}",
                                                style:
                                                const TextStyle(fontSize: 10),
                                              ),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                "TripType :${bookingControllerRound.booking[index].data[index].rideType}",
                                                style:
                                                const TextStyle(fontSize: 10),
                                              ),
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
                                                  color: Colors.white, width: 0),
                                              borderRadius:
                                              BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 15,
                                                  width: 80,
                                                  child: const Center(
                                                      child: Text(
                                                        "PickUp Date",
                                                        style: TextStyle(
                                                            fontSize: 11,
                                                            color: Colors.white),
                                                      )),
                                                  color: Scolor,
                                                ),
                                                Text(
                                                    "${bookingControllerRound.booking[index].data[index].startDate}",
                                                    style: const TextStyle(
                                                        fontSize: 12)),
                                                const Text(
                                                  "Monday",
                                                  style: TextStyle(fontSize: 8),
                                                ),
                                                Text(
                                                  "${bookingControllerRound.booking[index].data[index].time}",
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 12),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.location_on_outlined,

                                        ),
                                        Text(
                                          "${bookingControllerRound.booking[index].data[index].destinationAddress}",
                                          style: const TextStyle(fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Divider(),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: <Widget>[
                                            const Text("Fare Amount  ",
                                                style: TextStyle(fontSize: 10)),
                                            Text(
                                              "${bookingControllerRound.booking[index].data[index].totalAmount} \u{20B9} ",
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          height: 30,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              color: Scolor,
                                              borderRadius:
                                              BorderRadius.circular(10)),
                                          child: const Center(
                                              child: Text(
                                                "Get Details",
                                                style: TextStyle(color: Colors.white),
                                              )),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ));
                }),
              ]),
            ),
          ],
        ));
  }
}
