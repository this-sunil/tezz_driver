// To parse this JSON data, do
//
//     final bookingDetailsModel = bookingDetailsModelFromJson(jsonString);

import 'dart:convert';

BookingDetailsModel bookingDetailsModelFromJson(String str) => BookingDetailsModel.fromJson(json.decode(str));

String bookingDetailsModelToJson(BookingDetailsModel data) => json.encode(data.toJson());

class BookingDetailsModel {
  BookingDetailsModel({
    this.id,
    this.name,
    this.mobile,
    this.email,
    this.distance,
    this.time,
    this.rideType,
    this.from,
    this.destination,
    this.strtDate,
    this.endDate,
    this.fareAmount,
    this.remainingFareAmount,
    this.pickUpLocation,
    this.destinationLocation,
    this.startDay,
  });

  int? id;
  dynamic? name;
  String? mobile;
  String? email;
  double? distance;
  String? time;
  String? rideType;
  String? from;
  String? destination;
  String? strtDate;
  String? endDate;
  int? fareAmount;
  int? remainingFareAmount;
  String? pickUpLocation;
  String? destinationLocation;
  String? startDay;

  factory BookingDetailsModel.fromJson(Map<String, dynamic> json) => BookingDetailsModel(
    id: json["Id"],
    name: json["Name"],
    mobile: json["Mobile"],
    email: json["Email"],
    distance: json["Distance"].toDouble(),
    time: json["Time"],
    rideType: json["RideType"],
    from: json["From"],
    destination: json["Destination"],
    strtDate: json["StrtDate"],
    endDate: json["EndDate"],
    fareAmount: json["FareAmount"],
    remainingFareAmount: json["RemainingFareAmount"],
    pickUpLocation: json["PickUpLocation"],
    destinationLocation: json["DestinationLocation"],
    startDay: json["StartDay"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Name": name,
    "Mobile": mobile,
    "Email": email,
    "Distance": distance,
    "Time": time,
    "RideType": rideType,
    "From": from,
    "Destination": destination,
    "StrtDate": strtDate,
    "EndDate": endDate,
    "FareAmount": fareAmount,
    "RemainingFareAmount": remainingFareAmount,
    "PickUpLocation": pickUpLocation,
    "DestinationLocation": destinationLocation,
    "StartDay": startDay,
  };
}
