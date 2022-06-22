// To parse this JSON data, do
//
//     final vehicleDataModel = vehicleDataModelFromJson(jsonString);

import 'dart:convert';

VehicleDataModel vehicleDataModelFromJson(String str) => VehicleDataModel.fromJson(json.decode(str));

String vehicleDataModelToJson(VehicleDataModel data) => json.encode(data.toJson());

class VehicleDataModel {
  VehicleDataModel({
    required this.data,
  });

  List<Datum> data;

  factory VehicleDataModel.fromJson(Map<String, dynamic> json) => VehicleDataModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.vehicleModelId,
    required this.vehicleModelName,
  });

  int vehicleModelId;
  String vehicleModelName;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    vehicleModelId: json["VehicleModelId"],
    vehicleModelName: json["VehicleModelName"],
  );

  Map<String, dynamic> toJson() => {
    "VehicleModelId": vehicleModelId,
    "VehicleModelName": vehicleModelName,
  };
}
