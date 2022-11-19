import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sizer/sizer.dart';

class ProfileListButton extends StatelessWidget {
  final Color boxcolor;
  final Function()? onTap;
  final IconData icon;
  final String title;

  ProfileListButton(
      {required this.icon,
      required this.onTap,
      required this.title,
      required this.boxcolor});
  build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 1.0.h, top: 1.0.h),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              blurRadius: 2,
              color: Colors.grey,
              spreadRadius: 2,
              offset: Offset(0, 2))
        ]),
        child: Row(
          children: [
            Container(
                padding: EdgeInsets.only(left: 3.0.w),
                height: 5.0.h,
                child: CircleAvatar(
                    backgroundColor: boxcolor,
                    radius: 2.0.h,
                    child: ClipOval(
                      child: Icon(icon, size: 2.0.h, color: Colors.white),
                    ))),
            Container(
                height: 5.0.h,
                padding: EdgeInsets.only(left: 05.0.w),
                alignment: Alignment.centerLeft,
                child: Text(title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 2.0.h)))
          ],
        ),
      ),
    );
  }
}
