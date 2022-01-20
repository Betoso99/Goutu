import 'dart:async';
import 'dart:async';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:goutu/models/places.dart';
import 'package:goutu/models/user.dart';
import 'package:http/http.dart' as http;

const url_google = 'https://maps.googleapis.com/maps/api/directions/json?';
const url = 'https://goutu.azurewebsites.net/api/';
String username = 'arielangeles';
String password = '321angeles';
String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

Future<http.Response> getAllRoutes() async{
  final response = await http.get(Uri.parse(url+'/routes'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader : basicAuth
      },
  );
  return response;
}

Future<http.Response> getRoute(int id) async {
  final response = await http.get(Uri.parse(url+'/routes/$id/coordinates/'),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader : basicAuth
    },
  );
  return response;
}

Future<http.Response> getTouristSpots() async {
  final response = await http.get(Uri.parse(url+'/trips/tourist-spots'),
    headers: {
      HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
      HttpHeaders.authorizationHeader : basicAuth
    },
  );
  return response;
}


Future<http.Response> getGraphRoute(Map<String, int> nodes) async {
  final response = await http.post(Uri.parse(url+'/routes/graph/shortest-path/'),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader : basicAuth
    },
    body: json.encode(nodes)
  );
  //print(response.body);
  return response;
}

/*
Future<http.Response> getStops() async {
  final response = await http.get(Uri.parse(url+'/routes/stops/'),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader : basicAuth
    },
  );
  return response;
}
*/

