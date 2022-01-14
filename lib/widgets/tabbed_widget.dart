import 'package:flutter/material.dart';

Widget menu() {
  return Container(
    decoration: const BoxDecoration(
        color:  Color.fromRGBO(16, 16, 20, 1),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(10, 10, 10, 1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          )
        ]
    ),
    child: const TabBar(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white70,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorPadding: EdgeInsets.all(5.0),
      indicatorColor: Colors.blue,
      tabs: [
        Tab(
          text: "Spots",
          icon: Icon(Icons.house),
        ),
        Tab(
          text: "Likes",
          icon: Icon(Icons.save_alt),
        ),
        Tab(
          text: "Profile",
          icon: Icon(Icons.person),
        ),
      ],
    ),
  );
}

