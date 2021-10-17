import 'package:flutter/material.dart';
import 'package:goutu/src/sub_views/profile_page.dart';
import 'package:goutu/widgets/tabbed_widget.dart';

void main() => runApp(const Tabbed());

class Tabbed extends StatelessWidget {
  const Tabbed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          bottomNavigationBar: menu(),
          body: const TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
              ProfilePage(),
            ],
          ),
          backgroundColor: const Color.fromRGBO(16, 16, 20, 1),
        ),
      ),
    );
  }
}