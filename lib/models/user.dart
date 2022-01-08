import 'dart:convert';

User userFromJson(String str) {
  final jsonData = json.decode(str);
  return User.fromJson(jsonData);
}

String userToJson(User data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

String ToJson(User data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class User {
  String? username;
  String? password;
  String? confirm_password;
  String? first_name;
  String? last_name;
  bool? is_active;
  String? email;
  String? registration_date;
  List<dynamic>? favorite_tourist_spots;


  User({
    this.username,
    this.password,
    this.confirm_password,
    this.first_name,
    this.last_name,
    this.is_active,
    this.email,
    this.registration_date,
    this.favorite_tourist_spots
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
      username: json['username'],
      password: json['password'],
      confirm_password: json['confirm_password'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      is_active: json['is_active'],
      email: json['email'],
      registration_date: json['registration_date'],
      favorite_tourist_spots: json['favorite_tourist_spots']
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
    "confirm_password": confirm_password,
    "first_name": first_name,
    "last_name": last_name,
    "is_active": is_active,
    "email": email,
    "registration_date": registration_date,
    "favorite_tourist_spots": favorite_tourist_spots,
  };
}