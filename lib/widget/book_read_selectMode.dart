import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BookReadSelectMode extends StatelessWidget {
  final Function()? onTap;
  Color boxColor;
  bool iconactive;
  BookReadSelectMode({
    required this.onTap,
    required this.boxColor,
    required this.iconactive,
  });
  build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 4.0.h,
          margin: EdgeInsets.only(
              left: 2.0.w, right: 2.0.w, top: .5.h, bottom: .50.h),
          decoration: BoxDecoration(
              color: boxColor,
              shape: BoxShape.circle,
              border: Border.all(width: 1, color: Colors.blue)),
          child: Center(
            child: iconactive == true
                ? Icon(
                    Icons.done_rounded,
                  )
                : Container(),
          ),
        ),
      ),
    );
  }
}
