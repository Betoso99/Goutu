import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:goutu/models/user.dart';
import 'package:goutu/src/views/account_page.dart';
import 'package:goutu/src/views/map_home_page.dart';

final List<LatLng> poli = <LatLng>[];

class ProfilePage extends StatefulWidget {
  final User user;
  static String identifier = 'loginPage';

  const ProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  _ProfilePage createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var space = 15.0, leftpad = 20.0;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile Page'),
          backgroundColor: const Color.fromRGBO(16, 16, 20, 1),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 12),
              child: GestureDetector(
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MapSample(poly: poli, user: widget.user,))
                  );
                },
                //child: Flexible(
                  child: Image.asset('images/tempsnip.png',
                    height: 400,
                    alignment: Alignment.bottomRight,
                  ),
                //),
              )
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: leftpad,
              ),
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.0,
                  ),
                ),
                const CircleAvatar(
                  backgroundColor: Color.fromRGBO(255, 80, 847, 1),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 80,
                  ),
                  radius: 60,
                ),
                SizedBox(width: space),
                Column(
                  children: [
                    Text(
                      widget.user.first_name!+" "+ widget.user.last_name!,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '@'+widget.user.username!,
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: space),
            const Text(
              "-------------------------------------------------------------------------",
              style: TextStyle(color: Colors.white),
            ),

            SizedBox(height: space),
            GestureDetector(
              onTap: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AccountPage(user: widget.user,)));
              },
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: leftpad,
                    ),
                  ),
                  Container(
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 40,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color.fromRGBO(253, 175, 1, 1)),
                  ),
                  SizedBox(width: space),
                  const Text(
                    "Cuenta",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: space),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: leftpad,
                  ),
                ),
                Container(
                  child: const Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 40,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color.fromRGBO(253, 175, 1, 1)),
                ),
                SizedBox(width: space),
                const Text(
                  "Configuraciones",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            SizedBox(height: space),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: leftpad,
                  ),
                ),
                Container(
                  child: const Icon(
                    Icons.help,
                    color: Colors.white,
                    size: 40,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color.fromRGBO(253, 175, 1, 1)),
                ),
                SizedBox(width: space),
                const Text(
                  "Ayuda",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                )
              ],
            )
          ],
        ),
        backgroundColor: const Color.fromRGBO(16, 16, 16, 1),
      ),
    );
  }
}
