import 'package:flutter/material.dart';
import 'package:goutu/models/places.dart';

class InfoPage extends StatefulWidget {
  static String identifier = 'loginPage';
  final Places place;
  const InfoPage({Key? key, required this.place}) : super(key: key);

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
            Image.network(widget.place.image_urls![1]),
            DraggableScrollableSheet(
              initialChildSize: 0.78,
              minChildSize: 0.78,
              maxChildSize: 0.78,
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
                            Row(
                              children: [
                                const SizedBox(width: 30,),
                                Text(
                                  widget.place.province_name.toString(),
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(width: 30,),
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                            const Text(
                              "-------------------------------------------------------------------------",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(height: space),
                            Row(
                              children: [
                                const SizedBox(width: 30,),
                                Flexible(child: Text(
                                  widget.place.description!,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                )),
                                const SizedBox(width: 30,),
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
                                const SizedBox(width: 30,),
                                Flexible(child: Text(
                                  widget.place.address!,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                )),
                                const SizedBox(width: 30,),
                              ],
                            ),
                            SizedBox(height: space),
                            const Text(
                              "-------------------------------------------------------------------------",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 35,
                left: 35,
                top: 90,
                bottom: 600
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 80, 47, 1),
                  borderRadius: BorderRadius.circular(40),
                ),
                alignment: Alignment.center,
                child: Flexible(
                  child: Text(
                    widget.place.name!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25
                    ),
                  ),
                )
              ),
            )
          ],
        ),
        backgroundColor: const Color.fromRGBO(16, 16, 16, 1),
      ),
    );
  }
}
