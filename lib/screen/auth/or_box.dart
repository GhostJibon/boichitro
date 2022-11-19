import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class OrBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        height: 05.0.h,
        margin: EdgeInsets.only(left: 10.0.w, right: 10.0.w),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.only(top: 2.4.h, bottom: 2.4.h)),
            ),
            Expanded(
                flex: 1,
                child: Center(
                    child: Text('Or', style: TextStyle(color: Colors.red)))),
            Expanded(
              flex: 3,
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.only(top: 2.4.h, bottom: 2.4.h)),
            ),
          ],
        ));
  }
}
