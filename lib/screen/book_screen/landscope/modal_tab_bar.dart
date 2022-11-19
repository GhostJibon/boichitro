import 'package:dhanshirisapp/screen/book_screen/about_book.dart';
import 'package:dhanshirisapp/screen/book_screen/book_review.dart';
import 'package:dhanshirisapp/screen/book_screen/landscope/about_book.dart';
import 'package:dhanshirisapp/screen/book_screen/landscope/book_review.dart';
import 'package:dhanshirisapp/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sizer/sizer.dart';

class ModalTabBarLandscape extends StatefulWidget {
  final bookdetails;
  late String aboutNote;
  ModalTabBarLandscape({required this.aboutNote, required this.bookdetails});

  @override
  State<ModalTabBarLandscape> createState() => _ModalTabBarState();
}

class _ModalTabBarState extends State<ModalTabBarLandscape> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //  SizedBox(height: 20.0),
            DefaultTabController(
                length: 2, // length of tabs
                initialIndex: 0,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        child: TabBar(
                          // labelColor: Colors.green,
                          //    unselectedLabelColor: Colors.black,
                          tabs: [
                            Tab(
                              text: LocaleKeys.aboutbook.tr(),
                            ),
                            Tab(
                              text: LocaleKeys.review.tr(),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          height: 30.0.h, //height of TabBarView
                          decoration: BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                      color: Colors.grey, width: 0.5))),
                          child: TabBarView(children: <Widget>[
                            Container(
                                child: AboutBookLandscope(
                              aboutNote: widget.aboutNote,
                            )),
                            Container(
                              child: BookReviewLandscope(widget.bookdetails.pk),
                            ),
                          ]))
                    ])),
          ]),
    );
  }
}
