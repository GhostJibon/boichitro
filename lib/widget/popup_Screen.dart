import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PopUpScreen extends StatelessWidget {
  final String title;
  final String name;
  PopUpScreen({required this.name, required this.title});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: Row(
      children: [
        Container(
          height: 3.6.h,
          width: 25.0.w,
          child: Text(
            name,
            style: TextStyle(
                //color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 1.5.h),
          ),
        ),
        Container(
          height: 3.6.h,
          width: 30.0.w,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              title,
              style: TextStyle(
                  //  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 1.5.h),
            ),
          ),
        ),
      ],
    ));
  }
}
