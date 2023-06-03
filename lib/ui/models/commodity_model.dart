class CommodityModel {
  String? message;
  List<Data>? data;

  CommodityModel({this.message, this.data});

  CommodityModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? commodity;

  Data({this.commodity});

  Data.fromJson(Map<String, dynamic> json) {
    commodity = json['commodity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commodity'] = this.commodity;
    return data;
  }
}