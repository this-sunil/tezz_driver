import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_widget/google_maps_widget.dart';
import 'package:provider/provider.dart';
import 'package:tezz_driver_app/Pages/service/CurrentLocation.dart';
class TrackLocation extends StatefulWidget {
  const TrackLocation({Key? key}) : super(key: key);

  @override
  State<TrackLocation> createState() => _TrackLocationState();
}

class _TrackLocationState extends State<TrackLocation> {
  //late Position position;
  Completer<GoogleMapController> completer=Completer();
  Future<Position> fetchCurrentPosition(BuildContext context) async{
    var _data;
    final currentPosition=Provider.of<CurrentLocation>(context).determinePosition();
    await currentPosition.then((value){
        setState(() {
          _data=value;

          //position=Position(longitude: value.latitude, latitude: value.latitude, timestamp: value.timestamp, accuracy: value.accuracy, altitude: value.altitude, heading: value.heading, speed: value.speed, speedAccuracy: value.speedAccuracy);
        });
      });

    Fluttertoast.showToast(msg: _data.latitude.toString());
    return _data;

  }
  @override
  void initState() {
   setState(() {

     fetchCurrentPosition(context);

   });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: GoogleMapsWidget(
        apiKey: "AIzaSyCFEIrn6AL1cAcPrJQmF5a7pfExyp-7Cvk",
        sourceLatLng: LatLng(18.45352652438326, 73.86508301232917),
        destinationLatLng: const LatLng(18.468952319846682, 73.86393141135605),
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        compassEnabled: true,

        mapToolbarEnabled: false,
        zoomControlsEnabled: false,
        driverName: "Sunil",
        sourceName: "Katraj",
        routeWidth: 2,
        updatePolylinesOnDriverLocUpdate: true,
        destinationName: "Bibwewadi",
      rotateGesturesEnabled: true,
      driverCoordinatesStream: Stream.periodic(
          const Duration(milliseconds: 500),
          (i) => LatLng(18.45352652438326+i/1000, 73.86508301232917-i/1000),

    ),
        onMapCreated: (GoogleMapController controller) async{

          //Fluttertoast.showToast(msg: position.latitude.toString());
          completer.complete(controller);

          GoogleMapController controllers=await completer.future;
         // mapController=await completer.future;

        },
      ),
    );
  }
}
