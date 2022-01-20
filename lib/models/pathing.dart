import 'dart:convert';

Pathing pathingFromJson(String str) {
  final jsonData = json.decode(str);
  return Pathing.fromJson(jsonData);
}

String pathingToJson(Pathing data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Pathing {
  int? route;
  String? route_name;
  List<dynamic>? route_coordinates;

  Pathing({this.route, this.route_name, this.route_coordinates});

  factory Pathing.fromJson(Map<String, dynamic> json) => Pathing(
      route: json['route'],
      route_name: json['route_name'],
      route_coordinates: json['route_coordinates'],
  );

  Map<String, dynamic> toJson() => {
    "route": route,
    "route_name": route_name,
    "route_coordinates": route_coordinates,
  };
}