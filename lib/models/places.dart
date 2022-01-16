import 'dart:convert';

Places placesFromJson(String str) {
  final jsonData = json.decode(str);
  return Places.fromJson(jsonData);
}

String placesToJson(Places data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Places {
  int? id;
  String? name;
  String? description;
  String? price;
  int? province;
  String? province_name;
  int? transport_type;
  int? organization;
  String? latitude;
  String? longitude;
  List<List<double>>? route_coordinates;
  List<dynamic>? image_urls;

  Places({this.id, this.name, this.description, this.price, this.province, this.province_name, this.transport_type, this.organization, this.route_coordinates, this.image_urls, this.longitude, this.latitude});

  factory Places.fromJson(Map<String, dynamic> json) => Places(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      province: json['province'],
      province_name: json['province_name'],
      transport_type: json['transport_type'],
      organization: json['organization'],
      route_coordinates: json['route_coordinates'],
      image_urls: json['image_urls'],
      latitude: json['latitude'],
      longitude: json['longitude']
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "price": price,
    "province": province,
    "province_name": province_name,
    "transport_type": transport_type,
    "organization": organization,
    "route_coordinates": route_coordinates,
    "image_urls": image_urls,
    "longitude": longitude,
    "latitude": latitude
  };
}

