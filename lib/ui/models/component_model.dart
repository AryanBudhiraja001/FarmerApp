class ComponentModel {
  String? message;
  ComponentTypes? componentTypes;

  ComponentModel({this.message, this.componentTypes});

  ComponentModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    componentTypes = json['component_types'] != null
        ? new ComponentTypes.fromJson(json['component_types'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.componentTypes != null) {
      data['component_types'] = this.componentTypes!.toJson();
    }
    return data;
  }
}

class ComponentTypes {
  int? currentPage;
  List<ComponentData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
   var prevPageUrl;
  int? to;
  int? total;

  ComponentTypes(
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

  ComponentTypes.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <ComponentData>[];
      json['data'].forEach((v) {
        data!.add(new ComponentData.fromJson(v));
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

class ComponentData {
  int? id;
  int? schemeCategoryId;
  String? subcategoryName;
  String? createdAt;
  String? updatedAt;

  ComponentData(
      {this.id,
        this.schemeCategoryId,
        this.subcategoryName,
        this.createdAt,
        this.updatedAt});

  ComponentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    schemeCategoryId = json['scheme_category_id'];
    subcategoryName = json['subcategory_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['scheme_category_id'] = this.schemeCategoryId;
    data['subcategory_name'] = this.subcategoryName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
