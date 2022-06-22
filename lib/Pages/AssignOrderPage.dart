import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tezz_driver_app/Controller/AssignOrderController.dart';
import 'package:tezz_driver_app/Pages/TripDetailPage.dart';
class AssignOrderPage extends StatefulWidget {
  final String token;
  const AssignOrderPage({Key? key,required this.token}) : super(key: key);

  @override
  _AssignOrderPageState createState() => _AssignOrderPageState();
}

class _AssignOrderPageState extends State<AssignOrderPage> {
  AssignOrderController assignOrderController=Get.put(AssignOrderController());
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  @override
  void initState() {
    assignOrderController.fetchData(widget.token);
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
      body:Obx((){

        if(assignOrderController.assignOrderList.isNotEmpty){
          return ListView.builder(
              itemCount: assignOrderController.assignOrderList.length,
              itemBuilder: (context,index){
                return Card(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Trip Type: "+capitalize("${assignOrderController.assignOrderList[index].rideType}"),style: const TextStyle(fontSize: 20)),
                          Text("\u{20B9} ${assignOrderController.assignOrderList[index].totalAmount}",style: const TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.location_on_outlined,color: Colors.deepOrange),
                          Text(assignOrderController.assignOrderList[index].from),
                        ],
                      ),

                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.location_on_outlined,color: Colors.green),
                          Text("${assignOrderController.assignOrderList[index].destination}"),
                        ],
                      ),

                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Text("Distance: "),
                          Text("${assignOrderController.assignOrderList[index].distance} Km"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text("Start Date: ${assignOrderController.assignOrderList[index].startDate}"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text("End Date: ${assignOrderController.assignOrderList[index].endDate}"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FloatingActionButton.extended(
                              extendedPadding: const EdgeInsets.symmetric(horizontal: 30),
                              heroTag: "${assignOrderController.assignOrderList[index].id}",
                              onPressed: (){
                                setState(() {
                                  Navigator.push(context,MaterialPageRoute(builder: (context)=>TripDetailPage(id: assignOrderController.assignOrderList[index].id, token: widget.token, origin: assignOrderController.assignOrderList[index].from, destination: assignOrderController.assignOrderList[index].destination)));
                                });
                              }, label: const Text("Get Details")),
                          FloatingActionButton.extended(
                            extendedPadding: const EdgeInsets.symmetric(horizontal: 40),
                              heroTag: "$index",
                              onPressed: () async{
                              String number=assignOrderController.assignOrderList[index].mobile;
                              print("number assign order page:$number");
                                await FlutterPhoneDirectCaller.callNumber(number);
                              }, label: const Text("Contact")),
                        ],
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.time_to_leave_outlined),
                              Text(" ${assignOrderController.assignOrderList[index].time}"),
                            ],
                          ),
                          Text("${assignOrderController.assignOrderList[index].status=="completed"?assignOrderController.assignOrderList[index].status:""}",style: TextStyle(color: assignOrderController.assignOrderList[index].status=="completed"?Colors.green:Colors.black))
                        ],
                      ),
                    ),



                  ],
                ));
              });
        }
        return assignOrderController.assignOrderList.isEmpty?const Center(child:CircularProgressIndicator()):Center(child: Lottie.asset("images/no-ride.json"));
      }),
    );
  }
}
