import 'package:flutter/material.dart';

class DialogClass {
  static Future<dynamic> confirmDialog(BuildContext context, message) async {
    showDialog(
        // barrierColor: Color(0xFFdab13c),
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xFFefe7dc),
            title: Text(
              'An error Occurred',
            ),
            content: Text(
              message,
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
