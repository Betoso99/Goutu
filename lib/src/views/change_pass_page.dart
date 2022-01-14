import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:goutu/models/user.dart';
import 'package:goutu/src/controllers/user_controller.dart';
import 'package:goutu/src/sub_views/tourist_spots_page.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:goutu/src/views/map_home_page.dart';

class ChangePass extends StatefulWidget{
  static String identifier = 'loginPage';
  final User user;
  const ChangePass({Key? key, required this.user}) : super(key: key);

  @override
  _ChangePass createState() => _ChangePass();
}
final oController = TextEditingController();
final pController = TextEditingController();
final cpController = TextEditingController();

final List<LatLng> poli = <LatLng>[];

class _ChangePass extends State<ChangePass> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Change Passwords'),
          backgroundColor: const Color.fromRGBO(16, 16, 20, 1),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _usernameText(),
              const SizedBox(height: 30, width: 100,),
              _passwordText(),
              const SizedBox(height: 30, width: 100,),
              _confirmPass(),
              const SizedBox(height: 30, width: 100,),
              _ChangeButton(widget.user),
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
            controller: oController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
                color: Colors.white
            ),
            decoration: InputDecoration(
              icon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)
              ),
              hintText: 'Old Password',
              hintStyle: TextStyle(color: Colors.white),
              labelText: 'Old Password',
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
                hintText: 'New Password',
                hintStyle: TextStyle(color: Colors.white),
                labelText: 'New Password',
                labelStyle: TextStyle(color: Colors.white)
            ),
          ),
        );
      }
  );
}

StatefulWidget _confirmPass(){
  return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            controller: cpController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
                color: Colors.white
            ),
            decoration: InputDecoration(
              icon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)
              ),
              hintText: 'Confirm Password',
              hintStyle: TextStyle(color: Colors.white),
              labelText: 'Confirm Password',
              labelStyle: TextStyle(color: Colors.white),
            ),
          ),
        );
      }
  );
}

StatefulWidget _ChangeButton(User user){
  return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return ElevatedButton(
          onPressed: () async {

            Map<String, String> passwords =  {
              'old_password': oController.text,
              'new_password': pController.text
            };
            final  res = await changePasswords(passwords,user.username!);

            if(res.statusCode == 200){
              Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (context) =>
                  MapSample(poly: poli, user: user)),
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