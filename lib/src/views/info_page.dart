import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  static String identifier = 'loginPage';

  const InfoPage({Key? key}) : super(key: key);

  @override
  _InfoPage createState() => _InfoPage();
}

class _InfoPage extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    var space = 15.0, leftpad = 25.0;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Stack(
          children: [
            Image.network("https://images.visitarepublicadominicana.org/jardin-botanico-santo-domingo.jpg"),
            DraggableScrollableSheet(
              initialChildSize: 0.8,
              minChildSize: 0.65,
              maxChildSize: 0.8,
              builder: (BuildContext context, ScrollController scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(16, 16, 16, 1),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 50),
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
                                const Text(
                                  "Cuenta",
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
                                Container(
                                  child: const Icon(
                                    Icons.archive_rounded,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: const Color.fromRGBO(253, 175, 1, 1)),
                                ),
                                const Text(
                                  "Notificaciones",
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
                                const Text(
                                  "Configuraciones",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 100,
                          left: 60
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 80, 47, 1),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Jardin Botanico",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                );
              },
            )
          ],
        ),
        backgroundColor: const Color.fromRGBO(16, 16, 16, 1),
      ),
    );
  }
}
