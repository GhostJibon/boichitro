import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProfileBox extends StatelessWidget {
  final Function()? onTap;
  final String name;
  final IconData icon;
  //final Color color;
  ProfileBox({
    required this.name,
    required this.onTap,
    required this.icon,
    // required this.color
  });
  build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(children: [
        Container(
            decoration: BoxDecoration(
                // color: Color(0xffc60e13),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      //color: Colors.black12,
                      offset: Offset.zero,
                      blurRadius: 2,
                      spreadRadius: 3)
                ]),
            height: 10.0.h,
            width: 29.0.w,
            // child: CircleAvatar(
            //     backgroundColor: Color(0xFFe5e5e5),
            //     radius: 4.5.h,
            child: Icon(icon, size: 5.0.h)
            //)

            ),
        SizedBox(
          height: 0.5.h,
        ),
        Container(
            alignment: Alignment.centerLeft,
            child: Center(
                child: Text(
              name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 1.8.h),
            )))
      ]),
    );
  }
}
