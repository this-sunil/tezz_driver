// To parse this JSON data, do
//
//     final walletBalence = walletBalenceFromJson(jsonString);

import 'dart:convert';

WalletBalance walletBalenceFromJson(String str) => WalletBalance.fromJson(json.decode(str));

String walletBalenceToJson(WalletBalance data) => json.encode(data.toJson());

class WalletBalance {
  WalletBalance({
    this.walletId,
    this.balanceAmount,
    this.dateInString,
  });

  int? walletId;
  String? balanceAmount;
  String? dateInString;

  factory WalletBalance.fromJson(Map<String, dynamic> json) => WalletBalance(
    walletId: json["WalletID"],
    balanceAmount: json["BalanceAmount"],
    dateInString: json["DateInString"],
  );

  Map<String, dynamic> toJson() => {
    "WalletID": walletId,
    "BalanceAmount": balanceAmount,
    "DateInString": dateInString,
  };
}
