import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HistoryCart extends StatelessWidget {
  final data;
  HistoryCart(this.data);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(05),
        color: Colors.grey[300],
      ),
      margin: EdgeInsets.only(left: 5.0.w, right: 5.0.w, bottom: 1.0.h),
      padding: EdgeInsets.only(left: 05.0.w, right: 05.0.w),
      height: 5.0.h,
      width: 100.0.w,
      alignment: Alignment.centerLeft,
      child: Text(
        // 'Boicitro',
        data.book_name.toString(),
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
