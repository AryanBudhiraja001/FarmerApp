class SchemesCategoryModel {
  int? govtSchemeCatId;
  String? govtSchemeCatName;
  List<Cat>? cat;

  SchemesCategoryModel(
      {this.govtSchemeCatId, this.govtSchemeCatName, this.cat});

  SchemesCategoryModel.fromJson(Map<String, dynamic> json) {
    govtSchemeCatId = json['govt_scheme_cat_id'];
    govtSchemeCatName = json['govt_scheme_cat_name'];
    if (json['cat'] != null) {
      cat = <Cat>[];
      json['cat'].forEach((v) {
        cat!.add(new Cat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['govt_scheme_cat_id'] = this.govtSchemeCatId;
    data['govt_scheme_cat_name'] = this.govtSchemeCatName;
    if (this.cat != null) {
      data['cat'] = this.cat!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cat {
  int? schemeCatId;
  String? schemeCatName;

  Cat({this.schemeCatId, this.schemeCatName});

  Cat.fromJson(Map<String, dynamic> json) {
    schemeCatId = json['scheme_cat_id'];
    schemeCatName = json['scheme_cat_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['scheme_cat_id'] = this.schemeCatId;
    data['scheme_cat_name'] = this.schemeCatName;
    return data;
  }
}