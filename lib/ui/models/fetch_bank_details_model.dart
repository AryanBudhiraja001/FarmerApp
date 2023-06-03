class FetchBankDetailsModel {
  String? message;
  String? mediaUrl;
  Data? data;

  FetchBankDetailsModel({this.message, this.mediaUrl, this.data});

  FetchBankDetailsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    mediaUrl = json['media_url'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['media_url'] = this.mediaUrl;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  int? farmerId;
  String? bankName;
  String? ifscCode;
  String? branchName;
  String? accountNo;
  String? accountName;
  String? bankBranchAddress;
  String? uploadCancelCheck;
  String? uploadPassbook;
  Null? passbookNo;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.farmerId,
        this.bankName,
        this.ifscCode,
        this.branchName,
        this.accountNo,
        this.accountName,
        this.bankBranchAddress,
        this.uploadCancelCheck,
        this.uploadPassbook,
        this.passbookNo,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerId = json['farmer_id'];
    bankName = json['bank_name'];
    ifscCode = json['ifsc_code'];
    branchName = json['branch_name'];
    accountNo = json['account_no'];
    accountName = json['account_name'];
    bankBranchAddress = json['bank_branch_address'];
    uploadCancelCheck = json['upload_cancel_check'];
    uploadPassbook = json['upload_passbook'];
    passbookNo = json['passbook_no'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['farmer_id'] = this.farmerId;
    data['bank_name'] = this.bankName;
    data['ifsc_code'] = this.ifscCode;
    data['branch_name'] = this.branchName;
    data['account_no'] = this.accountNo;
    data['account_name'] = this.accountName;
    data['bank_branch_address'] = this.bankBranchAddress;
    data['upload_cancel_check'] = this.uploadCancelCheck;
    data['upload_passbook'] = this.uploadPassbook;
    data['passbook_no'] = this.passbookNo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
