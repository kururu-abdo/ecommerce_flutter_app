class AddressModel {
  int? id;
  int? userId;
  double? lat;
  double? lon;
  String? zipCode;
  String? country;
  String? city;
  String? fullName;

  AddressModel(
      {this.id,
      this.userId,
      this.lat,
      this.lon,
      this.zipCode,
      this.country,
      this.fullName,
      this.city});

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    lat = json['lat'];
    lon = json['lon'];
    zipCode = json['zip_code'];
    country = json['country'];
    city = json['city'];
    fullName =  json['full_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['lat'] = lat;
    data['lon'] = lon;
    data['zip_code'] = zipCode;
    data['country'] = country;
    data['city'] = city;
    return data;
  }
}
