import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LineBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 1.0.h,
      width: 100.0.w,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Color(0xfffdfbfc),
          // Color(0xffd3b6b6),
          Colors.grey
        ],
      )),
    );
  }
}
