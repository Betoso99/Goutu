import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:goutu/models/places.dart';
import 'package:goutu/models/user.dart';
import 'package:http/http.dart' as http;

var url_google = 'https://maps.googleapis.com/maps/api/directions/json?';
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

/*
Future<http.Response> getTouristRoute(LatLng origin, LatLng destination) async {
  final response = await http.get(Uri.parse(url+'destination=$destination&origin=$origin&mode=transit&key=AIzaSyB_iMzzl__vncphopqHr8r51Frw5H_q2eU'),
    headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    },
  );
  return response;
}
*/

/*{
  origin: LatLng | String | google.maps.Place,
  destination: LatLng | String | google.maps.Place,
  travelMode: TravelMode,
  transitOptions: TransitOptions,
  drivingOptions: DrivingOptions,
  unitSystem: UnitSystem,
  waypoints[]: DirectionsWaypoint,
  optimizeWaypoints: Boolean,
  provideRouteAlternatives: Boolean,
  avoidFerries: Boolean,
  avoidHighways: Boolean,
  avoidTolls: Boolean,
  region: String
}*/
