class CountryModel {
  String? sId;
  String? name;
  String? countryId;

  CountryModel({this.sId, this.name, this.countryId});

  CountryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    countryId = json['country_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['country_id'] = this.countryId;
    return data;
  }
}
