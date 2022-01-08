import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:goutu/models/user.dart';
import 'package:http/http.dart' as http;

const url = 'https://goutu.loca.lt/api/users';
String username = 'arielangeles';
String password = '321angeles';
String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

/*Future<List<User>> getAllPosts() async {
  final response = await http.get(Uri.https(url,'/'));
  print(response.body);
  return allUserFromJson(response.body);
}*/

Future<http.Response> loginUser(User usr) async{
  final response = await http.post(Uri.parse(url+'/login/'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader : basicAuth
      },
      body: ToJson(usr)
  );
  return response;
}

Future<http.Response> logoutUser(User usr) async{
  final response = await http.post(Uri.parse(url+'/logout/'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader : basicAuth
      },
      body: ToJson(usr)
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
  print(response.body);
  print('-------------------');
  print(response.statusCode);
  print('-------------------');
  print(body);
  print('-------------------');
  print(json.encode(body));
  return response;
}