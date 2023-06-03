class ProfileDataModel {
  String? message;
  String? mediaUrl;
  String? farmerUniqueId;
  Data? data;

  ProfileDataModel(
      {this.message, this.mediaUrl, this.farmerUniqueId, this.data});

  ProfileDataModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    mediaUrl = json['media_url'];
    farmerUniqueId = json['farmer_unique_id'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['media_url'] = this.mediaUrl;
    data['farmer_unique_id'] = this.farmerUniqueId;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  var id;
  var userId;
  var language;
  var applicantTypeId;
  var name;
  var mobileNumber;
  var  fatherHusbandName;
  var  gender;
  var resident;
  var  aadharNumber;
  var  panNumber;
  var  casteCategoryId;
  var  state;
  var  districtId;
  var  tehsilId;
  var  cityId;
  var  farmerUniqueId;
  var  fullAddress;
  var  pinCode;
  var  avatar;
  var  createdAt;
  var  updatedAt;
  var  districtName;

  Data(
      {this.id,
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
        this.districtName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    language = json['language'];
    applicantTypeId = json['applicant_type_id'];
    name = json['name'];
    mobileNumber = json['mobile_number'];
    fatherHusbandName = json['father_husband_name'];
    gender = json['gender'];
    resident = json['resident'];
    aadharNumber = json['aadhar_number'];
    panNumber = json['pan_number'];
    casteCategoryId = json['caste_category_id'];
    state = json['state'];
    districtId = json['district_id'];
    tehsilId = json['tehsil_id'];
    cityId = json['city_id'];
    farmerUniqueId = json['farmer_unique_id'];
    fullAddress = json['full_address'];
    pinCode = json['pin_code'];
    avatar = json['avatar'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    districtName = json['district_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['language'] = this.language;
    data['applicant_type_id'] = this.applicantTypeId;
    data['name'] = this.name;
    data['mobile_number'] = this.mobileNumber;
    data['father_husband_name'] = this.fatherHusbandName;
    data['gender'] = this.gender;
    data['resident'] = this.resident;
    data['aadhar_number'] = this.aadharNumber;
    data['pan_number'] = this.panNumber;
    data['caste_category_id'] = this.casteCategoryId;
    data['state'] = this.state;
    data['district_id'] = this.districtId;
    data['tehsil_id'] = this.tehsilId;
    data['city_id'] = this.cityId;
    data['farmer_unique_id'] = this.farmerUniqueId;
    data['full_address'] = this.fullAddress;
    data['pin_code'] = this.pinCode;
    data['avatar'] = this.avatar;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['district_name'] = this.districtName;
    return data;
  }
}
