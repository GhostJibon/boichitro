import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HistoryProfileImgName extends StatelessWidget {
  final String image;
  final String first_name;
  final String last_name;
  final String email;
  HistoryProfileImgName(
      {required this.first_name,
      required this.image,
      required this.last_name,
      required this.email});
  build(BuildContext context) {
    return Column(
      children: [
        Container(
            alignment: Alignment.centerLeft,
            height: 3.5.h,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '$first_name $last_name',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            )),
        Container(
            alignment: Alignment.centerLeft,
            height: 3.5.h,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                email,
                maxLines: 1,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            )),
      ],
    );
  }
}
