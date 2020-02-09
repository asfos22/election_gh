// To parse this JSON data, do
//
//     final registrationModel = registrationModelFromJson(jsonString);

import 'dart:convert';

class RegistrationModel {
  final bool success;
  final Data data;
  final String message;

  RegistrationModel({
    this.success,
    this.data,
    this.message,
  });

  factory RegistrationModel.fromRawJson(String str) => RegistrationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegistrationModel.fromJson(Map<String, dynamic> json) => RegistrationModel(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : data.toJson(),
    "message": message == null ? null : message,
  };
}

class Data {
  final String token;
  final String votersId;

  Data({
    this.token,
    this.votersId,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["token"] == null ? null : json["token"],
    votersId: json["voters_id"] == null ? null : json["voters_id"],
  );

  Map<String, dynamic> toJson() => {
    "token": token == null ? null : token,
    "voters_id": votersId == null ? null : votersId,
  };
}
