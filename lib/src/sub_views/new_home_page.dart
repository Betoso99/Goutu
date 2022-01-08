import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:goutu/models/places.dart';
import 'package:goutu/models/list_pages.dart';
import 'package:goutu/models/user.dart';
import 'package:goutu/src/views/info_page.dart';
import 'package:goutu/src/views/map_home_page.dart';

final List<Places> places = <Places>[
  Places(
      entries: 'Jardin Botanico',
      km: '1.5km',
      price: 'DOP 95',
      image: "https://images.visitarepublicadominicana.org/jardin-botanico-santo-domingo.jpg"),

  Places(entries: 'Marbella', km: '2.5km', price: 'DOP 120', image: "https://www.marbella-hills-homes.com/cms/wp-content/uploads/2020/12/1.jpg"),
  Places(entries: 'Los Tres Ojos', km: '1km', price: 'DOP 75', image: "https://images.visitarepublicadominicana.org/los-tres-ojos-santo-domingo.jpg"),
];

final List<List<double>> polylinesarr = [
  [18.472425, -69.926299],
  [18.470187, -69.931642],
  [18.468640, -69.926063]
];

final polylinesdef = polylinesarr.map((e) => LatLng(e[0],e[1])).toList();

/*
final Map<PolylineId,Polyline> poli = {
  PolylineId('a'): Polyline(points: [
    LatLng(-69.95902, 18.5111),
    LatLng(-69.95823, 18.50218),
    LatLng(-69.92782, 18.45126)],
      polylineId: PolylineId('a'),
  ),
};
*/

class NewHomePage extends StatefulWidget {
  final User user;
  const NewHomePage({Key? key, required this.user}) : super(key: key);

  @override
  _NewHomePage createState() => _NewHomePage();
}

class _NewHomePage extends State<NewHomePage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
          backgroundColor: const Color.fromRGBO(16, 16, 20, 1),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 12),
              child: GestureDetector(
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MapSample(poly: polylinesdef, user: widget.user,)));
                },
                child: Image.asset(
                  'images/tempsnip.png',
                  height: 400,
                  alignment: Alignment.bottomRight,
                ),
              ),
            )
          ],
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
                    if (str.isEmpty) {
                      setState(() {});
                      return;
                    }
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
                itemCount: places.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 100,
                    color: Colors.white12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MapSample(poly: polylinesdef, user: widget.user,)));
                          },
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              Container(
                                width: 80,
                                height: 70,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(places[index].image.toString()),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 20),
                                  Text(
                                    places[index].entries.toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    places[index].km.toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    places[index].price.toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const InfoPage()));
                                },
                                child: Container(
                                  child: const Icon(
                                    Icons.info_outline,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color:
                                          const Color.fromRGBO(253, 175, 1, 1)),
                                ),
                              ),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () async {

                                  //Add likes

                                },
                                child: Container(
                                  child: const Icon(
                                    Icons.save_alt,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color:
                                          const Color.fromRGBO(255, 80, 47, 1)),
                                ),
                              ),
                              const SizedBox(width: 20),
                            ],
                          ),
                        )
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
