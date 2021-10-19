import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  static String identifier = 'loginPage';

  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPage createState() => _AccountPage();
}

class _AccountPage extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    var space = 15.0,
        leftpad = 25.0;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Cuenta"),
          backgroundColor: const Color.fromRGBO(16, 16, 16, 1),
        ),
        body: Column(
          children: [
            const SizedBox(height: 50),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: leftpad,
                  ),
                ),
                const Text(
                  "Contraseñas",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            SizedBox(height: space),
            const Text(
              "-------------------------------------------------------------------------",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: space),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: leftpad,
                  ),
                ),
                const Text(
                  "Cerrar Sesion",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            SizedBox(height: space),
            const Text(
              "-------------------------------------------------------------------------",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: space),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: leftpad,
                  ),
                ),
                const Text(
                  "Eliminar Cuneta",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                  ),
                )
              ],
            ),
            SizedBox(height: space),
          ],
        ),
        backgroundColor: const Color.fromRGBO(16, 16, 16, 1),
      ),
    );
  }
}