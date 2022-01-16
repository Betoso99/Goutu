import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:goutu/models/places.dart';
import 'package:goutu/models/user.dart';
import 'package:goutu/src/controllers/user_controller.dart';
import 'package:goutu/src/views/info_page.dart';
import 'package:goutu/src/views/map_home_page.dart';

/*final List<Places> fav_spots = <Places>[
  Places(entries: 'Jardin Botanico', km: '1.5km', price: 'DOP 95', image: "https://images.visitarepublicadominicana.org/jardin-botanico-santo-domingo.jpg"),
  Places(entries: 'Marbella', km: '2.5km', price: 'DOP 120', image: "https://www.marbella-hills-homes.com/cms/wp-content/uploads/2020/12/1.jpg"),
  Places(entries: 'Los Tres Ojos', km: '1km', price: 'DOP 75', image: "https://images.visitarepublicadominicana.org/los-tres-ojos-santo-domingo.jpg"),
];*/

List<Places> fav_spots = <Places>[];

List<List<double>> polylinesarr = [
/*  [18.472425, -69.926299],
  [18.470187, -69.931642],
  [18.468640, -69.926063]*/
];

var polylinesdef = polylinesarr.map((e) => LatLng(e[0],e[1])).toList();

class LikesPage extends StatefulWidget {
  final User user;
  const LikesPage({Key? key, required this.user}) : super(key: key);

  @override
  _LikesPage createState() => _LikesPage();
}

class _LikesPage extends State<LikesPage> {

  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyB_iMzzl__vncphopqHr8r51Frw5H_q2eU";
  List<LatLng> polylineCoordinates = [];

  late LatLng startLocation;
  late LatLng endLocation;

  void getPlacesData () async{
    var body = await getTouristSpotsByUser(widget.user.username!);
    fav_spots = json.decode(utf8.decode(body.bodyBytes))['favorite_tourist_spots'].map<Places>((value) => Places.fromJson(value)).toList();
    items = fav_spots;

    setState(() {});
  }

  @override
  void initState(){
    super.initState();

    WidgetsBinding.instance
        ?.addPostFrameCallback((_) {getPlacesData();
    });
  }

  getDirections() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(startLocation.latitude, startLocation.longitude),
      PointLatLng(endLocation.latitude, endLocation.longitude),
      travelMode: TravelMode.transit,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    //addPolyLine(polylineCoordinates);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tourist Spots'),
          backgroundColor: const Color.fromRGBO(16, 16, 20, 1),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 12),
              child: GestureDetector(
                onTap: () async {
                  polylineCoordinates = [const LatLng(0,0)];
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MapSample(poly: polylineCoordinates, user: widget.user,)));
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
                itemCount: fav_spots.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 100,
                    color: Colors.white12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                            startLocation = LatLng(position.latitude, position.longitude);
                            endLocation = LatLng(double.parse(fav_spots[index].latitude!),double.parse(fav_spots[index].longitude!));
                            getDirections();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MapSample(poly: polylineCoordinates, user: widget.user,)));
                          },
                          child: Row(
                            children: [
                              const SizedBox(width: 5),
                              Container(
                                width: 100,
                                height: 70,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(fav_spots[index].image_urls![0].toString()),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),
                              SizedBox(
                                width: 125,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    Text(
                                      fav_spots[index].name.toString(),
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(height: 10),
                                    /*Text(
                                      spots[index].province.toString(),
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      spots[index].price.toString(),
                                      style: const TextStyle(color: Colors.white),
                                    ),*/
                                  ],
                                ),
                              )
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
                                              InfoPage(place: fav_spots[index])));
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
                                  deleteTouristSpotsByUser(widget.user.username!, fav_spots[index].id!);
                                  fav_spots.removeAt(index);
                                  setState(() {
                                  });
                                },
                                child: Container(
                                  child: const Icon(
                                    Icons.delete_forever,
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
