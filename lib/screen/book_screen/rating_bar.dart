import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:dhanshirisapp/provider/deshboard.dart';
import 'package:dhanshirisapp/screen/book_api_call.dart';
import 'package:dhanshirisapp/screen/book_read_screen.dart';
import 'package:dhanshirisapp/screen/bookdetails.dart';
import 'package:dhanshirisapp/translations/locale_keys.g.dart';
import 'package:dhanshirisapp/widget/popup_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

class RatingBarWithText extends StatelessWidget {
  var rating;

  RatingBarWithText({required this.rating});
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        height: 3.1.h,
        width: 25.0.w,
        child: Text(
          LocaleKeys.rating.tr(),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 1.5.h),
        ),
      ),
      Container(
          height: 3.1.h,
          width: 30.0.w,
          margin: EdgeInsets.only(bottom: 1.4.h),
          child: RatingBarIndicator(
              rating: double.parse(rating.bookdetails.rating.toString()),
              itemBuilder: (context, index) => Icon(
                    Icons.star,
                    // color: Colors.amber,
                  ),
              itemCount: 5,
              itemSize: 17.0,
              direction: Axis.horizontal)),
    ]);
  }
}
