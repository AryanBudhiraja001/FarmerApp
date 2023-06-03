class VideosModel {
  String? message;
  VideoData? data;

  VideosModel({this.message, this.data});

  VideosModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new VideoData.fromJson(json['data']) : null;
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

class VideoData {
  int? currentPage;
  List<VideoDetailsData>? data;
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

  VideoData(
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

  VideoData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <VideoDetailsData>[];
      json['data'].forEach((v) {
        data!.add(new VideoDetailsData.fromJson(v));
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

class VideoDetailsData {
  int? id;
  String? videoId;
  String? etag;
  String? channelId;
  String? title;
  String? description;
  String? thumbnail;
  String? views;
  String? publishTime;
  String? createdAt;
  String? updatedAt;

  VideoDetailsData(
      {this.id,
        this.videoId,
        this.etag,
        this.channelId,
        this.title,
        this.description,
        this.thumbnail,
        this.views,
        this.publishTime,
        this.createdAt,
        this.updatedAt});

  VideoDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    videoId = json['video_id'];
    etag = json['etag'];
    channelId = json['channel_id'];
    title = json['title'];
    description = json['description'];
    thumbnail = json['thumbnail'];
    views = json['views'];
    publishTime = json['publish_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['video_id'] = this.videoId;
    data['etag'] = this.etag;
    data['channel_id'] = this.channelId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['thumbnail'] = this.thumbnail;
    data['views'] = this.views;
    data['publish_time'] = this.publishTime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
