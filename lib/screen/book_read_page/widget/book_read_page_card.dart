import 'dart:async';
import 'dart:math';

import 'package:dhanshirisapp/provider/highlight.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BookReadPageCardWidget extends StatefulWidget {
  final String? book;
  final String fontfamily;
  final bool ischeck_white;
  final bool ischeck_read;
  final bool ischeck_black;
  final int pagenumber;
  final HighlightProvider highlight;
  final int? start;
  final int? end;
  BookReadPageCardWidget({
    required this.book,
    required this.fontfamily,
    required this.ischeck_white,
    required this.ischeck_black,
    required this.ischeck_read,
    required this.pagenumber,
    required this.highlight,
    required this.start,
    required this.end,
  });
  @override
  State<BookReadPageCardWidget> createState() => _BookReadPageCardWidgetState();
}

class _BookReadPageCardWidgetState extends State<BookReadPageCardWidget> {
  // List _end = [10, 50];
  // List _start = [0, 10];
  int _start = 0;
  int _end = 0;
  int? start = 0;
  int? end = 0;
  PageController _pageController = PageController();
  double _scaleFactor = 1.1;
  double _baseScaleFactor = 1.0;
  @override
  Widget build(BuildContext context) {
    print(
        '--------------------------------------current page number----------------');
    print(widget.pagenumber);
    if (widget.highlight.items.values.toList().length > 0) {
      print(
          'lenght ------------------------------------------------------------ ${widget.highlight.items.values.toList().length}');
      for (int j = 0; j < widget.highlight.items.values.toList().length; j++) {
        print(
            '--------------------------------------pagenumber----------------');
        print(widget.highlight.items.values.toList()[j].page_number);
        print(widget.pagenumber);
        print('.................................................');

        if (widget.highlight.items.values.toList()[j].page_number ==
            widget.pagenumber) {
          print(widget.highlight.items.values.toList()[j].page_number);

          print('--------------------------------------Start----------------');
          print(widget.highlight.items.values.toList()[j].start);
          print('--------------------------------------end----------------');
          print(widget.highlight.items.values.toList()[j].end);
          start = widget.highlight.items.values.toList()[j].start;
          end = widget.highlight.items.values.toList()[j].end;
        }
      }
    } else {
      print(
          'i have lenght ------------------------------------------------------------  000');
      start = _start;
      end = _end;
    }
    // start = _start;
    // end = _end;
    return SingleChildScrollView(
        child: GestureDetector(
            onScaleStart: (details) {
              setState(() {
                _baseScaleFactor = _scaleFactor;
              });
            },
            onScaleUpdate: (details) {
              setState(() {
                _scaleFactor = _baseScaleFactor * details.scale;
              });
            },
            child: Container(
              margin:
                  EdgeInsets.only(left: 01.0.w, right: 01.0.w, bottom: 3.0.h),
              decoration: BoxDecoration(),
              padding: EdgeInsets.only(
                top: 4.0.w,
                left: 05.0.w,
                right: 05.0.w,
              ),
              child: SelectableText.rich(
                TextSpan(
                  style: Theme.of(context).textTheme.bodyText2,
                  children: [
                    // Text before the selection
                    TextSpan(
                      text: widget.book!.substring(0, start),
                      style: TextStyle(
                        color: widget.ischeck_white == true
                            ? Colors.black
                            : widget.ischeck_read == true
                                ? Colors.black
                                : widget.ischeck_black == true
                                    ? Colors.white
                                    : Colors.black,
                        fontFamily: widget.fontfamily,
                      ),
                    ),
                    // Selected text
                    TextSpan(
                      text: widget.book!.substring(start!, end),
                      style: TextStyle(
                        color: widget.ischeck_white == true
                            ? Colors.black
                            : widget.ischeck_read == true
                                ? Colors.black
                                : widget.ischeck_black == true
                                    ? Colors.white
                                    : Colors.black,
                        backgroundColor: Colors.blue,
                        fontFamily: widget.fontfamily,
                      ),
                    ),
                    // Text after the selection
                    TextSpan(
                      text: widget.book!.substring(end!, widget.book!.length),
                      style: TextStyle(
                        color: widget.ischeck_white == true
                            ? Colors.black
                            : widget.ischeck_read == true
                                ? Colors.black
                                : widget.ischeck_black == true
                                    ? Colors.white
                                    : Colors.black,
                        // backgroundColor: Colors.blue,
                        fontFamily: widget.fontfamily,
                      ),
                    ),
                  ],
                ),
                textScaleFactor: _scaleFactor,
                // textScaleFactor: _scaleFactor,
                textAlign: TextAlign.justify,

                // Update the start and end positions of the selection
                onSelectionChanged: (selection, _) {
                  final int newStart =
                      min(selection.baseOffset, selection.extentOffset);
                  print('-------newStart-------');
                  print(newStart);

                  final int newEnd =
                      max(selection.baseOffset, selection.extentOffset);
                  print('------------newEnd---------');
                  print(newEnd);
                  if (_start == newStart && _end == newEnd) return;
                  setState(() {
                    _start = newStart;
                    _end = newEnd;
                  });
                  //  Timer(Duration(seconds: 5), () {
                  print("Yeah, this line is printed after 3 second");
                  widget.highlight.addQuestion(
                      page_number: widget.pagenumber,
                      start: newStart,
                      end: newEnd);

                  // widget.highlight.incrementCartiteam(
                  //     page_number: widget.pagenumber, start: start, end: end);
                  //  });
                },
                toolbarOptions: ToolbarOptions(copy: false),
              ),
              //------------------old
              //  SelectableText(
              //   book.page.toString(),
              //   style: TextStyle(
              //     letterSpacing: 2.0,
              //     height: .20.h,
              //     fontFamily: _fontfamilys,
              //     fontSize: _currentSliderValue,
              // color: ischeck_white == true
              //     ? Colors.black
              //     : ischeck_read == true
              //         ? Colors.black
              //         : ischeck_black == true
              //             ? Colors.white
              //             : Colors.black,
              //   ),
              //   textScaleFactor: _scaleFactor,
              //   textAlign: TextAlign.justify,
              //   toolbarOptions: ToolbarOptions(copy: false),
              // )
            )));
  }
}
