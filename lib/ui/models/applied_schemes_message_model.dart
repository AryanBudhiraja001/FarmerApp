class MessageResponseModel {
  String? message;
  String? documentUrl;

  MessageResponseModel({this.message, this.documentUrl});

  MessageResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    documentUrl = json['document_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['document_url'] = this.documentUrl;
    return data;
  }
}
