// To parse this JSON data, do
//
//     final boookingModelDemo = boookingModelDemoFromJson(jsonString);

import 'dart:convert';

BoookingModelDemo boookingModelDemoFromJson(String str) =>
    BoookingModelDemo.fromJson(json.decode(str));

String boookingModelDemoToJson(BoookingModelDemo data) =>
    json.encode(data.toJson());

class BoookingModelDemo {
  BoookingModelDemo({
    required this.data,
  });

  List<Datum> data;

  factory BoookingModelDemo.fromJson(Map<String, dynamic> json) =>
      BoookingModelDemo(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    this.distance,
    this.time,
    this.rideType,
    this.from,
    this.destination,
    this.startDate,
    this.endDate,
    this.totalAmount,
    this.pickupAddress,
    this.destinationAddress,
  });

  int id;
  double? distance;
  String? time;
  String? rideType;
  String? from;
  String? destination;
  String? startDate;
  String? endDate;
  int? totalAmount;
  String? pickupAddress;
  String? destinationAddress;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        distance: json["distance"].toDouble(),
        time: json["time"],
        rideType: json["ride_type"],
        from: json["from"],
        destination: json["destination"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        totalAmount: json["total_amount"],
        pickupAddress: json["pickup_address"],
        destinationAddress: json["destination_address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "distance": distance,
        "time": time,
        "ride_type": rideType,
        "from": from,
        "destination": destination,
        "start_date": startDate,
        "end_date": endDate,
        "total_amount": totalAmount,
        "pickup_address": pickupAddress,
        "destination_address": destinationAddress,
      };
}
