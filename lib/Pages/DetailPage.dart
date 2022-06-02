import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tezz_driver_app/Controller/BookingDetailsController.dart';
import 'package:tezz_driver_app/constant.dart';
class DetailOrder extends StatefulWidget {
  final int? id;


   DetailOrder( {Key? key,this.id}) : super(key: key);

  @override
  State<DetailOrder> createState() => _DetailOrderState();
}



class _DetailOrderState extends State<DetailOrder> {
  BookingDetailsController bookingDetailsController=Get.put(BookingDetailsController());
  //var dayApi=DateFormat('d').format(DateTime.parse(bookingDetailsController.bookingDetailsModel.first.strtDate.toString()));
  @override
  void initState() {
    print(widget.id);
   // var day=DateTime.tryParse(bookingDetailsController.bookingDetailsModel.first.strtDate.toString())!.weekday;
    //print(day);
    bookingDetailsController.bookingDetailsGet(widget.id!.toInt());
   // print(bookingDetailsController.bookingDetailsModel.first.strtDate);
    //print(dayApi);
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    bookingDetailsController.bookingDetailsModel.clear();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Trip Details"),
        backgroundColor: Scolor,
      ),
      body:  SingleChildScrollView(
        child: Obx((){
          return bookingDetailsController.bookingDetailsModel.length>0
              ?Padding(
            padding: const EdgeInsets.all(08.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                          children:  [
                            SizedBox(height: 2,),
                            Text("ID:${bookingDetailsController.bookingDetailsModel.first.id.toString()} ",style: TextStyle(fontSize: 10),),
                            SizedBox(height: 2,),
                            Text("Date :${bookingDetailsController.bookingDetailsModel.first.strtDate.toString()}",style: TextStyle(fontSize: 10),),
                            SizedBox(height: 2,),
                            Text("End Date :${bookingDetailsController.bookingDetailsModel.first.endDate}",style: TextStyle(fontSize: 10),),
                            SizedBox(height: 2,),
                            Text("TripType : ${bookingDetailsController.bookingDetailsModel.first.rideType.toString()}",style: TextStyle(fontSize: 10),),
                          ],
                        ),
                      ),
                      Card(
                        elevation: 10,
                        child: Container(

                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: Colors.white,width: 0
                            ),
                            borderRadius: BorderRadius.circular(10) ,

                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,                           children: [
                              Container(height: 20,
                                  color: Scolor,child: Center(child: Text("PickUp Date",style: TextStyle(fontSize: 11,color: Colors.white),))),
                               Text("${bookingDetailsController.bookingDetailsModel.first.strtDate.toString()}",style: TextStyle(fontSize: 10)),
                              Text(  "${bookingDetailsController.bookingDetailsModel.first.startDay}",style: TextStyle(fontSize: 12),),
                               Text("${bookingDetailsController.bookingDetailsModel.first.time}",style: TextStyle(fontSize: 10),),

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

                       Text("${bookingDetailsController.bookingDetailsModel.first.pickUpLocation.toString()}",style: TextStyle(fontSize: 12),)

                    ],
                  ),
                ),
                const Divider(),
                Text("Traveller Information",style: TextStyle(fontSize: 18,color: Scolor),),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children:  [
                              Icon(Icons.person),
                              Text('${bookingDetailsController.bookingDetailsModel.first.name.toString()}'),
                            ],
                          ),
                          const SizedBox(height: 8,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: const [
                                  Icon(Icons.location_on,size: 15,),
                                  Text('Pick Up Address',style: TextStyle(fontSize: 12),),
                                ],
                              ),

                            ],
                          ),const SizedBox(height: 8,),

                           Text("${bookingDetailsController.bookingDetailsModel.first.pickUpLocation.toString()}",style: TextStyle(fontSize: 12),),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [

                          Row(
                            children:  [
                              Icon(Icons.phone),
                              Text('${bookingDetailsController.bookingDetailsModel.first.mobile.toString()}'),
                            ],
                          ),
                          const SizedBox(height: 8,),
                          Row(
                            children: const [
                              Icon(Icons.location_on,size: 15,),
                              Text('Drop Up Address',style: TextStyle(fontSize: 12),),
                            ],
                          ),
                          const SizedBox(height: 8,),
                           Text("${bookingDetailsController.bookingDetailsModel.first.destinationLocation.toString()}",style: TextStyle(fontSize: 12),)


                        ],
                      ),

                    ],
                  ),
                ),
                const Divider(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("mini Car",style: TextStyle(fontSize: 18,color: Scolor),),
                    const Text("celerio wagnor R ritx",style: TextStyle(fontSize: 12,),),
                  ],
                ),
                const Divider(),
                Text("Ordered Details",style: TextStyle(fontSize: 18,color: Scolor),),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:  [
                    Text("Trip Distance"),
                    Text("${bookingDetailsController.bookingDetailsModel.first.distance.toString()}")
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:  [
                    Text("Driven Amount"),
                    Text("${bookingDetailsController.bookingDetailsModel.first.fareAmount.toString()}")
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: InkWell(
                    child: Container(
                      height: 40,
                      width: 180,
                      decoration: BoxDecoration(
                          color: Scolor,
                          borderRadius: BorderRadius.circular(10)


                      ),
                      child:  const Center(child: Text("Get Ride",style: TextStyle(color: Colors.white),)),

                    ),
                  ),
                )


              ],

            ),
          )
              :Padding(
                padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height/2.5,bottom:MediaQuery.of(context).size.height/2.5,left: MediaQuery.of(context).size.width/2.5,right: MediaQuery.of(context).size.width/2.5 ),
                child: SizedBox(
                    height: 60,
                    width: 60,
                    child: Image.asset(
                      "images/spin.gif",
                    )),
              );
        }),
      ),
    );
  }
}
