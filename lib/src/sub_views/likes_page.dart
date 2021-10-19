import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goutu/src/views/info_page.dart';
import 'package:goutu/src/views/map_home_page.dart';

class LikesPage extends StatefulWidget {
  const LikesPage({Key? key}) : super(key: key);

  @override
  _LikesPage createState() => _LikesPage();
}

class _LikesPage extends State<LikesPage> {
  //final List<>
  final List<String> entries = <String>[
    'Jardin Botanico',
    'Marbella',
  ];

  final List<String> km = <String>['1.5km', '2.5km'];

  final List<String> precios = <String>['DOP 95', 'DOP 120'];

  final List<String> imagesSRC = <String>[
    "https://images.visitarepublicadominicana.org/jardin-botanico-santo-domingo.jpg",
    "https://www.marbella-hills-homes.com/cms/wp-content/uploads/2020/12/1.jpg"
  ];

  //final List<int> colorCodes = <int>[600, 500, 100];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Likes Page'),
          backgroundColor: const Color.fromRGBO(16, 16, 20, 1),
        ),
        body: Stack(
          children: [
            const SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 16, right: 16, bottom: 10),
              child: Container(
                color: Colors.grey,
                child: TextField(
                  onChanged: (String str) {
                    //Logica de Filtro
                  },
                  decoration: InputDecoration(
                    icon: Container(
                      margin: const EdgeInsets.only(left: 20, bottom: 15),
                      width: 10,
                      height: 10,
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.white54,
                      ),
                    ),
                    hintText: "Where to go?",
                    hintStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(15),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: ListView.separated(
                padding: const EdgeInsets.all(15),
                itemCount: entries.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 100,
                    color: Colors.white12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const SizedBox(width: 10),
                            Container(
                              width: 80,
                              height: 70,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(imagesSRC[index]),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                Text(
                                  entries[index],
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => const MapSample())
                                        );
                                      },
                                      child: Container(
                                        child: const Icon(
                                          Icons.location_on_outlined,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: const Color.fromRGBO(
                                              253, 175, 1, 1),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    GestureDetector(
                                      onTap: () async {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => const InfoPage()),
                                        );
                                      },
                                      child: Container(
                                        child: const Icon(
                                          Icons.info_outlined,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: const Color.fromRGBO(
                                              253, 175, 1, 1),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    GestureDetector(
                                      onTap: () async {

                                        //Delete from list

                                      },
                                      child: Container(
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: const Color.fromRGBO(
                                                255, 80, 47, 1)),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  height: 15,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromRGBO(16, 16, 20, 1),
      ),
    );
  }
}
