class MandiPriceModel {
  String? message;
  var totalMinPrice;
  var totalMaxPrice;
  var totalModalPrice;
  MandiPricedata? data;

  MandiPriceModel(
      {this.message,
        this.totalMinPrice,
        this.totalMaxPrice,
        this.totalModalPrice,
        this.data});

  MandiPriceModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    totalMinPrice = json['total_min_price'];
    totalMaxPrice = json['total_max_price'];
    totalModalPrice = json['total_modal_price'];
    data = json['data'] != null ?  MandiPricedata.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['total_min_price'] = this.totalMinPrice;
    data['total_max_price'] = this.totalMaxPrice;
    data['total_modal_price'] = this.totalModalPrice;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class MandiPricedata {
  int? currentPage;
  List<MandiData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  Null? prevPageUrl;
  int? to;
  int? total;

  MandiPricedata(
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

  MandiPricedata.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <MandiData>[];
      json['data'].forEach((v) {
        data!.add(MandiData.fromJson(v));
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

class MandiData {
  int? id;
  String? state;
  String? district;
  String? market;
  String? commodity;
  String? variety;
  String? arrivalDate;
  String? minPrice;
  String? maxPrice;
  String? modalPrice;
  String? createdAt;
  String? updatedAt;

  MandiData(
      {this.id,
        this.state,
        this.district,
        this.market,
        this.commodity,
        this.variety,
        this.arrivalDate,
        this.minPrice,
        this.maxPrice,
        this.modalPrice,
        this.createdAt,
        this.updatedAt});

  MandiData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    state = json['state'];
    district = json['district'];
    market = json['market'];
    commodity = json['commodity'];
    variety = json['variety'];
    arrivalDate = json['arrival_date'];
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
    modalPrice = json['modal_price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['state'] = this.state;
    data['district'] = this.district;
    data['market'] = this.market;
    data['commodity'] = this.commodity;
    data['variety'] = this.variety;
    data['arrival_date'] = this.arrivalDate;
    data['min_price'] = this.minPrice;
    data['max_price'] = this.maxPrice;
    data['modal_price'] = this.modalPrice;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
