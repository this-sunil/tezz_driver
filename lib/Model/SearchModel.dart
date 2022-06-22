// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

SearchModel searchModelFromJson(String str) => SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  SearchModel({
    required this.data,
  });

  List<Datum> data;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.id,
    required this.distance,
    required this.time,
    required this.rideType,
    required this.from,
    required this.destination,
    required this.startDate,
    required this.endDate,
    required this.totalAmount,
    required this.pickupAddress,
    required this.destinationAddress,
  });

  int id;
  double distance;
  String time;
  String rideType;
  String from;
  String destination;
  String startDate;
  String endDate;
  int totalAmount;
  String pickupAddress;
  String destinationAddress;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    distance: json["distance"].toDouble(),
    time: json["time"] == null ? "null" : json["time"],
    rideType: json["ride_type"],
    from:json["from"],
    destination: json["destination"],
    startDate: json["start_date"],
    endDate: json["end_date"] == null ? "null" : json["end_date"],
    totalAmount: json["total_amount"],
    pickupAddress: json["pickup_address"] == null ? "null" : json["pickup_address"],
    destinationAddress: json["destination_address"] == null ? "null" : json["destination_address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "distance": distance,
    "time": time == null ? "null" : time,
    "ride_type":rideType,
    "from": from,
    "destination": destination,
    "start_date": startDate,
    "end_date": endDate,
    "total_amount": totalAmount,
    "pickup_address": pickupAddress == null ? "null" : pickupAddress,
    "destination_address": destinationAddress == null ? "null" : destinationAddress,
  };
}





