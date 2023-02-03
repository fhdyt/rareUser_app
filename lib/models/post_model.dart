class PostModel {
  String? url;
  String? source;
  String? file;
  String? thumbnail;
  String? sId;
  String? userId;

  PostModel(
      {this.url,
      this.source,
      this.file,
      this.thumbnail,
      this.sId,
      this.userId});

  PostModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    source = json['source'];
    file = json['file'];
    thumbnail = json['thumbnail'];
    sId = json['_id'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['source'] = this.source;
    data['file'] = this.file;
    data['thumbnail'] = this.thumbnail;
    data['_id'] = this.sId;
    data['user_id'] = this.userId;
    return data;
  }
}
