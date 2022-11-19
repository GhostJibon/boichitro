import 'package:dhanshirisapp/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

class TitleNameWithButton extends StatelessWidget {
  final String title;
  final Function()? ontap;
  TitleNameWithButton({required this.title, required this.ontap});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 05.0.w, right: 05.0.w, top: 1.0.h),
      child: Row(
        children: [
          Container(
            //  color: Colors.red,
            width: 75.0.w,
            child: Text(
              // "Recent",
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 2.0.h,
                //  color: Colors.black
              ),
            ),
          ),
          GestureDetector(
            onTap: ontap,
            child: Container(
              // color: Colors.blue,
              width: 15.0.w,
              child: Text(
                'View All',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 1.5.h,
                  //  color: Colors.black
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
