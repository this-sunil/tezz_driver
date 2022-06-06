// To parse this JSON data, do
//
//     final myProfileModel = myProfileModelFromJson(jsonString);

import 'dart:convert';

MyProfileModel myProfileModelFromJson(String str) => MyProfileModel.fromJson(json.decode(str));

String myProfileModelToJson(MyProfileModel data) => json.encode(data.toJson());

class MyProfileModel {
  MyProfileModel({
    required this.data,
  });

  Data data;

  factory MyProfileModel.fromJson(Map<String, dynamic> json) => MyProfileModel(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.name,
    this.email,
    this.mobile,
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
    this.vehicleType,
    this.vehicleModelName,
    this.multipleCities,
    this.adhar,
    this.licence,
    this.pan,
    this.photo,
    this.insurance,
    this.workPermit,
    this.joiningForm,
    this.bankPassbook,
  });

  int? id;
  String? name;
  String? email;
  String? mobile;
  String? gender;
  String? dob;
  String? address;
  String? pinCode;
  String? vehicleName;
  String? vehicleNumber;
  String? bankName;
  String? accountHolderName;
  String? branchName;
  String? accountNumber;
  String? ifsc;
  String? vehicleType;
  String? vehicleModelName;
  List<String>? multipleCities;
  String? adhar;
  String? licence;
  String? pan;
  String? photo;
  String? insurance;
  String? workPermit;
  String? joiningForm;
  String? bankPassbook;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["Id"],
    name: json["Name"],
    email: json["Email"],
    mobile: json["Mobile"],
    gender: json["Gender"],
    dob: json["DOB"],
    address: json["Address"],
    pinCode: json["PinCode"],
    vehicleName: json["VehicleName"],
    vehicleNumber: json["VehicleNumber"],
    bankName: json["BankName"],
    accountHolderName: json["AccountHolderName"],
    branchName: json["BranchName"],
    accountNumber: json["AccountNumber"],
    ifsc: json["IFSC"],
    vehicleType: json["VehicleType"],
    vehicleModelName: json["VehicleModelName"],
    multipleCities: json["MultipleCities"]!=null?List<String>.from(json["MultipleCities"].map((x) => x)):null,
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
    "VehicleType": vehicleType,
    "VehicleModelName": vehicleModelName,
    "MultipleCities": List<dynamic>.from(multipleCities!.map((x) => x)),
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
