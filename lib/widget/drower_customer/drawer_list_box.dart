import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DrawerListBox extends StatelessWidget {
  final String? title;
  final void Function()? onTap;
  final String image;
  DrawerListBox(
      {required this.title, required this.onTap, required this.image});
  build(BuildContext context) {
    return Expanded(
      flex: 3,
      // height: 4.0.h,
      child: Container(
        color: Color(0xffd3b6b6),
        padding: EdgeInsets.only(left: 04.0.w),
        child: new ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(0xffd3b6b6),
              child: Image(image: AssetImage(image)),
            ),
            title: new Text(title.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 12.0.sp)),
            onTap: onTap),
      ),
    );
  }
}
