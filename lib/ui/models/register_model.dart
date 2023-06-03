// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  RegisterModel({
    this.message,
    this.token,
    this.tokenType,
    this.userId,
  });

  String? message;
  String? token;
  String? tokenType;
  int? userId;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    message: json["message"],
    token: json["token"],
    tokenType: json["token_type"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "token": token,
    "token_type": tokenType,
    "user_id": userId,
  };
}
