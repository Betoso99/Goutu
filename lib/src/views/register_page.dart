import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget{
  static String identifier = 'loginPage';
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('HomePage'),
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
              _confirmPasswordText(),
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
              hintText: 'example@gmail.com',
              labelText: 'Email Address',
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
                hintText: 'Password',
                labelText: 'Password'
            ),
          ),
        );
      }
  );
}

StatefulWidget _confirmPasswordText(){
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
                hintText: 'Password',
                labelText: 'Password'
            ),
          ),
        );
      }
  );
}