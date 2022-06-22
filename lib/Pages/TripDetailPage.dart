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

  final int id;


   const TripDetailPage( {Key? key,required this.id,required this.token,required this.origin,required this.destination}) : super(key: key);

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
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
   fetchLocation(BuildContext context) async{

    var origin = await locationFromAddress("${widget.origin}");
    var destination=await locationFromAddress("${widget.destination}");
    Position position=await Provider.of<CurrentLocation>(context, listen: false).determinePosition();
    _kGooglePlex = CameraPosition(
     target: LatLng(position.latitude, position.longitude),
     zoom: 14,
      tilt: position.accuracy,
      bearing: position.speedAccuracy,
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
     //bookingDetailsController.bookingDetailsModel.clear();
     bookingDetailsController.bookingDetailsGet(widget.id,widget.token);

   });
    super.initState();
  }
  @override
  void dispose() {
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

      body:Obx((){
        return bookingDetailsController.bookingDetailsModel.isNotEmpty?Stack(
          children: [
            GoogleMap(
              initialCameraPosition:_kGooglePlex??const CameraPosition(target: LatLng(22.791029358845552, 79.35531622170936)),
              mapType: MapType.normal,
              compassEnabled: true,
              myLocationEnabled: true,
              onCameraMoveStarted: (){

              },
              onCameraIdle: (){},
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
                controller.setMapStyle('[{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#969696"},{"saturation":36},{"lightness":40}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#000000"},{"lightness":16},{"visibility":"on"}]},{"featureType":"administrative","elementType":"geometry.fill","stylers":[{"color":"#000000"},{"lightness":20}]},{"featureType":"administrative","elementType":"geometry.stroke","stylers":[{"color":"#000000"},{"lightness":17},{"weight":1.2}]},{"featureType":"administrative.country","elementType":"geometry.stroke","stylers":[{"color":"#606060"}]},{"featureType":"administrative.locality","elementType":"labels.icon","stylers":[{"color":"#9e9e9e"},{"visibility":"simplified"}]},{"featureType":"administrative.locality","elementType":"labels.text.fill","stylers":[{"color":"#8d8d8d"}]},{"featureType":"administrative.province","elementType":"geometry.stroke","stylers":[{"color":"#525252"}]},{"featureType":"landscape","stylers":[{"visibility":"on"}]},{"featureType":"landscape","elementType":"geometry","stylers":[{"color":"#000000"},{"lightness":20}]},{"featureType":"landscape","elementType":"geometry.stroke","stylers":[{"color":"#636363"}]},{"featureType":"landscape","elementType":"labels.icon","stylers":[{"saturation":"-100"},{"lightness":"-54"}]},{"featureType":"poi","stylers":[{"saturation":"-100"},{"lightness":"0"}]},{"featureType":"poi","elementType":"geometry","stylers":[{"color":"#101010"},{"lightness":21}]},{"featureType":"poi","elementType":"labels.icon","stylers":[{"saturation":"-89"},{"lightness":"-55"}]},{"featureType":"poi","elementType":"labels.text","stylers":[{"visibility":"off"}]},{"featureType":"poi.business","stylers":[{"visibility":"off"}]},{"featureType":"road","elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#000000"},{"lightness":18}]},{"featureType":"road.arterial","elementType":"geometry.stroke","stylers":[{"color":"#453838"},{"visibility":"off"}]},{"featureType":"road.highway","elementType":"geometry.fill","stylers":[{"color":"#303030"},{"saturation":"-100"},{"lightness":17}]},{"featureType":"road.highway","elementType":"geometry.stroke","stylers":[{"color":"#000000"},{"lightness":29},{"weight":0.2}]},{"featureType":"road.local","elementType":"geometry","stylers":[{"color":"#000000"},{"lightness":16}]},{"featureType":"road.local","elementType":"geometry.stroke","stylers":[{"visibility":"off"}]},{"featureType":"transit","stylers":[{"visibility":"off"}]},{"featureType":"transit","elementType":"geometry","stylers":[{"color":"#000000"},{"lightness":19}]},{"featureType":"transit.station","elementType":"labels.icon","stylers":[{"saturation":"-100"},{"lightness":"-51"},{"visibility":"on"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#000000"},{"lightness":17}]}]');
                Position position=await counter.determinePosition();
                //Fluttertoast.showToast(msg: position.latitude.toString());
                completer.complete(controller);

                GoogleMapController controllers=await completer.future;
                mapController=await completer.future;

                var origin = await locationFromAddress("${widget.origin}");
                setState(() {


                  print("latt"+position.latitude.toString());
                  print("long:${position.longitude}");

                  controllers.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(

                    target:LatLng(origin.first.latitude,origin.first.longitude),
                    zoom: 15,

                  )));



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
                right: 5,
                top: 60,
                child: Column(
                  children: [
                    Card(
                      color:const Color(0xFF8347b8),
                      shape: const StadiumBorder(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(

                            icon: const Icon(Icons.add_circle,color: Colors.white),
                            onPressed: (){
                              setState(() {
                                mapController?.animateCamera(CameraUpdate.zoomIn());
                              });
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.remove_circle,color: Colors.white),
                            onPressed: (){
                              setState(() {
                                mapController?.animateCamera(CameraUpdate.zoomOut());
                              });
                            },
                          ),
                        ],
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
                child:
                Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                    ),
                    margin: EdgeInsets.zero,
                    child:
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
                                  "Trip Type :"+capitalize("${bookingDetailsController
                                      .bookingDetailsModel.first.rideType}"),
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
                              const Icon(Icons.location_on_outlined, color: Colors.red),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Distance: ${bookingDetailsController.bookingDetailsModel.first.distance} Km"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Pick Up: ${bookingDetailsController.bookingDetailsModel.first.pickUpLocation}"),
                                  ),
                                  SizedBox(height: 4),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Destination: ${bookingDetailsController.bookingDetailsModel.first.destinationLocation}"),
                                  ),
                                  SizedBox(height: 4),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Mobile no: ${bookingDetailsController.bookingDetailsModel.first.mobile}"),
                                  )

                                ],
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
                                            "${bookingDetailsController.bookingDetailsModel.first.strtDate}",
                                            style: const TextStyle(
                                                fontSize: 12)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(4.0),
                                        child: Text("${bookingDetailsController.bookingDetailsModel.first.startDay}",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          "${bookingDetailsController.bookingDetailsModel.first.time}",
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
                          padding: const EdgeInsets.all(8.0),
                          child: FloatingActionButton.extended(
                            extendedPadding: const EdgeInsets.symmetric(horizontal: 80),
                            label: const Text("Bid Now"),
                            onPressed: (){
                              setState(() {
                                showMessage(widget.id,widget.token);
                              });
                            },
                          ),
                        ),
                      ],
                    )



                ),
              ),
            ),
          ],
        ):const Center(
          child:CircularProgressIndicator(),
        );
      }),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,


    );
  }
}

