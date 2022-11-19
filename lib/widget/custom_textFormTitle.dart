import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomTextFormTitle extends StatelessWidget {
  final String titlename;
  CustomTextFormTitle({required this.titlename});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      // color: Colors.red,
      width: 100.0.w,
      height: 04.5.h,
      padding: EdgeInsets.only(left: 10.0.w),
      child: Text(
        titlename,
        style: TextStyle(color: Color(0xffb8242a), fontSize: 2.5.h),
      ),
    );
  }
}
