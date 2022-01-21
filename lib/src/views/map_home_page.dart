import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:goutu/models/pathing.dart';
import 'package:goutu/models/places.dart';
import 'package:goutu/models/user.dart';
import 'package:goutu/src/controllers/trip_controller.dart';
import 'package:goutu/src/sub_views/profile_page.dart';
import 'package:goutu/src/views/tabbed_page.dart';

final Completer<GoogleMapController> _controller = Completer();
final toController = TextEditingController();
final fromController = TextEditingController();
Set<Marker> markers = {};
List<Places> places = <Places>[];
List<Places> items = <Places>[];
List<List<dynamic>?> ids = [];
List<List<double>> polylinesarr = [];
List<String?> names = [];
Set<Polyline> _polylines = {};
List<LatLng> polylineCoordinates = [];
PolylinePoints polylinePoints = PolylinePoints();
double _percent = 0.0;
var polylinesdef = polylinesarr.map((e) => LatLng(e[0],e[1])).toList();
var stop = 0, n=0, from_node, to_node, lat, lon;
var count = true;

class MapSample extends StatefulWidget {
  final List<LatLng> poly;
  final User user;
  const MapSample({Key? key, required this.poly, required this.user}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

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
    for (var i = 0; i<places.length; i++) {
      ids.add(places[i].stops);
    }
    setState(() {
      var n = (widget.poly.length/2).round();
      _goToMe(widget.poly[n].latitude, widget.poly[n].longitude);
    });

  }

  setMarkers(double _lat, double _lng){
    markers.add(Marker( //add second marker
      markerId: MarkerId(markers.length.toString()),
      position: LatLng(_lat, _lng), //position of marker
      infoWindow: const InfoWindow( //popup info
        title: 'My Custom Title ',
        snippet: 'My Custom Subtitle',
      ),
      icon: BitmapDescriptor.defaultMarker//Icon(Icons.location_on), //Icon for Marker
    ));

  }

  @override
  void initState() {
    super.initState();

    /*if(widget.poly.isNotEmpty){
      polylinesdef = widget.poly;
    }*/

    WidgetsBinding.instance
        ?.addPostFrameCallback((_) {
          getPlacesData();
          if(widget.poly != []){
            setPolylines(widget.poly);
            setMarkers(widget.poly.last.latitude, widget.poly.last.longitude);
          }
        });
    setState(() {

    });
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(18.472346, -69.918128),
    zoom: 16,
  );

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

  getNodeDirections(int from, int to) async {
    Map<String,int> nodes = {
      "id_from_node": from,
      "id_to_node": to
    };
    print(nodes);
    var path = await getGraphRoute(nodes);
    var path_info = Pathing.fromJson(json.decode(path.body)['shortest_path'][0]);
    polylinesdef = [];
    path_info.route_coordinates?.forEach((element) {
      polylinesdef.add(LatLng(element['coordinates'][0], element['coordinates'][1]));
      if(element['is_stop'] == true){
        setMarkers(element['coordinates'][0], element['coordinates'][1]);
      }
      print(element['coordinates']);
    });
    polylinesdef.forEach((element) {print(element);});
    setPolylines(polylinesdef);
    setMarkers(path_info.route_coordinates!.first['coordinates'][0], path_info.route_coordinates!.first['coordinates'][1]);
    setMarkers(path_info.route_coordinates!.last['coordinates'][0], path_info.route_coordinates!.last['coordinates'][1]);
    _goToMe(path_info.route_coordinates![0]['coordinates'][0],path_info.route_coordinates![0]['coordinates'][1]);
    fromController.clear();
    toController.clear();
    setState(() {    });
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
                        if(!_controller.isCompleted){
                          _controller.complete(controller);
                        }
                        getPlacesData();
                        LocationPermission permission = await Geolocator.requestPermission();
                      },
                      polylines: _polylines,
                      markers: markers,
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
                                      //var dropdownValue = ids[index].first;
                                      return Column(
                                        children: [
                                          Container(
                                              height: 120,
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
                                                        Text(
                                                          'DOP\$ '+items[index].price.toString(),
                                                          style: const TextStyle(color: Colors.white),
                                                        ),
                                                        Row(
                                                          children: [
                                                            const Text(
                                                              'Parada:',
                                                              style: TextStyle(color: Colors.white),
                                                            ),
                                                            const SizedBox(width: 5,),
                                                            DropdownButton(
                                                              //value: null,
                                                              icon: const Icon(Icons.arrow_downward),
                                                              menuMaxHeight: 300,
                                                              hint: Text('Select stop',style: TextStyle(color: Colors.white),),
                                                              elevation: 20,
                                                              style: const TextStyle(color: Color.fromRGBO(255, 80, 47, 1.0),),
                                                              underline: Container(
                                                                height: 2,
                                                                color: const Color.fromRGBO(255, 80, 47, 1.0),
                                                              ),
                                                              onChanged: (Object? newValue) {
                                                                markers.clear();
                                                                var position = ids[index]?.indexOf(newValue);
                                                                n=position!;
                                                                stop = ids[index]![position];
                                                                //print(stop.toString());
                                                                if(names.contains(fromController.text.split(',')[0])){
                                                                  toController.text = items[index].name! + ', '+ stop.toString();
                                                                  to_node = stop;
                                                                  getNodeDirections(from_node, to_node);
                                                                }
                                                                else {
                                                                  fromController.text = items[index].name! +', '+ stop.toString();
                                                                  from_node = stop;
                                                                }
                                                                getPlacesData();
                                                                setState(() {

                                                                });//Se puede mejorar
                                                                //print(stop.toString());
                                                              },
                                                              items: ids[index]!
                                                                  .map<DropdownMenuItem<int>>((dynamic value) {
                                                                    return DropdownMenuItem<int>(
                                                                      value: value,
                                                                      child: Text(value.toString()),
                                                                    );
                                                                  }).toList(),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    width: 150,
                                                  ),
                                                  Row(
                                                    children: [
                                                      FloatingActionButton(
                                                        onPressed: () async {
                                                          /*if(count == true){*/
                                                            var res = await getRoute(items[index].id!);
                                                            var tmp = jsonDecode(res.body.toString());
                                                            setMarkers(double.parse(tmp.first[0]), double.parse(tmp.first[1]));
                                                            setMarkers(double.parse(tmp.last[0]), double.parse(tmp.last[1]));
                                                            polylinesdef = tmp.map<LatLng>((e) => LatLng(double.parse(e[0]),double.parse(e[1]))).toList();
                                                            setPolylines(polylinesdef);
                                                            var n = (polylinesdef.length/2).round();
                                                            _goToMe(polylinesdef[n].latitude, polylinesdef[n].longitude);
                                                            setState(() {});
                                                            //print(count.toString());
                                                          /*}
                                                          else{
                                                            markers.clear();
                                                            polylinesdef.clear();
                                                            setState(() {});
                                                            count = true;
                                                            print(count.toString());
                                                          }*/
                                                        },
                                                        child: const FaIcon(FontAwesomeIcons.solidEye,size: 20,),
                                                        heroTag: index.toString(),
                                                        elevation: 0.0,
                                                        mini: true,
                                                        backgroundColor: const Color.fromRGBO(255, 80, 847, 1),
                                                      ),
                                                      FloatingActionButton(
                                                        onPressed: () async {
                                                          polylinesdef.clear();
                                                          markers.clear();
                                                          setState(() {});
                                                        },
                                                        child: const FaIcon(FontAwesomeIcons.solidEyeSlash, size: 20,),
                                                        heroTag: index.toString()+index.toString(),
                                                        elevation: 0.0,
                                                        mini: true,
                                                        backgroundColor: const Color.fromRGBO(255, 80, 847, 1),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          //),
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
                                      onTap: (){
                                        fromController.text = "";
                                        toController.text = "";
                                        from_node = 0;
                                        to_node = 0;
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
    _polylines.clear();
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

  Future<void> _goToMe(double _lat, double _lon) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(_lat,_lon),
        zoom: 11)));
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

