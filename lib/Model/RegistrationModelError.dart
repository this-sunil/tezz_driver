// To parse this JSON data, do
//
//     final registrationModelErrror = registrationModelErrrorFromJson(jsonString);

import 'dart:convert';

RegistrationModelErrror registrationModelErrrorFromJson(String str) => RegistrationModelErrror.fromJson(json.decode(str));

String registrationModelErrrorToJson(RegistrationModelErrror data) => json.encode(data.toJson());

class RegistrationModelErrror {
  RegistrationModelErrror({
    required this.message,
    required this.errors,
  });

  String message;
  Errors errors;

  factory RegistrationModelErrror.fromJson(Map<String, dynamic> json) => RegistrationModelErrror(
    message: json["message"],
    errors: Errors.fromJson(json["errors"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "errors": errors.toJson(),
  };
}

class Errors {
  Errors(
    this.email,
    this.mobile,
  );

  List<String> email;
  List<String> mobile;

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
    json["email"],
    json["mobile"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "mobile": mobile,
  };
}
