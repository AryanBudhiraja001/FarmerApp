class FetchLandDetailsModel {
  String? message;
  String? mediaUrl;
  List<LandData>? data;

  FetchLandDetailsModel({this.message, this.mediaUrl, this.data});

  FetchLandDetailsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    mediaUrl = json['media_url'];
    if (json['data'] != null) {
      data = <LandData>[];
      json['data'].forEach((v) {
        data!.add(LandData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['media_url'] = this.mediaUrl;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LandData {
  int? id;
  int? farmerId;
  String? totalLandArea;
  String? state;
  int? districtId;
  int? tehsilId;
  int? cityId;
  String? pinCode;
  String? landAddress;
  String? areaInformation;
  String? uploadFard;
  String? pattedarNo;
  String? uploadPattedar;
  String? khewatNo;
  String? khatauniNo;
  String? khasraNo;
  String? createdAt;
  String? updatedAt;

  LandData(
      {this.id,
        this.farmerId,
        this.totalLandArea,
        this.state,
        this.districtId,
        this.tehsilId,
        this.cityId,
        this.pinCode,
        this.landAddress,
        this.areaInformation,
        this.uploadFard,
        this.pattedarNo,
        this.uploadPattedar,
        this.khewatNo,
        this.khatauniNo,
        this.khasraNo,
        this.createdAt,
        this.updatedAt});

  LandData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerId = json['farmer_id'];
    totalLandArea = json['total_land_area'];
    state = json['state'];
    districtId = json['district_id'];
    tehsilId = json['tehsil_id'];
    cityId = json['city_id'];
    pinCode = json['pin_code'];
    landAddress = json['land_address'];
    areaInformation = json['area_information'];
    uploadFard = json['upload_fard'];
    pattedarNo = json['pattedar_no'];
    uploadPattedar = json['upload_pattedar'];
    khewatNo = json['khewat_no'];
    khatauniNo = json['khatauni_no'];
    khasraNo = json['khasra_no'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['farmer_id'] = this.farmerId;
    data['total_land_area'] = this.totalLandArea;
    data['state'] = this.state;
    data['district_id'] = this.districtId;
    data['tehsil_id'] = this.tehsilId;
    data['city_id'] = this.cityId;
    data['pin_code'] = this.pinCode;
    data['land_address'] = this.landAddress;
    data['area_information'] = this.areaInformation;
    data['upload_fard'] = this.uploadFard;
    data['pattedar_no'] = this.pattedarNo;
    data['upload_pattedar'] = this.uploadPattedar;
    data['khewat_no'] = this.khewatNo;
    data['khatauni_no'] = this.khatauniNo;
    data['khasra_no'] = this.khasraNo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
