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
    target: LatLng(18.472252, -69.917956),
    zoom: 16,
  );

  static const CameraPosition _kLake = CameraPosition(
      target: LatLng(18.488562,-69.972038),
      zoom: 16);

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
                  MaterialPageRoute(builder: (context) => const ProfilePage())
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
                    color: const Color.fromRGBO(255, 80, 847, 1)),
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
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          const Visibility(
              child: Display()
          ),
        ],
      ),
      floatingActionButton: Align(
        alignment: const Alignment(1, 0.65),
        child: FloatingActionButton(
          onPressed: _goToMe,
          child: const Icon(Icons.my_location),
          //backgroundColor: const Color.fromRGBO(16, 16, 16, 0),
        ),
      )
      //floatingActionButtonLocation: FloatingActionButtonLocation.,
    );
  }

  Future<void> _goToMe() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}