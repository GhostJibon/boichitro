import 'package:flutter/material.dart';

class DialogLoaderClass {
  static Future<dynamic> confirmDialog(BuildContext context, message) async {
    showDialog(
        // barrierColor: Color(0xFFdab13c),
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xFFefe7dc),
            content: Text('Loading ...'),

            // actions: <Widget>[
            //   FlatButton(
            //     child: Text('Ok'),
            //     onPressed: () {
            //       Navigator.of(context).pop();
            //     },
            //   )
            // ],
          );
        });
  }
}
