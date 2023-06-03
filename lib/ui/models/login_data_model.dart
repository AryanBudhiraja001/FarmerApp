// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.message,
    this.token,
    this.tokenType,
    this.userId,
    this.userInfo,
  });

  String? message;
  String? token;
  String? tokenType;
  int? userId;
  UserInfo? userInfo;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    message: json["message"],
    token: json["token"],
    tokenType: json["token_type"],
    userId: json["user_id"],
    userInfo: UserInfo.fromJson(json["userInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "token": token,
    "token_type": tokenType,
    "user_id": userId,
    "userInfo": userInfo!.toJson(),
  };
}

class UserInfo {
  UserInfo({
    this.id,
    this.userId,
    this.language,
    this.applicantTypeId,
    this.name,
    this.mobileNumber,
    this.fatherHusbandName,
    this.gender,
    this.resident,
    this.aadharNumber,
    this.panNumber,
    this.casteCategoryId,
    this.state,
    this.districtId,
    this.tehsilId,
    this.cityId,
    this.farmerUniqueId,
    this.fullAddress,
    this.pinCode,
    this.avatar,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  String? language;
  int? applicantTypeId;
  String? name;
  String? mobileNumber;
  String? fatherHusbandName;
  String? gender;
  String? resident;
  String? aadharNumber;
  String? panNumber;
  int? casteCategoryId;
  String? state;
  int? districtId;
  int? tehsilId;
  int? cityId;
  String? farmerUniqueId;
  String? fullAddress;
  String? pinCode;
  String? avatar;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    id: json["id"],
    userId: json["user_id"],
    language: json["language"],
    applicantTypeId: json["applicant_type_id"],
    name: json["name"],
    mobileNumber: json["mobile_number"],
    fatherHusbandName: json["father_husband_name"],
    gender: json["gender"],
    resident: json["resident"],
    aadharNumber: json["aadhar_number"],
    panNumber: json["pan_number"],
    casteCategoryId: json["caste_category_id"],
    state: json["state"],
    districtId: json["district_id"],
    tehsilId: json["tehsil_id"],
    cityId: json["city_id"],
    farmerUniqueId: json["farmer_unique_id"],
    fullAddress: json["full_address"],
    pinCode: json["pin_code"],
    avatar: json["avatar"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "language": language,
    "applicant_type_id": applicantTypeId,
    "name": name,
    "mobile_number": mobileNumber,
    "father_husband_name": fatherHusbandName,
    "gender": gender,
    "resident": resident,
    "aadhar_number": aadharNumber,
    "pan_number": panNumber,
    "caste_category_id": casteCategoryId,
    "state": state,
    "district_id": districtId,
    "tehsil_id": tehsilId,
    "city_id": cityId,
    "farmer_unique_id": farmerUniqueId,
    "full_address": fullAddress,
    "pin_code": pinCode,
    "avatar": avatar,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
