import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
class HistoryDetails extends StatefulWidget {
  final String? origin;
  final String rideType;
  final String? destination;
  final String? startDate;
  final String? endDate;
  final String? totalAmount;
  final String? bidAmount;
  final String? pickUp;
  final String? destinationAddress;
  final String? mobile;
  final String? time;
  const HistoryDetails({Key? key,required this.rideType,this.origin,this.destination, this.startDate,this.endDate,this.totalAmount,this.bidAmount,this.pickUp,this.destinationAddress,this.mobile,this.time}) : super(key: key);

  @override
  State<HistoryDetails> createState() => _HistoryDetailsState();
}

class _HistoryDetailsState extends State<HistoryDetails> {
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
          Card(
            margin: EdgeInsets.zero,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Trip Type: "+capitalize("${widget.rideType}"),style: TextStyle(fontSize: 20)),
                      Text("\u{20B9} ${widget.totalAmount}",style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      Icon(Icons.location_on_outlined),
                      Text("From"),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text("${widget.origin}"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Transform.rotate(
                          angle:1,
                          child: Icon(Icons.navigation_outlined)),
                      Text("To"),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text("${widget.destination}"),
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text("Bidding Amount"),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.currency_rupee,size: 15),
                      Text("${widget.bidAmount}"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text("Mobile No: "),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text("${widget.mobile}"),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Icon(Icons.time_to_leave_outlined),
                      Text("${widget.time}"),
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [

                      Text(" PickUp Address"),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.location_on_outlined,color: Colors.deepOrange),
                      Text("${widget.pickUp}"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [

                      Text(" Destination Address"),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.location_on_outlined,color: Colors.green),
                      Text("${widget.destinationAddress}"),
                    ],
                  ),
                ),
                Divider(),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [

                      Text(" Start Date"),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today_sharp,color: Colors.deepOrange),
                      Text(" ${widget.startDate}"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [

                      Text(" End Date"),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today_sharp,color: Colors.deepOrange),
                      Text(" ${widget.endDate}"),
                    ],
                  ),
                ),


              ],
            ),
          ),


          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async{
        await FlutterPhoneDirectCaller.callNumber("${widget.mobile}");

      }, child: const Icon(Icons.call)),
    );
  }
}
