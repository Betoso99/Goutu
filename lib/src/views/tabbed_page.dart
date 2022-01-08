import 'package:flutter/material.dart';
import 'package:goutu/models/user.dart';
import 'package:goutu/src/sub_views/likes_page.dart';
import 'package:goutu/src/sub_views/new_home_page.dart';
import 'package:goutu/src/sub_views/profile_page.dart';
import 'package:goutu/widgets/tabbed_widget.dart';

/*
void main() => runApp(Tabbed(user: ,));
*/

class Tabbed extends StatelessWidget {
  final User user;
  const Tabbed({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          bottomNavigationBar: menu(),
          body: TabBarView(
            children: [
              NewHomePage(user: user,),
              LikesPage(user: user,),
              ProfilePage(user: user,),
            ],
          ),
          backgroundColor: const Color.fromRGBO(16, 16, 20, 1),
        ),
      ),
    );
  }
}