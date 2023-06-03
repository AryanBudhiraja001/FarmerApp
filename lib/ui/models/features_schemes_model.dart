

import 'SchemesModel.dart';

class FeatureSchemesModel {
  String? message;
  String? mediaUrl;
  String? docUrl;
  List<Scheme>? schemes;

  FeatureSchemesModel({this.message, this.mediaUrl, this.docUrl, this.schemes});

  FeatureSchemesModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    mediaUrl = json['media_url'];
    docUrl = json['doc_url'];
    if (json['schemes'] != null) {
      schemes = <Scheme>[];
      json['schemes'].forEach((v) {
        schemes!.add( Scheme.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['media_url'] = this.mediaUrl;
    data['doc_url'] = this.docUrl;
    if (this.schemes != null) {
      data['schemes'] = this.schemes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


