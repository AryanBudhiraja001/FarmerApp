class SchemesModel {
  String? message;
  String? mediaUrl;
  String? docUrl;
  Schemes? schemes;

  SchemesModel({this.message, this.mediaUrl, this.docUrl, this.schemes});

  SchemesModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    mediaUrl = json['media_url'];
    docUrl = json['doc_url'];
    schemes =
    json['schemes'] != null ? new Schemes.fromJson(json['schemes']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['media_url'] = this.mediaUrl;
    data['doc_url'] = this.docUrl;
    if (this.schemes != null) {
      data['schemes'] = this.schemes!.toJson();
    }
    return data;
  }
}

class Schemes {
  int? currentPage;
  List<Scheme>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  var nextPageUrl;
  String? path;
  int? perPage;
  var prevPageUrl;
  int? to;
  int? total;

  Schemes(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  Schemes.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Scheme>[];
      json['data'].forEach((v) {
        data!.add(Scheme.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Scheme {
  int? id;
  int? govtId;
  int? categoryId;
  int? componentId;
 var subComponentId;
  int? schemeSubcategoryId;
  String? schemeName;
  String? nonProjectBased;
 var subsidy;
  String? costNorms;
  List<Terms>? terms;
  String? detailedDescription;
  String? videos;
  String? videosTitle;
  String? schemeImage;
  String? privateSector;
  String? publicSector;
  int? publicRange;
  int? privateRange;
  String? isFeatured;
  String? status;
  String? year;
  String? units;
var dprUpload;
 var selfUpload;
  String? createdAt;
  String? updatedAt;
  List<Video>? video;

  Scheme(
      {this.id,
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
        this.status,
        this.year,
        this.units,
        this.dprUpload,
        this.selfUpload,
        this.createdAt,
        this.updatedAt,
        this.video});

  Scheme.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    govtId = json['govt_id'];
    categoryId = json['category_id'];
    componentId = json['component_id'];
    subComponentId = json['sub_component_id'];
    schemeSubcategoryId = json['scheme_subcategory_id'];
    schemeName = json['scheme_name'];
    nonProjectBased = json['non_project_based'];
    subsidy = json['subsidy'];
    costNorms = json['cost_norms'];
    if (json['terms'] != null) {
      terms = <Terms>[];
      json['terms'].forEach((v) {
        terms!.add(new Terms.fromJson(v));
      });
    }
    detailedDescription = json['detailed_description'];
    videos = json['videos'];
    videosTitle = json['videos_title'];
    schemeImage = json['scheme_image'];
    privateSector = json['private_sector'];
    publicSector = json['public_sector'];
    publicRange = json['public_range'];
    privateRange = json['private_range'];
    isFeatured = json['is_featured'];
    status = json['status'];
    year = json['year'];
    units = json['units'];
    dprUpload = json['dpr_upload'];
    selfUpload = json['self_upload'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['video'] != null) {
      video = <Video>[];
      json['video'].forEach((v) {
        video!.add(new Video.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['govt_id'] = this.govtId;
    data['category_id'] = this.categoryId;
    data['component_id'] = this.componentId;
    data['sub_component_id'] = this.subComponentId;
    data['scheme_subcategory_id'] = this.schemeSubcategoryId;
    data['scheme_name'] = this.schemeName;
    data['non_project_based'] = this.nonProjectBased;
    data['subsidy'] = this.subsidy;
    data['cost_norms'] = this.costNorms;
    if (this.terms != null) {
      data['terms'] = this.terms!.map((v) => v.toJson()).toList();
    }
    data['detailed_description'] = this.detailedDescription;
    data['videos'] = this.videos;
    data['videos_title'] = this.videosTitle;
    data['scheme_image'] = this.schemeImage;
    data['private_sector'] = this.privateSector;
    data['public_sector'] = this.publicSector;
    data['public_range'] = this.publicRange;
    data['private_range'] = this.privateRange;
    data['is_featured'] = this.isFeatured;
    data['status'] = this.status;
    data['year'] = this.year;
    data['units'] = this.units;
    data['dpr_upload'] = this.dprUpload;
    data['self_upload'] = this.selfUpload;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.video != null) {
      data['video'] = this.video!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Terms {
  String? terms;

  Terms({this.terms});

  Terms.fromJson(Map<String, dynamic> json) {
    terms = json['terms'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['terms'] = this.terms;
    return data;
  }
}

class Video {
 var video;
  var title;

  Video({this.video, this.title});

  Video.fromJson(Map<String, dynamic> json) {
    video = json['video'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['video'] = this.video;
    data['title'] = this.title;
    return data;
  }
}
