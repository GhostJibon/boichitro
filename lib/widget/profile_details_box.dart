import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProfileDetailsBox extends StatelessWidget {
  final String titlename;
  final String name;
  final IconData icon;
  ProfileDetailsBox(
      {required this.titlename, required this.name, required this.icon});
  build(BuildContext context) {
    return Expanded(
        flex: 4,
        child: Container(
          margin: EdgeInsets.only(left: 8.0.w, right: 8.0.w),
          padding: EdgeInsets.only(
              left: 2.0.w, right: 2.0.w, top: 0.5.h, bottom: 1.0.h),
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                    blurRadius: 2,
                    color: Colors.black12,
                    offset: Offset.zero,
                    spreadRadius: 3),
              ]),
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Row(children: [
                    Expanded(
                      flex: 1,
                      child: Icon(icon),
                    ),
                    SizedBox(width: 2.0.w),
                    Expanded(
                        flex: 6,
                        child: Text(titlename,
                            style: TextStyle(
                                fontSize: 1.5.h, fontWeight: FontWeight.bold)))
                  ])),
              Expanded(
                  flex: 1,
                  child: Row(children: [
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    SizedBox(width: 2.0.w),
                    Expanded(
                        flex: 6,
                        child: Text(name,
                            style: TextStyle(
                                fontSize: 2.1.h, fontWeight: FontWeight.bold)))
                  ])),
            ],
          ),
        ));
  }
}
