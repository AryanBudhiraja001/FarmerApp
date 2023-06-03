class MandiDataModel {
  String? message;
  Data? data;

  MandiDataModel({this.message, this.data});

  MandiDataModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<District>? district;
  List<Commodity>? commodity;
  List<Market>? market;

  Data({this.district, this.commodity, this.market});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['district'] != null) {
      district = <District>[];
      json['district'].forEach((v) {
        district!.add(new District.fromJson(v));
      });
    }
    if (json['commodity'] != null) {
      commodity = <Commodity>[];
      json['commodity'].forEach((v) {
        commodity!.add(new Commodity.fromJson(v));
      });
    }
    if (json['market'] != null) {
      market = <Market>[];
      json['market'].forEach((v) {
        market!.add(new Market.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.district != null) {
      data['district'] = this.district!.map((v) => v.toJson()).toList();
    }
    if (this.commodity != null) {
      data['commodity'] = this.commodity!.map((v) => v.toJson()).toList();
    }
    if (this.market != null) {
      data['market'] = this.market!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class District {
  String? district;

  District({this.district});

  District.fromJson(Map<String, dynamic> json) {
    district = json['district'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['district'] = this.district;
    return data;
  }
}

class Commodity {
  String? commodity;

  Commodity({this.commodity});

  Commodity.fromJson(Map<String, dynamic> json) {
    commodity = json['commodity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commodity'] = this.commodity;
    return data;
  }
}

class Market {
  String? market;

  Market({this.market});

  Market.fromJson(Map<String, dynamic> json) {
    market = json['market'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['market'] = this.market;
    return data;
  }
}
