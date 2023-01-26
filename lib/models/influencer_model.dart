class InfluencerModel {
  String? sId;
  String? name;
  String? pic;
  String? desc;
  Country? country;
  String? gender;
  List<String>? tags;
  String? createdAt;
  String? updatedAt;
  int? iV;
  List<Posts>? posts;
  List<Platforms>? platforms;

  InfluencerModel(
      {this.sId,
      this.name,
      this.pic,
      this.desc,
      this.country,
      this.gender,
      this.tags,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.posts,
      this.platforms});

  InfluencerModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    pic = json['pic'];
    desc = json['desc'];
    country =
        json['country'] != null ? new Country.fromJson(json['country']) : null;
    gender = json['gender'];
    tags = json['tags'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    if (json['posts'] != null) {
      posts = <Posts>[];
      json['posts'].forEach((v) {
        posts!.add(new Posts.fromJson(v));
      });
    }
    if (json['platforms'] != null) {
      platforms = <Platforms>[];
      json['platforms'].forEach((v) {
        platforms!.add(new Platforms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['pic'] = this.pic;
    data['desc'] = this.desc;
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    data['gender'] = this.gender;
    data['tags'] = this.tags;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    if (this.posts != null) {
      data['posts'] = this.posts!.map((v) => v.toJson()).toList();
    }
    if (this.platforms != null) {
      data['platforms'] = this.platforms!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Country {
  String? name;
  String? countryId;

  Country(this.name, this.countryId);

  Country.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    countryId = json['country_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['country_id'] = this.countryId;
    return data;
  }
}

class Posts {
  String? url;
  String? source;
  String? file;
  String? thumbnail;

  Posts({this.url, this.source, this.file, this.thumbnail});

  Posts.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    source = json['source'];
    file = json['file'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['source'] = this.source;
    data['file'] = this.file;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}

class Platforms {
  String? platform;
  String? username;
  String? link;
  String? sId;

  Platforms({this.platform, this.username, this.link, this.sId});

  Platforms.fromJson(Map<String, dynamic> json) {
    platform = json['platform'];
    username = json['username'];
    link = json['link'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['platform'] = this.platform;
    data['username'] = this.username;
    data['link'] = this.link;
    data['_id'] = this.sId;
    return data;
  }
}
