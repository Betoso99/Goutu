


class Places {
  String? entries;
  String? km;
  String? price;
  String? image;
  int? transferNum;

  Places({this.entries, this.km, this.price, this.image, this.transferNum});
}


/*List<User> allUserFromJson(String str) {
  final jsonData = json.decode(str);
  return List<User>.from(jsonData.map((x) => User.fromJson(x)));
}

String allUserToJson(List<User> data) {
  final dyn = List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}*/