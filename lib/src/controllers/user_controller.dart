import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:goutu/models/user.dart';
import 'package:http/http.dart' as http;

const url = 'https://goutu.azurewebsites.net/api/users';
String username = 'arielangeles';
String password = '321angeles';
String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

Future<http.Response> loginUser(User usr) async{
  final response = await http.post(Uri.parse(url+'/login/'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader : basicAuth
      },
      body: userToJson(usr)
  );
  return response;
}

Future<http.Response> logoutUser(User usr) async{
  final response = await http.post(Uri.parse(url+'/logout/'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader : basicAuth
      },
      body: userToJson(usr)
  );
  return response;
}

Future<http.Response> eraseUser(User usr) async{
  final response = await http.post(Uri.parse(url+'/logout/'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader : basicAuth
      },
      body: userToJson(usr)
  );
  return response;
}

Future<int> createUser(User user) async{
  final response = await http.post(Uri.parse(url+'/signup/'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader : basicAuth
      },
      body: userToJson(user)
  );
  return response.statusCode;
}

Future<http.Response> changePasswords(Map<String, String> body, String username) async{
  final response = await http.put(Uri.parse(url+'/$username/change-password/'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader : basicAuth
      },
      body: json.encode(body)
  );
  return response;
}

Future<http.Response> getTouristSpotsByUser(String user) async {
  final response = await http.get(Uri.parse(url+'/$user/favorite-spots/'),
    headers: {
      HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
      HttpHeaders.authorizationHeader : basicAuth
    },
  );
  return response;
}

//api/users/tourist-spots/arielangeles/add/
Future<http.Response> addTouristSpotsByUser(String user, Map<String, int> body) async {
  final response = await http.post(Uri.parse(url+'/tourist-spots/$user/add/'),
    headers: {
      HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
      HttpHeaders.authorizationHeader : basicAuth
    },
    body: json.encode(body)
  );
  print(response.body);
  return response;
}

Future<http.Response> deleteTouristSpotsByUser(String user,int id) async {
  final response = await http.delete(Uri.parse(url+'/$user/favorite-spots/$id/'),
    headers: {
      HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
      HttpHeaders.authorizationHeader : basicAuth
    },
  );
  return response;
}

