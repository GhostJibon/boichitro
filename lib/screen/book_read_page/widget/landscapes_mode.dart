import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../db/history_data.dart';
import '../../../db/history_database.dart';
import '../../../provider/book_read.dart';
import '../../../provider/highlight.dart';
import '../../../provider/order.dart';
import '../../../translations/locale_keys.g.dart';
import '../../../widget/book_read_selectMode.dart';
import '../../../widget/debouncer.dart';
import '../../../widget/page_manager.dart';
import 'book_read_page_card.dart';

class LandscapesMode extends StatefulWidget {
  BookReadtModel bookpagemodel;
  HighlightProvider highlight;
  bool ischeck;
  String? book_name;
  bool ischeck_white;
  bool ischeck_read;
  bool ischeck_black;
  PageController pageController;
  Function? addOrUpdateNote;
  int pagenumber;
  String fontfamilys;
  int? start;
  int? end;
  bool pagecheck;
  bool mode;
  bool fontmode;
  List font;
  GlobalKey<ScaffoldState> scaffoldKey;
  bool audiomode;

  LandscapesMode({
    required this.bookpagemodel,
    required this.highlight,
    required this.ischeck,
    required this.book_name,
    required this.ischeck_white,
    required this.ischeck_read,
    required this.ischeck_black,
    required this.pageController,
    required this.addOrUpdateNote,
    required this.pagenumber,
    required this.fontfamilys,
    required this.start,
    required this.end,
    required this.pagecheck,
    required this.mode,
    required this.fontmode,
    required this.font,
    required this.scaffoldKey,
    required this.audiomode,
  });

  @override
  State<LandscapesMode> createState() => _LandscapesModeState();
}

class _LandscapesModeState extends State<LandscapesMode>
    with WidgetsBindingObserver {
  Widget build(BuildContext context) {
    // BookReadtModel bookpagemodel =
    //     Provider.of<BookReadtModel>(context, listen: false);
    // HighlightProvider highlight =
    //     Provider.of<HighlightProvider>(context, listen: false);
    return SingleChildScrollView(
      child: Column(children: [
        widget.ischeck == false
            ? Container(
                padding: EdgeInsets.only(top: 5.0.h),
                height: 10.0.h,
                color: Color(0xffb8242a),
                child: Center(
                  child: Text(
                    widget.book_name!,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            : Container(),
        InkWell(
          onDoubleTap: () {
            setState(() {
              widget.ischeck = !widget.ischeck;
              if (widget.ischeck == false) {
                // _currentSliderValue = 13;
              } else {
                // _currentSliderValue = 15;
              }
            });
          },
          child: Stack(
            children: [
              Container(
                height: widget.ischeck == false ? 30.50.h : 50.0.h,
                //width: 300.0.w,
                padding: EdgeInsets.only(
                    top: widget.ischeck == false ? .50.h : 2.0.h),
                color: widget.ischeck_white == true
                    ? Colors.white
                    : widget.ischeck_read == true
                        ? Color(0xFFF4ECD8)
                        : widget.ischeck_black == true
                            ? Colors.grey.shade900
                            : Colors.white,
                alignment: Alignment.topLeft,
                child: PageView.builder(
                    //  controller: _controller,

                    scrollDirection: Axis.horizontal,
                    controller: widget.pageController,
                    onPageChanged: (page) async {
                      widget.addOrUpdateNote!();
                      setState(() {
                        widget.pagenumber = page + 1;
                      });
                    },
                    itemCount: widget.bookpagemodel.BookPage!.length,
                    itemBuilder: (ctx, i) {
                      // print('this is data 1');
                      // // print(i);
                      // pagenumber = i + 1;
                      // print('page number ');
                      // print(i);
                      var book = widget.bookpagemodel.BookPage![i];
                      return BookReadPageCardWidget(
                        book: book.page,
                        fontfamily: widget.fontfamilys,
                        ischeck_black: widget.ischeck_black,
                        ischeck_read: widget.ischeck_read,
                        ischeck_white: widget.ischeck_white,
                        highlight: widget.highlight,
                        pagenumber: i, //index
                        start: widget.start,
                        end: widget.end,
                      );
                    }),
                //  ),
              ),
              Positioned(
                  top: widget.ischeck == false ? 15.0.h : 25.0.h,
                  left: .5.h,
                  child: Center(
                    child: IconButton(
                        onPressed: () {
                          if (widget.pagenumber > 1 &&
                              widget.bookpagemodel.BookPage!.length >
                                  widget.pagenumber) {
                            widget.pageController.animateToPage(
                                widget.pagenumber - 1 - 1,
                                duration: Duration(milliseconds: 400),
                                curve: Curves.easeIn);
                          } else {
                            print('pagenumber over');
                            // _pageController.animateToPage(
                            //     int.parse(value) - 1,
                            //     duration:
                            //         Duration(milliseconds: 400),
                            //     curve: Curves.easeIn);
                          }
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 5.0.h,
                          color: Colors.black,
                        )),
                  )),
              Positioned(
                  top: widget.ischeck == false ? 15.0.h : 25.0.h,
                  right: .5.h,
                  child: Center(
                    child: IconButton(
                        onPressed: () {
                          if (widget.pagenumber >= 0 &&
                              widget.bookpagemodel.BookPage!.length >
                                  widget.pagenumber) {
                            widget.pageController.animateToPage(
                                widget.pagenumber + 1 - 1,
                                duration: Duration(milliseconds: 400),
                                curve: Curves.easeIn);
                          } else {
                            print('pagenumber over');
                            // _pageController.animateToPage(
                            //     int.parse(value) - 1,
                            //     duration:
                            //         Duration(milliseconds: 400),
                            //     curve: Curves.easeIn);
                          }
                        },
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          size: 5.0.h,
                          color: Colors.black,
                        )),
                  )),
            ],
          ),
        ),
        widget.ischeck == false
            ? Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      blurRadius: 2,
                      spreadRadius: 2,
                      color: Colors.black26,
                      offset: Offset(0.1, 0.3))
                ]),
                height: 10.0.h,
                child: Column(
                  children: [
                    // Container(
                    //   height: 10.0.h,
                    //   color: Colors.blue,
                    // ),
//---page number count ------
                    widget.pagecheck == false
                        ? Container(
                            margin: EdgeInsets.only(left: 15.0.w),
                            height: 5.0.h,
                            child: Row(
                              children: [
                                Container(
                                    child: Text(
                                  LocaleKeys.page_search.tr(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 1.5.h),
                                )),
                                SizedBox(width: 2.0.w),
                                Container(
                                    width: 15.0.w,
                                    height: 3.0.h,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 1.6.h,
                                      ),

                                      // keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                        enabled: true,
                                        contentPadding: const EdgeInsets.only(
                                            top: 1.0,
                                            bottom: 1.0,
                                            left: 10.0,
                                            right: 10.0),
                                        border: OutlineInputBorder(
                                          gapPadding: 10,
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(05.0),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(05.0),
                                          borderSide: BorderSide(
                                            color: Color(0xFFdab13c),
                                            width: 2.0,
                                          ),
                                        ),
                                      ),

                                      onChanged: (value) {
                                        if (value.isEmpty) {
                                          widget.pageController.animateToPage(
                                              int.parse('1') - 1,
                                              duration:
                                                  Duration(milliseconds: 400),
                                              curve: Curves.easeIn);
                                        } else if (widget.bookpagemodel
                                                .BookPage!.length >=
                                            int.parse(value)) {
                                          widget.pageController.animateToPage(
                                              int.parse(value) - 1,
                                              duration:
                                                  Duration(milliseconds: 400),
                                              curve: Curves.easeIn);
                                        }
                                      },
                                    )),
                                SizedBox(
                                  width: 15.0.w,
                                ),
                                Center(
                                  child: Text(
                                    '${LocaleKeys.page_number.tr()}: ${widget.pagenumber}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 1.0.h),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
//----brightness and mode ----
                    widget.mode == true
                        ? Container(
                            height: 5.0.h,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 60.0.w, right: 60.0.w),
                                  child: Row(
                                    children: [
                                      BookReadSelectMode(
                                        onTap: () {
                                          setState(() {
                                            widget.ischeck_white = true;
                                            widget.ischeck_read = false;
                                            widget.ischeck_black = false;
                                          });
                                        },
                                        boxColor: Colors.white,
                                        iconactive: widget.ischeck_white,
                                      ),
                                      BookReadSelectMode(
                                        onTap: () {
                                          setState(() {
                                            widget.ischeck_white = false;
                                            widget.ischeck_read = true;
                                            widget.ischeck_black = false;
                                          });
                                        },
                                        boxColor: Color(0xFFF4ECD8),
                                        iconactive: widget.ischeck_read,
                                      ),
                                      BookReadSelectMode(
                                        onTap: () {
                                          setState(() {
                                            widget.ischeck_white = false;
                                            widget.ischeck_read = false;
                                            widget.ischeck_black = true;
                                          });
                                        },
                                        boxColor: Colors.grey.shade900,
                                        iconactive: widget.ischeck_black,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ))
                        : Container(height: 0.0.h),
                    // ------------------------ FontStyle ------------------

                    widget.fontmode == true
                        ? Container(
                            height: 5.0.h,
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(top: 1.0.h),
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.font.length,
                                itemBuilder: (context, index) {
                                  var fontname = widget.font[index];
                                  return InkWell(
                                      onTap: () {
                                        setState(() {
                                          widget.fontfamilys = fontname;
                                        });
                                      },
                                      child: Container(
                                        color: Colors.white,
                                        height: 3.0.h,
                                        width: 35.0.w,
                                        child: Center(
                                          child: Container(
                                            child: AutoSizeText(fontname,
                                                style: TextStyle(
                                                    color: fontname ==
                                                            widget.fontfamilys
                                                        ? Colors.red
                                                        : Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ),
                                      ));
                                }))
                        : Container(height: 0.0.h),
                    Container(
                      height: 4.0.h,
                      child: Row(
                        children: [
                          //--------------- App Drawer --------------
                          Expanded(
                              flex: 1,
                              child: IconButton(
                                  icon: Icon(Icons.menu_sharp,
                                      color: Colors.black),
                                  onPressed: () {
                                    print('data is here');
                                    widget.scaffoldKey.currentState
                                        ?.openDrawer();
                                  })),
                          //-------------- page ----------
                          Expanded(
                              flex: 1,
                              child: IconButton(
                                  icon: Icon(Icons.pageview_sharp,
                                      color: Colors.black),
                                  onPressed: () {
                                    setState(() {
                                      widget.pagecheck = false;
                                      widget.mode = false;
                                      widget.fontmode = false;
                                      widget.audiomode = false;
                                    });
                                  })),
                          //-------------- fond ----------
                          Expanded(
                              flex: 1,
                              child: IconButton(
                                  icon: Icon(Icons.font_download,
                                      color: Colors.black),
                                  onPressed: () {
                                    setState(() {
                                      widget.pagecheck = true;
                                      widget.mode = false;
                                      widget.fontmode = true;
                                      widget.audiomode = false;
                                    });
                                  })),
                          //---------------- mode -----------------
                          Expanded(
                              flex: 1,
                              child: InkWell(
                                  child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Image(
                                        image:
                                            AssetImage('assets/modechange.png'),
                                      )),
                                  onTap: () {
                                    setState(() {
                                      widget.pagecheck = true;
                                      widget.fontmode = false;
                                      widget.mode = true;
                                      widget.audiomode = false;
                                    });
                                  })),
                          //-------------- audio ------------------
                        ],
                      ),
                    )
                  ],
                ))
            : Container(),
      ]),
    );
  }
}
