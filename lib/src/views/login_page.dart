import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:goutu/models/user.dart';
import 'package:goutu/src/controllers/user_controller.dart';
import 'package:goutu/src/sub_views/tourist_spots_page.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:goutu/src/views/map_home_page.dart';

class LoginPage extends StatefulWidget{
  static String identifier = 'loginPage';
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}
final uController = TextEditingController();
final pController = TextEditingController();

final List<LatLng> poli = <LatLng>[];

class _LoginPageState extends State<LoginPage> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login Page'),
          backgroundColor: const Color.fromRGBO(16, 16, 20, 1),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: Image.asset('images/logo.png',
                  height: 400,
                  width: 300,
                  alignment: Alignment.bottomCenter,
                ),
              ),
              _usernameText(),
              const SizedBox(height: 30, width: 100,),
              _passwordText(),
              const SizedBox(height: 30, width: 100,),
              _loginButton(),
              const SizedBox(height: 50, width: 100,),
            ],
          ),
        ),
        backgroundColor: const Color.fromRGBO(16, 16, 16, 1),
      ),
    );
  }
}

StatefulWidget _usernameText(){
  return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            controller: uController,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(
                color: Colors.white
            ),
            decoration: const InputDecoration(
              icon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)
              ),
              hintText: 'jperez',
              hintStyle: TextStyle(color: Colors.white),
              labelText: 'Username',
              labelStyle: TextStyle(color: Colors.white),
            ),
          ),
        );
      }
  );
}

StatefulWidget _passwordText(){
  return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child:  TextField(
            controller: pController,
            cursorColor: Colors.white,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            style: const TextStyle(
              color: Colors.white
            ),
            decoration: const InputDecoration(
                icon: Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)
                ),
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.white),
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.white)
            ),
          ),
        );
      }
  );
}

StatefulWidget _loginButton(){
  return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return ElevatedButton(
          onPressed: () async {

            Map<String, String> usr =  {
              'username': uController.text,
              'password': pController.text
            };
            final user = User.fromJson(usr);
            final  res = await loginUser(user);

            if(res.statusCode == 200){

              User userLog = userFromJson(res.body);
              Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (context) =>
                  MapSample(poly: poli, user: userLog)),
                ModalRoute.withName('/'),
              );
            };
          },
          style: ElevatedButton.styleFrom(
            primary: const Color.fromRGBO(255, 80, 47, 1.0),
          ),
          child: Container(
            width: 214,
            padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical:  15.0),
            child: const Text('Login', textAlign: TextAlign.center),
          ),
        );
      }
  );
}