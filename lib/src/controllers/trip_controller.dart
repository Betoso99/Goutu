import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:goutu/models/places.dart';
import 'package:http/http.dart' as http;

const url = 'https://goutu.loca.lt/api/routes';
String username = 'arielangeles';
String password = '321angeles';
String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

Future<http.Response> getAllRoutes() async{
  final response = await http.get(Uri.parse(url+'/'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader : basicAuth
      },
  );
  return response;
}

Future<http.Response> getRoute(int id) async {
  final response = await http.get(Uri.parse(url+'/$id/'),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader : basicAuth
    },
  );
  print(response.body);
  return response;
}