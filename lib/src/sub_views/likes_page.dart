import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:goutu/models/places.dart';
import 'package:goutu/models/user.dart';
import 'package:goutu/src/views/info_page.dart';
import 'package:goutu/src/views/map_home_page.dart';

/*final List<Places> places = <Places>[
  Places(entries: 'Jardin Botanico', km: '1.5km', price: 'DOP 95', image: "https://images.visitarepublicadominicana.org/jardin-botanico-santo-domingo.jpg"),
  Places(entries: 'Marbella', km: '2.5km', price: 'DOP 120', image: "https://www.marbella-hills-homes.com/cms/wp-content/uploads/2020/12/1.jpg"),
  Places(entries: 'Los Tres Ojos', km: '1km', price: 'DOP 75', image: "https://images.visitarepublicadominicana.org/los-tres-ojos-santo-domingo.jpg"),
];*/

final List<Places> places = <Places>[];

final List<List<double>> polylinesarr = [
  [18.472425, -69.926299],
  [18.470187, -69.931642],
  [18.468640, -69.926063]
];

final polylinesdef = polylinesarr.map((e) => LatLng(e[0],e[1])).toList();

class LikesPage extends StatefulWidget {
  final User user;
  const LikesPage({Key? key, required this.user}) : super(key: key);

  @override
  _LikesPage createState() => _LikesPage();
}

class _LikesPage extends State<LikesPage> {
  @override
  void initState(){
    super.initState();

  }
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Likes Page'),
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
                )),
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
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const SizedBox(width: 10),
                            Container(
                              width: 80,
                              height: 70,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(places[index].id.toString()),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                Text(
                                  places[index].name.toString(),
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
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                     MapSample(poly: polylinesdef, user: widget.user,)));
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
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const InfoPage()),
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
                                      onTap: () {
                                        //Delete from list
                                        places.removeAt(index);
                                        setState(() {});
                                        //initState();
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
