import 'package:flutter/material.dart';

Widget buildPopupDialog(BuildContext context) {
  return AlertDialog(

    title: const Text('Ha ocurrido un error'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text("Algun dato ingresado es erroneo"),
      ],
    ),
    actions: <Widget>[
      FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: const Color.fromRGBO(255, 80, 47, 1.0),
        child: const Text('Close'),
      ),
    ],
  );
}

Widget registerdPopupDialog(BuildContext context) {
  return AlertDialog(

    title: const Text('Ha ocurrido un error'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text("Alguno de sus datos no satisface los requisitos"),
      ],
    ),
    actions: <Widget>[
      FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: const Color.fromRGBO(255, 80, 47, 1.0),
        child: const Text('Close'),
      ),
    ],
  );
}