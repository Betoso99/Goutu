import 'package:flutter/material.dart';
import 'package:goutu/src/views/register_page.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget{
  static String identifier = 'HomePage';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  //get onPressed => null;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Home Page'),
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
                  alignment: Alignment.center,
                ),
              ),
              _loginButton(),
              const SizedBox(height: 30, width: 100,),
              _registerButton(),
              const SizedBox(height: 100, width: 100,),
            ],
          ),
        ),
        backgroundColor: const Color.fromRGBO(16, 16, 16, 1),
      ),
    );
  }

  StatefulWidget _loginButton(){
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot){
          return ElevatedButton(
            onPressed: (){
              Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const loginPage())
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

  StatefulWidget _registerButton(){
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot){
          return ElevatedButton(
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage())
              );
            },
            style: ElevatedButton.styleFrom(
                primary: const Color.fromRGBO(193, 193, 193, 0.40)
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical:  15.0),
              child: const Text('Register', textAlign: TextAlign.center),
            ),
          );
        }
    );
  }
}