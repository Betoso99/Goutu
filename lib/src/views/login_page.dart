import 'package:flutter/material.dart';
import 'package:goutu/src/views/map_home_page.dart';

class loginPage extends StatefulWidget{
  static String identifier = 'loginPage';
  const loginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<loginPage> {
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
          child: const TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)
              ),
              hintText: 'example@gmail.com',
              hintStyle: TextStyle(color: Colors.white),
              labelText: 'Email Address',
              labelStyle: TextStyle(color: Colors.white)
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
          child: const TextField(
            cursorColor: Colors.white,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            decoration: InputDecoration(
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
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MapSample())
            );
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