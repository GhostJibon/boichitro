import 'package:dhanshirisapp/screen/book_screen/about_book.dart';
import 'package:dhanshirisapp/screen/book_screen/book_review.dart';
import 'package:dhanshirisapp/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sizer/sizer.dart';

class ModalTabBar extends StatefulWidget {
  final bookdetails;
  late String aboutNote;
  ModalTabBar({required this.aboutNote, required this.bookdetails});

  @override
  State<ModalTabBar> createState() => _ModalTabBarState();
}

class _ModalTabBarState extends State<ModalTabBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 51.0.h,
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
                          height: 44.0.h, //height of TabBarView
                          decoration: BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                      color: Colors.grey, width: 0.5))),
                          child: TabBarView(children: <Widget>[
                            Container(
                                child: AboutBook(
                              aboutNote: widget.aboutNote,
                            )),
                            Container(
                              child: BookReview(widget.bookdetails.pk),
                            ),
                          ]))
                    ])),
          ]),
    );
  }
}
