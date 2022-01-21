import 'package:flutter/material.dart';


class AboutPage extends StatefulWidget {
  static String identifier = 'loginPage';

  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPage createState() => _AboutPage();
}

class _AboutPage extends State<AboutPage> {
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
            Flexible(
              child: Image.asset('images/logo.png',
                alignment: Alignment.bottomCenter,
                height: 300,
                width: 380,
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.7,
              minChildSize: 0.7,
              maxChildSize: 0.7,
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
                              const Text(
                                "-------------------------------------------------------------------------",
                                style: TextStyle(color: Colors.white),
                              ),
                              Row(
                                children: const [
                                  SizedBox(width: 30,),
                                  Text(
                                    '¿Que es Goutu?',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(width: 30,),
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                              const Text(
                                "-------------------------------------------------------------------------",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(height: space),
                              Row(
                                children: const [
                                  SizedBox(width: 30,),
                                  Flexible(child: Text(
                                    'GouTu se planteó como una idea a partir de la diversidad del sistema de transporte público en la República Dominicana y lo difícil que puede llegar a ser el conocer las rutas que estos servicios recorren, de manera que no hay una forma sencilla de encontrar esta información. ',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  )),
                                  SizedBox(width: 30,),
                                ],
                              ),
                              SizedBox(height: space),
                              const Text(
                                "-------------------------------------------------------------------------",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(height: space),
                              const Text(
                                "-------------------------------------------------------------------------",
                                style: TextStyle(color: Colors.white),
                              ),
                              Row(
                                children: const [
                                  SizedBox(width: 30,),
                                  Text(
                                    '¿Cual es nuestro propoosito?',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(width: 30,),
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                              const Text(
                                "-------------------------------------------------------------------------",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(height: space),
                              Row(
                                children: const [
                                  SizedBox(width: 30,),
                                  Flexible(child: Text(
                                    'GouTu se realizará para generar una interfaz simple para que los usuarios puedan ver diferentes rutas para llegar a un destino a través del transporte público, comparándolas en base a su proximidad, tiempo y costo, y al mismo tiempo estimular el turismo interno dándoles a conocer diversas informaciones referentes a puntos de interés dentro de Santo Domingo.',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  )),
                                  SizedBox(width: 30,),
                                ],
                              ),
                              SizedBox(height: space),
                              const Text(
                                "-------------------------------------------------------------------------",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(height: space),
                              const Text(
                                "-------------------------------------------------------------------------",
                                style: TextStyle(color: Colors.white),
                              ),
                              Row(
                                children: const [
                                  SizedBox(width: 30,),
                                  Text(
                                    'Nuestro Equipo',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(width: 30,),
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                              const Text(
                                "-------------------------------------------------------------------------",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(height: space),
                              Row(
                                children: const [
                                  Flexible(child: Text(
                                    'Harold Rodriguez - 1088464 \n Ariel Angeles - 1088157 \n Alberto Osorio - 1085998',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  )),
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                              SizedBox(height: space),
                              const Text(
                                "-------------------------------------------------------------------------",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(height: space),
                            ],
                          ),
                        ),
                      ],
                    )
                );
              },
            ),
          ],
        ),
        backgroundColor: const Color.fromRGBO(16, 16, 16, 1),
      ),
    );
  }
}
