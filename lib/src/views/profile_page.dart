import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static String identifier = 'loginPage';

  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login Page'),
          backgroundColor: const Color.fromRGBO(16, 16, 20, 1),
        ),
        body: Center(

        ),
      ),
    )
  }
}