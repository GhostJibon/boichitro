import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PriceCart extends StatelessWidget {
  final bool ischeck;
  final Function()? onTap;
  PriceCart({required this.ischeck, required this.onTap});
  build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          margin: EdgeInsets.only(left: 05.0.w, right: 05.0.w),
          width: 70.0.w,
          height: 6.0.h,
          decoration: BoxDecoration(
            color: ischeck == true ? Color(0xffb8242a) : Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 2, color: Color(0xffb8242a)),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                    margin: EdgeInsets.only(
                        left: 05.0.w,
                        top: 02.0.h,
                        bottom: 02.0.h,
                        right: 3.0.w),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          width: 2,
                          color: Color(0xffb8242a),
                        ),
                        shape: BoxShape.circle),
                    child: Center(
                      child: Icon(
                        Icons.done_rounded,
                        size: 10,
                        color:
                            ischeck == true ? Color(0xffb8242a) : Colors.white,
                      ),
                    )),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                          alignment: Alignment.bottomLeft,
                          child: AutoSizeText('৳100.99 / One Years',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ischeck != true
                                    ? Color(0xffb8242a)
                                    : Colors.white,
                              ))),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                          alignment: Alignment.topLeft,
                          child: AutoSizeText('Forever access',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: ischeck != true
                                    ? Color(0xffb8242a)
                                    : Colors.white,
                              ))),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
