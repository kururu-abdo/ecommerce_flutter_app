class AddressModel {
  int? id;
  int? userId;
  double? lat;
  double? lon;
  String? zipCode;
  String? country;
  String? city;

  AddressModel(
      {this.id,
      this.userId,
      this.lat,
      this.lon,
      this.zipCode,
      this.country,
      this.city});

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    lat = json['lat'];
    lon = json['lon'];
    zipCode = json['zip_code'];
    country = json['country'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['zip_code'] = this.zipCode;
    data['country'] = this.country;
    data['city'] = this.city;
    return data;
  }
}
