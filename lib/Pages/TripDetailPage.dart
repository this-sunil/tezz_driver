import 'dart:async';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tezz_driver_app/BaseUrl.dart';
import 'package:tezz_driver_app/Controller/BookingDetailsController.dart';
import 'package:tezz_driver_app/Pages/service/CurrentLocation.dart';
import 'package:tezz_driver_app/constant.dart';
class TripDetailPage extends StatefulWidget {
  final String token;
  final String origin;
  final String destination;

  final int? id;


   TripDetailPage( {Key? key,this.id,required this.token,required this.origin,required this.destination}) : super(key: key);

  @override
  State<TripDetailPage> createState() => _TripDetailPageState();
}



class _TripDetailPageState extends State<TripDetailPage> {
  BookingDetailsController bookingDetailsController=Get.put(BookingDetailsController());
  //var dayApi=DateFormat('d').format(DateTime.parse(bookingDetailsController.bookingDetailsModel.first.strtDate.toString()));
  final Set<Polyline> polyline={};

  Completer<GoogleMapController> completer=Completer();
  CameraPosition? _kGooglePlex;
TextEditingController amount=TextEditingController();
   String currentAddress="";
   Set<Marker> marker={};
   GoogleMapController? mapController;
   late List<LatLng> routeCords;

   GoogleMapPolyline googleMapPolyline=GoogleMapPolyline(apiKey: "AIzaSyCFEIrn6AL1cAcPrJQmF5a7pfExyp-7Cvk");
  fetchBidAmount(int id,String token,String amount) async{
    final resp=await http.post(Uri.parse("${baseUrl}api/biddingApi"),
    body: {
      "booking_id":"$id",
      "bidding_amount":amount,
    },
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },

    );
    Map<String,dynamic> result=jsonDecode(resp.body);
    if(resp.statusCode==200){
      Fluttertoast.showToast(msg:result["message"]);
      Navigator.pop(context);
    }
    else{
      print("Bidding err:${resp.statusCode}");
      Fluttertoast.showToast(msg:result["message"]);
      Navigator.pop(context);
    }
  }
   showMessage(int id,String token) async{


     showDialog(
         context: context,
         builder: (BuildContext context) {
           return Dialog(
             shape: RoundedRectangleBorder(
                 borderRadius:
                 BorderRadius.circular(10.0)), //this right here
             child: SizedBox(
               height: 200,
               child: Padding(
                 padding: const EdgeInsets.all(12.0),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [

                     Padding(
                       padding: const EdgeInsets.all(10.0),
                       child: TextFormField(
                         controller: amount,
                         decoration: InputDecoration(

                             hintText: 'Enter your Amount'),
                       ),
                     ),
                     SizedBox(
                       width: 320.0,
                       height: 50,
                       child: ElevatedButton(
                         style: ButtonStyle(
                           shape: MaterialStateProperty.all(StadiumBorder())
                         ),
                         onPressed: () {
                           fetchBidAmount(id,token,amount.text);
                         },
                         child: Text(
                           "Save",
                           style: TextStyle(color: Colors.white),
                         ),

                       ),
                     )
                   ],
                 ),
               ),
             ),
           );
         });
   }
   Future<void> getAddressFromLatLng(LatLng origin,LatLng destination) async {
    await placemarkFromCoordinates(
        origin.latitude, origin.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        currentAddress =
        '${place.name}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';


        marker.add(Marker(
            position: LatLng(origin.latitude,origin.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
            markerId: const MarkerId("1"),infoWindow: InfoWindow(title: "${widget.origin}")));

      });

    }).catchError((e) {
      debugPrint(e);
    });
    await placemarkFromCoordinates(
        destination.latitude, destination.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[1];
      setState(() {
        currentAddress =
        '${place.name}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';


        marker.add(Marker(
            position: LatLng(destination.latitude,destination.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
            markerId: const MarkerId("2"),infoWindow: InfoWindow(title: "${widget.destination}")));
      });

    }).catchError((e) {
      debugPrint(e);
    });
  }
  getPolylinePoints(String origin,String destination) async{
    routeCords=(await googleMapPolyline.getPolylineCoordinatesWithAddress(
        origin: origin,
        destination: destination,
        mode: RouteMode.driving))!;

  setState(() {
    polyline.add(Polyline(polylineId: const PolylineId("route1"),
      points: routeCords,
      width: 2,
      color: Colors.pink,
      startCap: Cap.buttCap,
      endCap: Cap.buttCap,

    ));
  });
  }
   fetchLocation(BuildContext context) async{
    var origin = await locationFromAddress("${widget.origin}");
    var destination=await locationFromAddress("${widget.destination}");
    Position position=await Provider.of<CurrentLocation>(context, listen: false).determinePosition();
    _kGooglePlex = CameraPosition(
     target: LatLng(position.latitude, position.longitude),
     zoom: 2,
     );
    //Fluttertoast.showToast(msg:origin.first.latitude.toString());

      getAddressFromLatLng(LatLng(origin.first.latitude, origin.first.longitude),LatLng(destination.first.latitude, destination.first.longitude));
      getPolylinePoints("${widget.origin}", "${widget.destination}");
      print("Origin ${widget.origin}");
      print("Destination ${widget.destination}");

  }


  @override
  void initState() {
    print(widget.id);
   setState(() {
     fetchLocation(context);

     bookingDetailsController.bookingDetailsGet(widget.id!.toInt(),widget.token);

   });
    //Marker(markerId: MarkerId("1"),infoWindow: );
   // var day=DateTime.tryParse(bookingDetailsController.bookingDetailsModel.first.strtDate.toString())!.weekday;
    //print(day);

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
    final counter=Provider.of<CurrentLocation>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Trip Details"),
        backgroundColor: Scolor,
      ),

      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:_kGooglePlex??CameraPosition(target: LatLng(22.72137365094841, 80.15975593680007)),
            mapType: MapType.normal,
            compassEnabled: true,
            onCameraMoveStarted: (){

            },
            onCameraIdle: (){},
            trafficEnabled: true,
            zoomControlsEnabled: false,

            onTap: (LatLng latLng) async {
              /* await placemarkFromCoordinates(latLng.latitude, latLng.longitude)
        .then((List<Placemark> placemarks) {
               Placemark place = placemarks[1];
               setState(() {

                 marker.add(Marker(
                     markerId: MarkerId("4"),
                     infoWindow: InfoWindow(
                       title: "${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}"
                     ),
                     position: LatLng(latLng.latitude,latLng.longitude)));
               });
             });*/


            },
            markers: Set.of(marker),
            mapToolbarEnabled: false,

            polylines: polyline,

            onMapCreated: (GoogleMapController controller) async{
              completer.complete(controller);

              GoogleMapController controllers=await completer.future;
              mapController=await completer.future;
              Position position=await counter.determinePosition();
             setState(() {

               print("latt"+position.latitude.toString());
               print("long:${position.longitude}");

               if(position.latitude!=null && position.longitude!=null) {



                   controllers.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(

                     target:LatLng(position.latitude,position.longitude),
                     zoom: 12,

                   )));


               }


             });

            },
            onCameraMove: (CameraPosition position){
             /* mapController?.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target:position.target,
                    zoom: 18.0,
                  ),
                ),
              );*/
            },
          ),

          Positioned(
            right: 0,
              top: 0,
              child: Column(
                children: [
                  Card(
                    color:Colors.pink,
                    shape: const StadiumBorder(),
                    child: IconButton(
                      icon: const Icon(Icons.add_circle,color: Colors.white),
                      onPressed: (){
                        setState(() {
                          mapController?.animateCamera(CameraUpdate.zoomIn());
                        });
                      },
                    ),
                  ),
                  Card(
                    color:Colors.pink,
                    shape: StadiumBorder(),
                    child: IconButton(
                      icon: const Icon(Icons.remove_circle,color: Colors.white),
                      onPressed: (){
                        setState(() {
                          mapController?.animateCamera(CameraUpdate.zoomOut());
                        });
                      },
                    ),
                  ),
                ],
              )),
          Positioned(
            bottom: 0,
            child: SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    )
                ),
                margin: EdgeInsets.zero,
                child: Obx(() {
                  return bookingDetailsController.bookingDetailsModel.isNotEmpty
                      ?
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15, left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Trip Type : ${bookingDetailsController
                                    .bookingDetailsModel.first.rideType}",
                                style: TextStyle(fontSize: 20),),
                            ),
                            Text("\u{20B9} ${bookingDetailsController
                                .bookingDetailsModel.first.fareAmount}",
                                style: TextStyle(
                                  fontSize: 20,
                                )),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            Icon(Icons.location_on_outlined, color: Colors.red),
                            Text("${bookingDetailsController.bookingDetailsModel
                                .first.from}"),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Row(
                            children: [
                              Container(
                                child: Text("|"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined, color: Colors.green,),
                            Text("${bookingDetailsController.bookingDetailsModel
                                .first.destination}"),
                          ],
                        ),
                      ),

                      Row(

                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Text("Distance:${bookingDetailsController
                                .bookingDetailsModel.first.distance}"),
                          ),


                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Text("Start Date: ${bookingDetailsController
                                .bookingDetailsModel.first.strtDate}"),
                          ),
                        ],),

                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Text("End Date: ${bookingDetailsController
                                .bookingDetailsModel.first.endDate}"),
                          ),
                        ],),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Row(
                          children: [
                            Text("Time: ${bookingDetailsController
                                .bookingDetailsModel.first.time}"),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text("Mobile No:${bookingDetailsController
                                    .bookingDetailsModel.first.mobile}"),
                              ],
                            ),

                          ],
                        ),
                      ),
                      const SizedBox(height: 70),




                    ],
                  )
                      : Container(
                    height: 200,
                    child: Card(
                      child: Center(child: Text("No Data Found")),
                    ),
                  );
                }),
              ),
            ),
          )
        ],
      ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    floatingActionButton:FloatingActionButton.extended(
      extendedPadding: const EdgeInsets.symmetric(horizontal: 80),
      label: const Text("Bid Now"),
      onPressed: (){
        setState(() {
          showMessage(widget.id!.toInt(),widget.token);
        });
      },
    ),
    );
  }
}

