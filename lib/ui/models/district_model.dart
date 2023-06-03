

import 'package:json_annotation/json_annotation.dart';
part 'district_model.g.dart';


@JsonSerializable()
class DistrictModel {
  String? message;
  Data? data;

  DistrictModel({this.message, this.data});
  factory DistrictModel.fromJson(Map<String, dynamic> json) => _$DistrictModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$DistrictModelToJson(this);

}

class Data {
  List<District>? district;
  List<ApplicantType>? applicantType;
  List<CasteCategory>? casteCategory;

  Data({this.district, this.applicantType, this.casteCategory});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['district'] != null) {
      district = <District>[];
      json['district'].forEach((v) {
        district!.add(District.fromJson(v));
      });
    }
    if (json['applicantType'] != null) {
      applicantType = <ApplicantType>[];
      json['applicantType'].forEach((v) {
        applicantType!.add(ApplicantType.fromJson(v));
      });
    }
    if (json['CasteCategory'] != null) {
      casteCategory = <CasteCategory>[];
      json['CasteCategory'].forEach((v) {
        casteCategory!.add(CasteCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.district != null) {
      data['district'] = this.district!.map((v) => v.toJson()).toList();
    }
    if (this.applicantType != null) {
      data['applicantType'] =
          this.applicantType!.map((v) => v.toJson()).toList();
    }
    if (this.casteCategory != null) {
      data['CasteCategory'] =
          this.casteCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class District {
  int? districtId;
  String? districtName;
  List<Tehsil>? tehsil;

  District({this.districtId, this.districtName, this.tehsil});

  District.fromJson(Map<String, dynamic> json) {
    districtId = json['district_id'];
    districtName = json['district_name'];
    if (json['tehsil'] != null) {
      tehsil = <Tehsil>[];
      json['tehsil'].forEach((v) {
        tehsil!.add(Tehsil.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['district_id'] = districtId;
    data['district_name'] = districtName;
    if (tehsil != null) {
      data['tehsil'] = tehsil!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tehsil {
  int? tehsilId;
  String? tehsilName;
  List<City>? city;

  Tehsil({this.tehsilId, this.tehsilName, this.city});

  Tehsil.fromJson(Map<String, dynamic> json) {
    tehsilId = json['tehsil_id'];
    tehsilName = json['tehsil_name'];
    if (json['city'] != null) {
      city = <City>[];
      json['city'].forEach((v) {
        city!.add(City.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['tehsil_id'] = this.tehsilId;
    data['tehsil_name'] = this.tehsilName;
    if (this.city != null) {
      data['city'] = this.city!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class City {
  int? cityId;
  String? cityName;

  City({this.cityId, this.cityName});

  City.fromJson(Map<String, dynamic> json) {
    cityId = json['city_id'];
    cityName = json['city_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city_id'] = this.cityId;
    data['city_name'] = this.cityName;
    return data;
  }
}

class ApplicantType {
  int? id;
  String? applicantTypeName;

  ApplicantType({this.id, this.applicantTypeName});

  ApplicantType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    applicantTypeName = json['applicant_type_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['applicant_type_name'] = this.applicantTypeName;
    return data;
  }
}

class CasteCategory {
  int? id;
  String? casteName;

  CasteCategory({this.id, this.casteName});

  CasteCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    casteName = json['caste_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['caste_name'] = this.casteName;
    return data;
  }
}