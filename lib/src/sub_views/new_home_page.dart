import 'package:flutter/material.dart';

class NewHomePage extends StatefulWidget {
  const NewHomePage({Key? key}) : super(key: key);

  @override
  _NewHomePage createState() => _NewHomePage();
}

class _NewHomePage extends State<NewHomePage> {
  //final List<>
  final List<String> entries = <String>['Jardin Botanico', 'Marbella', ''];
  final List<int> colorCodes = <int>[600, 500, 100];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Home Page'),
            backgroundColor: const Color.fromRGBO(16, 16, 20, 1),
          ),
          body: ListView.separated(
            padding: const EdgeInsets.all(15),
            itemCount: entries.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 50,
                color: Colors.white12,
                child: Center(child: Text(entries[index])),
              );
            },
            separatorBuilder: (
                BuildContext context,
                int index
                ) => const Divider(
              height: 15,

            ),
          ),
          backgroundColor: const Color.fromRGBO(16, 16, 20, 1),
      ),
    );
  }
}
