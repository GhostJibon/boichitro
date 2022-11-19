import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dhanshirisapp/screen/book_screen/modal_tab_bar.dart';
import 'package:dhanshirisapp/screen/book_screen/rating_bar.dart';
import 'package:dhanshirisapp/provider/deshboard.dart';
import 'package:dhanshirisapp/screen/book_api_call.dart';
import 'package:dhanshirisapp/screen/book_read_screen.dart';
import 'package:dhanshirisapp/screen/bookdetails.dart';
import 'package:dhanshirisapp/translations/locale_keys.g.dart';
import 'package:dhanshirisapp/widget/popup_Screen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:dhanshirisapp/screen/book_screen/rating_bar.dart';
import 'package:dhanshirisapp/screen/book_screen/modal_tab_bar.dart';

class AboutBookLandscope extends StatelessWidget {
  late String aboutNote;

  AboutBookLandscope({required aboutNote}) {
    this.aboutNote = aboutNote;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 5.0.w,
        right: 5.0.w,
        top: 1.5.h,
      ),
      alignment: Alignment.centerLeft,
      height: 50.0.h,
      // child: SingleChildScrollView(
      //   scrollDirection: Axis.vertical,
      child: Column(children: [
        // SizedBox(
        //   height: 2.h,
        // ),
        Container(
          height: 25.0.h,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              Text(
                aboutNote,
                textAlign: TextAlign.justify,
                style:
                    TextStyle(fontSize: 1.5.h, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),

        // SizedBox(
        //   height: 20.h,
        // ),
      ]),
      //),
    );
  }
}
