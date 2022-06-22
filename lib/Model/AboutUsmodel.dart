// To parse this JSON data, do
//
//     final aboutUsModel = aboutUsModelFromJson(jsonString);

import 'dart:convert';

AboutUsModel aboutUsModelFromJson(String str) => AboutUsModel.fromJson(json.decode(str));

String aboutUsModelToJson(AboutUsModel data) => json.encode(data.toJson());

class AboutUsModel {
  AboutUsModel({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.image,
  });

  String title;
  String subtitle;
  String description;
  String image;

  factory AboutUsModel.fromJson(Map<String, dynamic> json) => AboutUsModel(
    title: json["title"],
    subtitle: json["subtitle"],
    description: json["description"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "subtitle": subtitle,
    "description": description,
    "image": image,
  };
}
