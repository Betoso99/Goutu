import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:goutu/models/user.dart';
import 'package:goutu/src/sub_views/profile_page.dart';
import 'package:goutu/widgets/destination_displayer.dart';

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
  //final Location location = Location();
  final Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(18.472346, -69.918128),
    zoom: 16,
  );

  static final CameraPosition _MyLoc = CameraPosition(
      target: LatLng(lat,lon),
      zoom: 16
  );


// this set will hold my markers
  //Set<Marker> _markers = {};

// this will hold the generated polylines
  Set<Polyline> _polylines = {};

// this will hold each polyline coordinate as Lat and Lng pairs
  List<LatLng> polylineCoordinates = [];

// this is the key object - the PolylinePoints
// which generates every polyline between start and finish
  PolylinePoints polylinePoints = PolylinePoints();

// for my custom icons
 /* BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;*/

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
      body: Stack(
        children: <Widget> [
          GoogleMap(
            myLocationEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) async {
              _controller.complete(controller);
              LocationPermission permission = await Geolocator.requestPermission();
              setPolylines();
              },
            polylines: _polylines,
            mapToolbarEnabled: true,
            buildingsEnabled: true,
            compassEnabled: true,
            myLocationButtonEnabled: true,
          ),
          Visibility(
              child: Display(user: widget.user,)
          ),
        ],
      ),
        floatingActionButton: Align(
          alignment: const Alignment(1, 0.65),
          child: FloatingActionButton(
            onPressed: (){
              getLocation();
              _goToMe();
            },
            child: const Icon(Icons.my_location),
          ),
        )
    );
  }

  setPolylines() async {

    setState(() {
      // create a Polyline instance
      // with an id, an RGB color and the list of LatLng pairs
      Polyline polyline = Polyline(
          polylineId: PolylineId("poly"),
          color: Color.fromARGB(255, 40, 122, 198),
          width: 5,
          points: widget.poly
      );

      // add the constructed polyline as a set of points
      // to the polyline set, which will eventually
      // end up showing up on the map
      _polylines.add(polyline);
    });
  }

  Future<void> _goToMe() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_MyLoc));
  }
}