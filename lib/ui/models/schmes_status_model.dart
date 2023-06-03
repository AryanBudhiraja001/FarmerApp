class MySchemesStatusModel {
  String? message;
  List<SchemesStatusData>? data;
  String? documentUrl;
  String? mediaUrl;

  MySchemesStatusModel({this.message, this.data,this.documentUrl,this.mediaUrl});

  MySchemesStatusModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <SchemesStatusData>[];
      json['data'].forEach((v) {
        data!.add( SchemesStatusData.fromJson(v));
      });
    }
    documentUrl=json['document_url'];
    mediaUrl=json['media_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['document_url'] = documentUrl;
    data['media_url'] = mediaUrl;
    return data;
  }
}

class SchemesStatusData {
  int? id;
  int? farmerId;
  int? schemeId;
  int? landApplied;
  int? landAddressId;
  String? projectNote;
  String? technicalDatasheet;
  String? bankSanction;
  String? quotationSolar;
  String? sitePlan;
  String? partnershipDeep;
  String? panAadhar;
  String? locationPlan;
  String? landDocuments;
  String? selfDeclaration;
  String? otherDocuments;
  String? state;
  int? districtId;
  int? tehsilId;
  String? status;
  int? publicPrivate;
  var reason;
  var districtReason;
  String? applicationNumber;
  String? stage;
  var districtUpdated;
  var tehsilUpdated;
  var approvedTehsil;
  var approvedDistrict;
  int? attempts;
  int? reattempts;
  String? districtStatus;
  String? commiteeStatus;
  var commiteeUpdated;
  String? createdAt;
  String? updatedAt;
  String? tehsilStatus;
  String? acreatedAt;
  String? aupdatedAt;
  int? govtId;
  int? categoryId;
  int? componentId;
  var subComponentId;
  int? schemeSubcategoryId;
  String? schemeName;
  String? nonProjectBased;
  var subsidy;
  String? costNorms;
  String? terms;
  String? detailedDescription;
  String? videos;
  String? videosTitle;
  String? schemeImage;
  String? privateSector;
  String? publicSector;
  int? publicRange;
  int? privateRange;
  String? isFeatured;
  String? year;
  String? units;
  String? dprUpload;
  String? selfUpload;
  String? totalLandArea;
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
  String? districtName;
  String? tehsilName;
  OfficerDetails? officerDetails;

  SchemesStatusData({this.id,
    this.farmerId,
    this.schemeId,
    this.landApplied,
    this.landAddressId,
    this.projectNote,
    this.technicalDatasheet,
    this.bankSanction,
    this.quotationSolar,
    this.sitePlan,
    this.partnershipDeep,
    this.panAadhar,
    this.locationPlan,
    this.landDocuments,
    this.selfDeclaration,
    this.otherDocuments,
    this.state,
    this.districtId,
    this.tehsilId,
    this.status,
    this.publicPrivate,
    this.reason,
    this.districtReason,
    this.applicationNumber,
    this.stage,
    this.districtUpdated,
    this.tehsilUpdated,
    this.approvedTehsil,
    this.approvedDistrict,
    this.attempts,
    this.reattempts,
    this.districtStatus,
    this.commiteeStatus,
    this.commiteeUpdated,
    this.createdAt,
    this.updatedAt,
    this.tehsilStatus,
    this.acreatedAt,
    this.aupdatedAt,
    this.govtId,
    this.categoryId,
    this.componentId,
    this.subComponentId,
    this.schemeSubcategoryId,
    this.schemeName,
    this.nonProjectBased,
    this.subsidy,
    this.costNorms,
    this.terms,
    this.detailedDescription,
    this.videos,
    this.videosTitle,
    this.schemeImage,
    this.privateSector,
    this.publicSector,
    this.publicRange,
    this.privateRange,
    this.isFeatured,
    this.year,
    this.units,
    this.dprUpload,
    this.selfUpload,
    this.totalLandArea,
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
    this.districtName,
    this.tehsilName,
    this.officerDetails
  });

  SchemesStatusData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerId = json['farmer_id'];
    schemeId = json['scheme_id'];
    landApplied = json['land_applied'];
    landAddressId = json['land_address_id'];
    projectNote = json['project_note'];
    technicalDatasheet = json['technical_datasheet'];
    bankSanction = json['bank_sanction'];
    quotationSolar = json['quotation_solar'];
    sitePlan = json['site_plan'];
    partnershipDeep = json['partnership_deep'];
    panAadhar = json['pan_aadhar'];
    locationPlan = json['location_plan'];
    landDocuments = json['land_documents'];
    selfDeclaration = json['self_declaration'];
    otherDocuments = json['other_documents'];
    state = json['state'];
    districtId = json['district_id'];
    tehsilId = json['tehsil_id'];
    status = json['status'];
    publicPrivate = json['public_private'];
    reason = json['reason'];
    districtReason = json['district_reason'];
    applicationNumber = json['application_number'];
    stage = json['stage'];
    districtUpdated = json['district_updated'];
    tehsilUpdated = json['tehsil_updated'];
    approvedTehsil = json['approved_tehsil'];
    approvedDistrict = json['approved_district'];
    attempts = json['attempts'];
    reattempts = json['reattempts'];
    districtStatus = json['district_status'];
    commiteeStatus = json['commitee_status'];
    commiteeUpdated = json['commitee_updated'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    tehsilStatus = json['tehsil_status'];
    acreatedAt = json['acreated_at'];
    aupdatedAt = json['aupdated_at'];
    govtId = json['govt_id'];
    categoryId = json['category_id'];
    componentId = json['component_id'];
    subComponentId = json['sub_component_id'];
    schemeSubcategoryId = json['scheme_subcategory_id'];
    schemeName = json['scheme_name'];
    nonProjectBased = json['non_project_based'];
    subsidy = json['subsidy'];
    costNorms = json['cost_norms'];
    terms = json['terms'];
    detailedDescription = json['detailed_description'];
    videos = json['videos'];
    videosTitle = json['videos_title'];
    schemeImage = json['scheme_image'];
    privateSector = json['private_sector'];
    publicSector = json['public_sector'];
    publicRange = json['public_range'];
    privateRange = json['private_range'];
    isFeatured = json['is_featured'];
    year = json['year'];
    units = json['units'];
    dprUpload = json['dpr_upload'];
    selfUpload = json['self_upload'];
    totalLandArea = json['total_land_area'];
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
    districtName = json['district_name'];
    tehsilName = json['tehsil_name'];
    officerDetails = json['officer_details'] != null
        ? OfficerDetails.fromJson(json['officer_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['farmer_id'] = this.farmerId;
    data['scheme_id'] = this.schemeId;
    data['land_applied'] = this.landApplied;
    data['land_address_id'] = this.landAddressId;
    data['project_note'] = this.projectNote;
    data['technical_datasheet'] = this.technicalDatasheet;
    data['bank_sanction'] = this.bankSanction;
    data['quotation_solar'] = this.quotationSolar;
    data['site_plan'] = this.sitePlan;
    data['partnership_deep'] = this.partnershipDeep;
    data['pan_aadhar'] = this.panAadhar;
    data['location_plan'] = this.locationPlan;
    data['land_documents'] = this.landDocuments;
    data['self_declaration'] = this.selfDeclaration;
    data['other_documents'] = this.otherDocuments;
    data['state'] = this.state;
    data['district_id'] = this.districtId;
    data['tehsil_id'] = this.tehsilId;
    data['status'] = this.status;
    data['public_private'] = this.publicPrivate;
    data['reason'] = this.reason;
    data['district_reason'] = this.districtReason;
    data['application_number'] = this.applicationNumber;
    data['stage'] = this.stage;
    data['district_updated'] = this.districtUpdated;
    data['tehsil_updated'] = this.tehsilUpdated;
    data['approved_tehsil'] = this.approvedTehsil;
    data['approved_district'] = this.approvedDistrict;
    data['attempts'] = this.attempts;
    data['reattempts'] = this.reattempts;
    data['district_status'] = this.districtStatus;
    data['commitee_status'] = this.commiteeStatus;
    data['commitee_updated'] = this.commiteeUpdated;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['tehsil_status'] = this.tehsilStatus;
    data['acreated_at'] = this.acreatedAt;
    data['aupdated_at'] = this.aupdatedAt;
    data['govt_id'] = this.govtId;
    data['category_id'] = this.categoryId;
    data['component_id'] = this.componentId;
    data['sub_component_id'] = this.subComponentId;
    data['scheme_subcategory_id'] = this.schemeSubcategoryId;
    data['scheme_name'] = this.schemeName;
    data['non_project_based'] = this.nonProjectBased;
    data['subsidy'] = this.subsidy;
    data['cost_norms'] = this.costNorms;
    data['terms'] = this.terms;
    data['detailed_description'] = this.detailedDescription;
    data['videos'] = this.videos;
    data['videos_title'] = this.videosTitle;
    data['scheme_image'] = this.schemeImage;
    data['private_sector'] = this.privateSector;
    data['public_sector'] = this.publicSector;
    data['public_range'] = this.publicRange;
    data['private_range'] = this.privateRange;
    data['is_featured'] = this.isFeatured;
    data['year'] = this.year;
    data['units'] = this.units;
    data['dpr_upload'] = this.dprUpload;
    data['self_upload'] = this.selfUpload;
    data['total_land_area'] = this.totalLandArea;
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
    data['district_name'] = this.districtName;
    data['tehsil_name'] = this.tehsilName;
    if (this.officerDetails != null) {
      data['officer_details'] = this.officerDetails!.toJson();
    }
    return data;
  }
}
class OfficerDetails {
  int? id;
  int? userId;
  String? phoneNumber;
  String? designation;
  String? ihrm;
  String? avatar;
  String? createdAt;
  String? updatedAt;
  String? name;

  OfficerDetails({this.id,
    this.userId,
    this.phoneNumber,
    this.designation,
    this.ihrm,
    this.avatar,
    this.createdAt,
    this.updatedAt,
    this.name});

  OfficerDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    phoneNumber = json['phone_number'];
    designation = json['designation'];
    ihrm = json['ihrm'];
    avatar = json['avatar'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['phone_number'] = this.phoneNumber;
    data['designation'] = this.designation;
    data['ihrm'] = this.ihrm;
    data['avatar'] = this.avatar;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    return data;
  }
}