// To parse this JSON data, do
//
//     final updateProfileModel = updateProfileModelFromJson(jsonString);

import 'dart:convert';

UpdateProfileModel updateProfileModelFromJson(String str) => UpdateProfileModel.fromJson(json.decode(str));

String updateProfileModelToJson(UpdateProfileModel data) => json.encode(data.toJson());

class UpdateProfileModel {
  UpdateProfileModel({
    required this.data,
  });

  Data data;

  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) => UpdateProfileModel(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    this.gender,
    this.dob,
    this.address,
    this.pinCode,
    this.vehicleName,
    this.vehicleNumber,
    this.bankName,
    this.accountHolderName,
    this.branchName,
    this.accountNumber,
    this.ifsc,
    this.vehicleTypeName,
    this.vehicleModelName,
    required this.vehicleType,
    required this.vehicleModel,
    required this.multipleCities,
    required this.adhar,
    required this.licence,
    required this.pan,
    required this.photo,
    required this.insurance,
    required this.workPermit,
    required this.joiningForm,
    required this.bankPassbook,
  });

  int id;
  String name;
  String email;
  String mobile;
  dynamic gender;
  dynamic dob;
  dynamic address;
  dynamic pinCode;
  dynamic vehicleName;
  dynamic vehicleNumber;
  dynamic bankName;
  dynamic accountHolderName;
  dynamic branchName;
  dynamic accountNumber;
  dynamic ifsc;
  dynamic vehicleTypeName;
  dynamic vehicleModelName;
  List<VehicleType> vehicleType;
  List<dynamic> vehicleModel;
  String multipleCities;
  String adhar;
  String licence;
  String pan;
  String photo;
  String insurance;
  String workPermit;
  String joiningForm;
  String bankPassbook;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["Id"],
    name: json["Name"],
    email: json["Email"],
    mobile: json["Mobile"],
    gender: json["Gender"],
    dob: json["DOB"]!=null?json["DOB"]:"",
    address: json["Address"],
    pinCode: json["PinCode"],
    vehicleName: json["VehicleName"],
    vehicleNumber: json["VehicleNumber"],
    bankName: json["BankName"],
    accountHolderName: json["AccountHolderName"],
    branchName: json["BranchName"],
    accountNumber: json["AccountNumber"],
    ifsc: json["IFSC"],
    vehicleTypeName: json["vehicleTypeName"],
    vehicleModelName: json["VehicleModelName"],
    vehicleType: json["VehicleType"]!=null?List<VehicleType>.from(json["VehicleType"].map((x) => VehicleType.fromJson(x))):[],
    vehicleModel: json["VehicleModel"]!=null?List<dynamic>.from(json["VehicleModel"].map((x) => x)):[],
    multipleCities: json["MultipleCities"]!=null?json["MultipleCities"]:"",
    adhar: json["Adhar"],
    licence: json["Licence"],
    pan: json["Pan"],
    photo: json["Photo"],
    insurance: json["Insurance"],
    workPermit: json["WorkPermit"],
    joiningForm: json["JoiningForm"],
    bankPassbook: json["BankPassbook"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Name": name,
    "Email": email,
    "Mobile": mobile,
    "Gender": gender,
    "DOB": dob,
    "Address": address,
    "PinCode": pinCode,
    "VehicleName": vehicleName,
    "VehicleNumber": vehicleNumber,
    "BankName": bankName,
    "AccountHolderName": accountHolderName,
    "BranchName": branchName,
    "AccountNumber": accountNumber,
    "IFSC": ifsc,
    "vehicleTypeName": vehicleTypeName,
    "VehicleModelName": vehicleModelName,
    "VehicleType": vehicleType,
    "VehicleModel": vehicleModel,
    "MultipleCities": multipleCities,
    "Adhar": adhar,
    "Licence": licence,
    "Pan": pan,
    "Photo": photo,
    "Insurance": insurance,
    "WorkPermit": workPermit,
    "JoiningForm": joiningForm,
    "BankPassbook": bankPassbook,
  };
}

class VehicleType {
  VehicleType({
    required this.vehicleTypeId,
    required this.vehicleTypeName,
  });

  int vehicleTypeId;
  String vehicleTypeName;

  factory VehicleType.fromJson(Map<String, dynamic> json) => VehicleType(
    vehicleTypeId: json["VehicleTypeId"],
    vehicleTypeName: json["VehicleTypeName"],
  );

  Map<String, dynamic> toJson() => {
    "VehicleTypeId": vehicleTypeId,
    "VehicleTypeName": vehicleTypeName,
  };
}
