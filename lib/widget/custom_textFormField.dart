import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomTextFormField extends StatelessWidget {
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  const CustomTextFormField({required this.onChanged, required this.validator});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(left: 10.0.w, right: 10.0.w),
      height: 5.5.h,
      width: 80.0.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(40)),
        border: Border.all(color: Color(0xffb8242a), width: 0.2.h),
      ),
      child: TextFormField(
        onChanged: onChanged,
        validator: validator,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 5.0.w, right: 4.0.w),
          border: InputBorder.none,
        ),
        style: TextStyle(color: Color(0xffb8242a), fontSize: 2.0.h),
      ),
    );
  }
}
