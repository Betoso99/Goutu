import 'package:flutter/material.dart';
import 'package:goutu/src/sub_views/new_home_page.dart';
import 'package:goutu/src/views/tabbed_page.dart';

class Display extends StatelessWidget {
  const Display({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (DragUpdateDetails drag) {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Tabbed())
        );
      },
        child: DraggableScrollableSheet(
          initialChildSize: 0.20,
          minChildSize: 0.20,
          builder: (BuildContext context, myScrollerController) {
            return Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(16, 16, 20, 1),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                boxShadow: [
                  BoxShadow(color: Colors.grey, offset: Offset(3, 2), blurRadius: 7)
                ],
              ),
              child: ListView(
                controller: myScrollerController,
                children: [
                  const Icon(
                    Icons.remove,
                    size: 40,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
                    child: Container(
                      color: Colors.grey,
                      child: TextField(
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  const Tabbed() // Tener en cuenta
                            ),
                          );
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
                ],
              ),
            );
          },
        ),
    );

  }
}
