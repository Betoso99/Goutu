import 'package:flutter/material.dart';
import 'package:goutu/src/views/home_page.dart';

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
          title: const Text('Register Page'),
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
              const SizedBox(height: 30, width: 100,),
              _registerButton(),
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
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)
                ),
                hintText: 'Confirm Password',
                hintStyle: TextStyle(color: Colors.white),
                labelText: 'Confirm Password',
                labelStyle: TextStyle(color: Colors.white)
            ),
          ),
        );
      }
  );
}

StatefulWidget _registerButton(){
  return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return ElevatedButton(
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage())
            );
          },
          style: ElevatedButton.styleFrom(
              primary: const Color.fromRGBO(255, 80, 47, 1.0)
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical:  15.0),
            child: const Text('Register', textAlign: TextAlign.center),
          ),
        );
      }
  );
}
