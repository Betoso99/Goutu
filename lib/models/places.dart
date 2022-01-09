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
  String? id;
  String? name;
  String? description;
  String? price;
  int? province;
  int? transport_type;
  int? organization;

  Places({this.id, this.name, this.description, this.price, this.province, this.transport_type, this.organization});

  factory Places.fromJson(Map<String, dynamic> json) => Places(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      province: json['province'],
      transport_type: json['transport_type'],
      organization: json['organization'],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "price": price,
    "province": province,
    "transport_type": transport_type,
    "organization": organization,
  };

}

