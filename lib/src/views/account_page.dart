import 'package:flutter/material.dart';
import 'package:goutu/src/views/home_page.dart';

class AccountPage extends StatefulWidget {
  static String identifier = 'loginPage';

  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPage createState() => _AccountPage();
}

class _AccountPage extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    var space = 15.0, leftpad = 25.0;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Cuenta"),
          backgroundColor: const Color.fromRGBO(16, 16, 16, 1),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 12),
              child: Flexible(
                child: Image.asset(
                  'images/tempsnip.png',
                  height: 400,
                  alignment: Alignment.bottomRight,
                ),
              ),
            ),
          ],
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
                GestureDetector(
                    onTap: () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 200,
                            color: Colors.red,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const Text(
                                    'Seguro Quiere Cerrar Sesion',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 110),
                                    child: Row(
                                      children: [
                                        ElevatedButton(
                                          child: const Text('Si'),
                                          onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomePage()), ModalRoute.withName('/'),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        ElevatedButton(
                                          child: const Text('No'),
                                          onPressed: () => Navigator.pop(context),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: const Text(
                      "Cerrar Sesion",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ))
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
                  "Eliminar Cuenta",
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
