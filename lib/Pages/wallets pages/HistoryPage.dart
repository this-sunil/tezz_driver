import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tezz_driver_app/Controller/BookingHistoryController.dart';
import 'package:tezz_driver_app/Pages/HistoryDetails.dart';
class HistoryPage extends StatefulWidget {
  final String token;
  const HistoryPage({Key? key,required this.token}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  BookingHistoryController bookingHistoryController=Get.put(BookingHistoryController());
  @override
  void initState() {
    setState(() {
      bookingHistoryController.fetchData(widget.token);
      if(bookingHistoryController.bookingHistoryList.isNotEmpty){
        print("api cal ${bookingHistoryController.bookingHistoryList.first.mobile}");
      }
    });
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
      ),
      body:Obx((){

        if(bookingHistoryController.bookingHistoryList.isNotEmpty){
          return ListView.builder(
              itemCount: bookingHistoryController.bookingHistoryList.length,
              itemBuilder: (context,index){
                return Card(
                    child:ListTile(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>HistoryDetails(
                            rideType: bookingHistoryController.bookingHistoryList[index].rideType,
                            origin: bookingHistoryController.bookingHistoryList[index].from,destination: bookingHistoryController.bookingHistoryList[index].destination,startDate: bookingHistoryController.bookingHistoryList[index].startDate,endDate: bookingHistoryController.bookingHistoryList[index].endDate,totalAmount: bookingHistoryController.bookingHistoryList[index].totalAmount.toString(),bidAmount: bookingHistoryController.bookingHistoryList[index].biddingAmmount,destinationAddress: bookingHistoryController.bookingHistoryList[index].destinationAddress,mobile: bookingHistoryController.bookingHistoryList[index].mobile,pickUp: bookingHistoryController.bookingHistoryList[index].pickupAddress,time: bookingHistoryController.bookingHistoryList[index].time)));
                      },
                      title: Text("${bookingHistoryController.bookingHistoryList[index].email}"),
                      subtitle: Text("${bookingHistoryController.bookingHistoryList[index].rideType}"),
                      trailing: Text("\u{20B9} ${bookingHistoryController.bookingHistoryList[index].totalAmount}"),
                    ));
              });
        }
        return Center(child: Lottie.asset("images/no-ride.json"));
      }),
    );
  }
}
