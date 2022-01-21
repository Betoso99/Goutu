import 'package:flutter/material.dart';
import 'package:goutu/models/user.dart';
import 'package:goutu/src/controllers/user_controller.dart';
import 'package:goutu/src/views/home_page.dart';
import 'package:goutu/widgets/popup_widget.dart';

class RegisterPage extends StatefulWidget{
  static String identifier = 'loginPage';
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPage createState() => _RegisterPage();
}

final uController = TextEditingController();
final pController = TextEditingController();
final fnController = TextEditingController();
final lnController = TextEditingController();
final cpController = TextEditingController();

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
          child: ListView(
            children: [
              Image.asset('images/logo.png',
                height: 250,
                width: 300,
                alignment: Alignment.bottomCenter,
              ),
              _firstNameText(),
              const SizedBox(height: 30, width: 100,),
              _lastNameText(),
              const SizedBox(height: 30, width: 100,),
              _usernameText(),
              const SizedBox(height: 30, width: 100,),
              _passwordText(),
              const SizedBox(height: 30, width: 100,),
              _confirmPasswordText(),
              const SizedBox(height: 30, width: 100,),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal : 20.0),
                  child: _registerButton()
              ),
              const SizedBox(height: 50, width: 100,),
            ],
          ),
        ),
        backgroundColor: const Color.fromRGBO(16, 16, 16, 1),
      ),
    );
  }
}

StatefulWidget _firstNameText(){
  return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            controller: fnController,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(
                color: Colors.white
            ),
            decoration: const InputDecoration(
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)
                ),
                hintText: 'Juan',
                hintStyle: TextStyle(color: Colors.white),
                labelText: 'First Name',
                labelStyle: TextStyle(color: Colors.white)
            ),
          ),
        );
      }
  );
}

StatefulWidget _lastNameText(){
  return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            controller: lnController,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(
                color: Colors.white
            ),
            decoration: const InputDecoration(
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)
                ),
                hintText: 'Perez',
                hintStyle: TextStyle(color: Colors.white),
                labelText: 'Last Name',
                labelStyle: TextStyle(color: Colors.white)
            ),
          ),
        );
      }
  );
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
                  Icons.contact_mail,
                  color: Colors.white,
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)
                ),
                hintText: 'jperez',
                hintStyle: TextStyle(color: Colors.white),
                labelText: 'Username',
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
          child: TextField(
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

StatefulWidget _confirmPasswordText(){
  return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child:  TextField(
            controller: cpController,
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
          onPressed: () async {
            Map<String, String> usr =  {
              "first_name": fnController.text,
              "last_name": lnController.text,
              'username': uController.text,
              'password': pController.text,
              "confirm_password": cpController.text,
            };
            final  res = await createUser(User.fromJson(usr));

            if(res == 201) {
              Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) => const HomePage()),
                ModalRoute.withName('/'),
              );
            }
            else{
              registerdPopupDialog(context);
            }
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
