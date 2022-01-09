import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goutu/models/places.dart';
import 'package:goutu/models/user.dart';

final List<Places> places = <Places>[
  Places(price: '841',description: 'Un buen lugar',name: 'Mi casa'),
  Places(price: '987',description: 'Un mal lugar',name: 'Tu casa'),
];
const _googleMapsImage = 'https://miro.medium.com/max/4064/1*qYUvh-EtES8dtgKiBRiLsA.png';


class Display extends StatefulWidget {
  final User user;
  const Display({Key? key, required this.user}) : super(key: key);

  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  double _percent = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              bottom: MediaQuery.of(context).size.height * 0.3,
              child: Image.network(
                _googleMapsImage,
                fit: BoxFit.cover,
              ),
            ),

            Positioned.fill(
              child: NotificationListener<DraggableScrollableNotification>(
                onNotification: (notification) {
                  print(notification.extent);
                  setState(() {
                    _percent = 2 * notification.extent - 0.6;
                  });
                  return true;
                },
                child: DraggableScrollableSheet(
                  maxChildSize: 0.8,
                  minChildSize: 0.3,
                  initialChildSize: 0.3,
                  builder: (_, controller) {
                    return Material(
                      elevation: 10,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      color: const Color.fromRGBO(16, 16, 20, 1),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
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
                            /*Text(
                              'It\'s good to see you',
                              style: TextStyle(color: Colors.grey, fontSize: 13),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Where are you going?',
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            const SizedBox(height: 25),
                            TextField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.purple[300],
                                ),
                                hintText: 'Search destination',
                              ),
                            ),*/
                            Expanded(
                              child: ListView.builder(
                                padding: const EdgeInsets.all(15),
                                itemCount: places.length,
                                controller: controller,
                                itemBuilder: (BuildContext context, int index,) {
                                  return Column(
                                    children: [
                                        Container(
                                          height: 80,
                                          color: Colors.white12,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                            GestureDetector(
                                              onTap: () async {
                                                /*Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => MapSample(poly: polylinesdef, user: widget.user,)));
                                              */},
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 80,
                                                    child: const Icon(Icons.location_on_outlined, color: Colors.white,),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        places[index].name.toString(),
                                                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Text(
                                                        places[index].description.toString(),
                                                        style: const TextStyle(color: Colors.white),
                                                      ),
                                                      Text(
                                                        'DOP\$ '+places[index].price.toString(),
                                                        style: const TextStyle(color: Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 5,)
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
                child: _SearchDestination(),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: -50 * (1 - _percent),
              child: Opacity(
                opacity: _percent,
                child: _PickPlaceInMap(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PickPlaceInMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.place_sharp, color: Colors.grey),
            SizedBox(width: 10),
            Text('Pick in the map'),
          ],
        ),
      ),
    );
  }
}

class _SearchDestination extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      color: Color.fromRGBO(16, 16, 20, 1),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
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
                      onTap: () async {
                        /*Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  Tabbed(user: user,) // Tener en cuenta
                            ),
                          );*/
                      },
                      //controller: fromController,
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
                      onTap: () async {
                        /*Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  Tabbed(user: user,) // Tener en cuenta
                            ),
                          );*/
                      },
                      //controller: toController,
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
    );
  }
}