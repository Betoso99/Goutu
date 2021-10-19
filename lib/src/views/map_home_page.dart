import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:goutu/src/sub_views/profile_page.dart';
import 'package:goutu/widgets/destination_displayer.dart';

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
        backgroundColor: const Color.fromRGBO(16, 16, 20, 1),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0, top: 12, bottom: 12),
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfilePage())
                );
              },
              child: Container(
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 30,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0),
                    color: const Color.fromRGBO(255, 80, 847, 1),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
            GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          const Visibility(
              child: Display()
          ),
        ],
      ),
    );
  }
}


// floatingActionButton: FloatingActionButton.extended(
//   onPressed: _goToTheLake,
//   label: const Text('To the lake!'),
//   icon: const Icon(Icons.directions_boat),
// ),

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }
