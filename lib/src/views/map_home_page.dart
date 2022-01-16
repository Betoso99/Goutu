import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:goutu/models/places.dart';
import 'package:goutu/models/user.dart';
import 'package:goutu/src/controllers/trip_controller.dart';
import 'package:goutu/src/sub_views/profile_page.dart';
import 'package:goutu/src/views/tabbed_page.dart';

final toController = TextEditingController();
final fromController = TextEditingController();

List<Places> places = <Places>[];
List<Places> items = <Places>[];

List<List<double>> polylinesarr = [];
List<String?> names = [];
var polylinesdef = polylinesarr.map((e) => LatLng(e[0],e[1])).toList();

var from_node, to_node;

class MapSample extends StatefulWidget {
  //final Map<PolylineId,Polyline> poly;
  final List<LatLng> poly;
  final User user;
  const MapSample({Key? key, required this.poly, required this.user}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

var lat, lon;
void getLocation() async {
  var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  lat = position.latitude;
  lon = position.longitude;
}

class MapSampleState extends State<MapSample> {

  void getPlacesData () async{
    var body = await getAllRoutes();
    places = json.decode(utf8.decode(body.bodyBytes)).map<Places>((value) => Places.fromJson(value)).toList();
    items.addAll(places);
    names = places.map((e) => e.name).toList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    if(widget.poly.isNotEmpty){
      polylinesdef = widget.poly;
    }

    WidgetsBinding.instance
        ?.addPostFrameCallback((_) {getPlacesData();
        });
    setState(() {});
  }
  //final Location location = Location();
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(18.472346, -69.918128),
    zoom: 16,
  );

  static final CameraPosition _MyLoc = CameraPosition(
      target: LatLng(lat,lon),
      zoom: 16
  );

  //Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  /* BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;*/
  double _percent = 0.0;

  void filterSearchResults(String query) {
    List<Places>? dummySearchList = <Places>[];
    dummySearchList.addAll(places);
    if(query.isNotEmpty) {
      List<Places>? dummyListData = <Places>[];
      for (var item in dummySearchList) {
        if(item.name!.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      }
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    }
    else {
      setState(() {
        items.clear();
        items.addAll(places);
      });
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(16, 16, 16, 1),
        actions: <Widget>[
          GestureDetector(
            onTap: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage(user: widget.user,))
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10, right: 12),
              child: Container(
                height: 40,
                width: 37,
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 30,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    color: const Color.fromRGBO(255, 80, 847, 1)
                ),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
            child: Stack(
              children: [
                Positioned.fill(
                  bottom: MediaQuery.of(context).size.height * 0.26,
                  child: GoogleMap(
                      myLocationEnabled: true,
                      mapType: MapType.normal,
                      initialCameraPosition: _kGooglePlex,
                      onMapCreated: (GoogleMapController controller) async {
                        _controller.complete(controller);
                        LocationPermission permission = await Geolocator.requestPermission();
                        setPolylines(widget.poly);
                      },
                      polylines: _polylines,
                      mapToolbarEnabled: true,
                      buildingsEnabled: true,
                      compassEnabled: true,
                      myLocationButtonEnabled: true,
                    ),
                ),
                Positioned.fill(
                  child: NotificationListener<DraggableScrollableNotification>(
                    onNotification: (notification) {
                      setState(() {
                        //print(notification.extent);
                        _percent = 2 * notification.extent - 0.7;
                        //print(_percent);
                      });
                      return true;
                    },
                    child: DraggableScrollableSheet(
                      maxChildSize: 0.85,
                      minChildSize: 0.4,
                      initialChildSize: 0.4,
                      builder: (context,controller) {
                        return Material(
                          elevation: 10,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                          color: const Color.fromRGBO(16, 16, 20, 1),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      width: 40,
                                      color: Colors.white,
                                      height: 2,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Expanded(
                                  child: ListView.builder(
                                    padding: const EdgeInsets.all(15),
                                    itemCount: items.length,
                                    controller: controller,
                                    itemBuilder: (BuildContext context, int index,) {
                                      return Column(
                                        children: [
                                          GestureDetector(
                                            onTap: (){
                                              if(names.contains(fromController.text)){
                                                toController.text = items[index].name!;
                                                from_node = items[index].id;
                                              }
                                              else if(toController.text == ''){
                                                fromController.text = items[index].name!;
                                                to_node = items[index].id;

                                              }
                                              getPlacesData(); //Se puede mejorar
                                            },
                                            child: Container(
                                              height: 80,
                                              color: Colors.white12,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Container(
                                                    child: const Icon(Icons.location_on_outlined, color: Colors.white,),
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          items[index].name.toString(),
                                                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                        ),
                                                        const SizedBox(height: 5),
                                                        /*Text(
                                                          items[index].description.toString(),
                                                          style: const TextStyle(color: Colors.white),
                                                        ),*/
                                                        Text(
                                                          'DOP\$ '+items[index].price.toString(),
                                                          style: const TextStyle(color: Colors.white),
                                                        ),
                                                      ],
                                                    ),
                                                    width: 150,
                                                  ),
                                                  Row(
                                                    children: [
                                                      FloatingActionButton(
                                                        onPressed: () async {
                                                          var res = await getRoute(items[index].id!);
                                                          var tmp = jsonDecode(res.body.toString());
                                                          polylinesdef = tmp.map<LatLng>((e) => LatLng(double.parse(e[0]),double.parse(e[1]))).toList();
                                                          setPolylines(polylinesdef);
                                                          setState(() {});
                                                        },
                                                        child: const FaIcon(FontAwesomeIcons.solidEye,size: 20,),
                                                        elevation: 0.0,
                                                        mini: true,
                                                        backgroundColor: const Color.fromRGBO(255, 80, 847, 1),
                                                      ),
                                                      FloatingActionButton(
                                                        onPressed: () async {
                                                          polylinesdef = [LatLng(0,0)];
                                                          setPolylines(polylinesdef);
                                                          setState(() {});
                                                        },
                                                        child: const FaIcon(FontAwesomeIcons.solidEyeSlash, size: 20,),
                                                        elevation: 0.0,
                                                        mini: true,
                                                        backgroundColor: const Color.fromRGBO(255, 80, 847, 1),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 5,)
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: -170 * (1 - _percent),
                  child: Opacity(
                    opacity: _percent,
                    child: Material(
                      elevation: 10,
                      color: const Color.fromRGBO(16, 16, 20, 1),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: const [
                              BackButton(color: Colors.white,),
                              Text(
                                'Choose destination',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ],
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
                              child: Column(
                                children: [
                                  Container(
                                    height: 35,
                                    alignment: Alignment.center,
                                    child: TextField(
                                      onChanged: (value) {
                                        filterSearchResults(value);
                                      },
                                      controller: fromController,
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
                                        hintText: "From where?",
                                        hintStyle: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Container(
                                    height: 35,
                                    child: TextField(
                                      onChanged: (value) {
                                        filterSearchResults(value);
                                      },
                                      controller: toController,
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
                                        hintText: "To where?",
                                        hintStyle: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              )
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: -50 * (1 - _percent),
                  child: Opacity(
                    opacity: _percent,
                    child: _goTabbed(user: widget.user,),
                  ),
                ),
                /*Visibility(
                    child: Display(user: widget.user,)
                ),*/
              ],
            ),
          ),
    );
  }

  setPolylines(List<LatLng> Points) async {
    setState(() {
      // create a Polyline instance
      // with an id, an RGB color and the list of LatLng pairs
      Polyline polyline = Polyline(
          polylineId: const PolylineId("poly"),
          color: const Color.fromARGB(255, 40, 122, 198),
          width: 5,
          points: Points
      );

      _polylines.add(polyline);
    });
  }

  Future<void> _goToMe() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_MyLoc));
  }
}

class _goTabbed extends StatelessWidget {
  final User user;
  const _goTabbed({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
            builder: (context) =>  Tabbed(user: user,))// Tener en cuenta
        );
      },
      child: Material(
        color: const Color.fromRGBO(255, 80, 47, 1.0),
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.place_sharp, color: Colors.white),
              SizedBox(width: 10),
              Text('Ver sugerencias', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

