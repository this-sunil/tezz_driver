// To parse this JSON data, do
//
//     final assignOrderModel = assignOrderModelFromJson(jsonString);

import 'dart:convert';

List<AssignOrderModel> assignOrderModelFromJson(String str) => List<AssignOrderModel>.from(json.decode(str).map((x) => AssignOrderModel.fromJson(x)));

String assignOrderModelToJson(List<AssignOrderModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AssignOrderModel {
  AssignOrderModel({
    required this.id,
    required this.userId,
    required this.razorpayPaymentId,
    this.name,
    required this.mobile,
    required this.email,
    this.vehicleName,
    required this.vehicleId,
    required this.distance,
    this.driverAllowance,
    required this.time,
    required this.rideType,
    required this.from,
    required this.destination,
    required this.startDate,
    required this.endDate,
    required this.totalAmount,
    required this.paidAmount,
    required this.remainingAmount,
    this.netAmountDebit,
    this.paymentStatus,
    this.paymentType,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.acceptedBy,
    required this.pickupAddress,
    required this.destinationAddress,
    this.cancelledTimestamp,
  });

  int id;
  int userId;
  String razorpayPaymentId;
  dynamic name;
  String mobile;
  String email;
  dynamic vehicleName;
  int vehicleId;
  double distance;
  dynamic driverAllowance;
  String time;
  String rideType;
  String from;
  String destination;
  String startDate;
  String endDate;
  int totalAmount;
  int paidAmount;
  int remainingAmount;
  dynamic netAmountDebit;
  dynamic paymentStatus;
  dynamic paymentType;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  int acceptedBy;
  String pickupAddress;
  String destinationAddress;
  dynamic cancelledTimestamp;

  factory AssignOrderModel.fromJson(Map<String, dynamic> json) => AssignOrderModel(
    id: json["id"],
    userId: json["user_id"],
    razorpayPaymentId: json["razorpay_payment_id"],
    name: json["name"],
    mobile: json["mobile"],
    email: json["email"],
    vehicleName: json["vehicle_name"],
    vehicleId: json["vehicle_id"],
    distance: json["distance"].toDouble(),
    driverAllowance: json["driver_allowance"],
    time: json["time"],
    rideType: json["ride_type"],
    from: json["from"],
    destination: json["destination"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    totalAmount: json["total_amount"],
    paidAmount: json["paid_amount"],
    remainingAmount: json["remaining_amount"],
    netAmountDebit: json["net_amount_debit"],
    paymentStatus: json["payment_status"],
    paymentType: json["payment_type"],
    status: json["status"] ?? "",
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    acceptedBy: json["accepted_by"],
    pickupAddress: json["pickup_address"],
    destinationAddress: json["destination_address"],
    cancelledTimestamp: json["cancelled_timestamp"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "razorpay_payment_id": razorpayPaymentId,
    "name": name,
    "mobile": mobile,
    "email": email,
    "vehicle_name": vehicleName,
    "vehicle_id": vehicleId,
    "distance": distance,
    "driver_allowance": driverAllowance,
    "time": time,
    "ride_type": rideType,
    "from": from,
    "destination": destination,
    "start_date": startDate,
    "end_date": endDate,
    "total_amount": totalAmount,
    "paid_amount": paidAmount,
    "remaining_amount": remainingAmount,
    "net_amount_debit": netAmountDebit,
    "payment_status": paymentStatus,
    "payment_type": paymentType,
    "status": status == "null" ? "" : status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "accepted_by": acceptedBy,
    "pickup_address": pickupAddress,
    "destination_address": destinationAddress,
    "cancelled_timestamp": cancelledTimestamp,
  };
}
