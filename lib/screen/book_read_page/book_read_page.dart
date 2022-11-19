import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dhanshirisapp/db/history_database.dart';
import 'package:dhanshirisapp/db/history_data.dart';
import 'package:dhanshirisapp/provider/book_read.dart';
import 'package:dhanshirisapp/provider/highlight.dart';
import 'package:dhanshirisapp/provider/order.dart';
import 'package:dhanshirisapp/screen/book_read_page/widget/book_read_page_card.dart';
import 'package:dhanshirisapp/screen/book_read_page/widget/bottom_options_widget.dart';
import 'package:dhanshirisapp/screen/book_read_page/widget/font_style_widget.dart';
import 'package:dhanshirisapp/screen/book_read_page/widget/landscapes_mode.dart';
import 'package:dhanshirisapp/translations/locale_keys.g.dart';
import 'package:dhanshirisapp/widget/book_read_selectMode.dart';
import 'package:dhanshirisapp/widget/debouncer.dart';
import 'package:dhanshirisapp/widget/drower_customer/add_drower_customer.dart';
import 'package:dhanshirisapp/widget/page_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class BookReadPage extends StatefulWidget {
  BookReadtModel bookpagemodel;
  String? book_details;
  int? book_id;
  String? book_name;
  Orther orther;
  BookReadPage(
      {required this.bookpagemodel,
      required this.book_name,
      required this.orther,
      required this.book_details,
      this.book_id});
  @override
  _BookReadScreenState createState() => _BookReadScreenState();
}

class _BookReadScreenState extends State<BookReadPage>
    with WidgetsBindingObserver {
  bool _isPortrait = false;
  int _start = 0;
  int _end = 0;
  int? start;
  int? end;
  late final PageManager _pageManager;
  late List<Note> notes;
  Note? notedata;
  // @override
  // void initState() {
  //   print(widget.book_details);
  //   super.initState();
  // }

  Future addNote() async {
    final note = Note(
      book_id: widget.book_id,
      title: widget.book_name!,
      pagenumber: pagenumber,
      book_details: widget.book_details!,
      createdTime: DateTime.now(),
    );
    await NotesDatabase.instance.create(note);
  }

  void addOrUpdateNote() async {
    // final isValid = _formKey.currentState!.validate();
    notes = await NotesDatabase.instance.readAllNotes();
    print('-----notes-----');
    for (int i = 0; i < notes.length; i++) {
      if (notes[i].book_id == widget.book_id!) {
        notedata = notes[i];
      } else {
        notedata = null;
      }
      print(notes[i].book_id);
    }

    final isUpdating = notedata != null;
    if (isUpdating) {
      await updateNote();
    } else {
      await addNote();
      // await updateNote();
    }
    print('i am working both');
    //  Navigator.of(context).pop();
  }

  Future updateNote() async {
    final note = notedata!.copy(
      book_id: widget.book_id,
      pagenumber: pagenumber,
      title: widget.book_name,
      createdTime: DateTime.now(),
      book_details: widget.book_details!,
    );

    await NotesDatabase.instance.update(note);
  }

//select modeicon veriable
  bool mode = false;
  bool ischeck_white = false;
  bool ischeck_read = false;
  bool ischeck_black = false;
  bool audiomode = false;
  // ---- Fontfamily ----------
  bool _fontmode = false;
  List _font = [
    'Bensenhandwriti',
    'Muktinarrow',
    'Adorsholipi',
    'ShohidJobbar',
  ];
  String _fontfamilys = "Adorsholipi";
  double _currentSliderValue = 14.5;
//----- page count ------
  bool pagecheck = false;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  PageController _pageController = PageController();
  double _scaleFactor = 1.1;
  double _baseScaleFactor = 1.0;

  int pagenumber = 1;
  final Debouncer onSearchDebouncer = new Debouncer(
    delay: new Duration(milliseconds: 500),
  );
  PageController _controller =
      PageController(viewportFraction: 1, keepPage: true);
  bool ischeck = false;
  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BookReadtModel bookpagemodel =
        Provider.of<BookReadtModel>(context, listen: false);
    HighlightProvider highlight =
        Provider.of<HighlightProvider>(context, listen: false);
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawerCustomer(),
      body: Container(
        child: OrientationBuilder(builder: (context, orientation) {
          if (MediaQuery.of(context).orientation == Orientation.portrait) {
            print('i am protrait');
            _isPortrait = true;
            return buildProtraits(bookpagemodel, highlight);
          } else {
            print('i am landscape');
            return buildLandscapes(bookpagemodel, highlight);
          }
        }),
      ),
    );
  }

  // Widget buildLandscape() {
  //   return Container(
  //     child: Text(
  //         "aslgaslgs gsgl gsjlg slgsljgslgslgsjgslg sgj sjg sg jslgslg slgjslgjsljgslgsjlgsljglsjgsjglsjg"),
  //   );
  // }

  Widget buildProtraits(bookpagemodel, HighlightProvider highlight) {
    return SingleChildScrollView(
      child: Column(children: [
        ischeck == false
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
              ischeck = !ischeck;
              if (ischeck == false) {
                // _currentSliderValue = 13;
              } else {
                // _currentSliderValue = 15;
              }
            });
          },
          child: Stack(
            children: [
              Container(
                height: ischeck == false ? 76.50.h : 100.0.h,
                //  width: 100.0.w,
                padding: EdgeInsets.only(
                    top: ischeck == false ? 1.0.h : 5.0.h,
                    left: 3.0.w,
                    right: 3.0.w),
                color: ischeck_white == true
                    ? Colors.white
                    : ischeck_read == true
                        ? Color(0xFFF4ECD8)
                        : ischeck_black == true
                            ? Colors.grey.shade900
                            : Colors.white,
                alignment: Alignment.topLeft,
                child: PageView.builder(
                    //  controller: _controller,

                    scrollDirection: Axis.horizontal,
                    controller: _pageController,
                    onPageChanged: (page) async {
                      addOrUpdateNote();
                      setState(() {
                        pagenumber = page + 1;
                      });
                    },
                    itemCount: bookpagemodel.BookPage!.length,
                    itemBuilder: (ctx, i) {
                      // print('this is data 1');
                      // // print(i);
                      // pagenumber = i + 1;
                      // print('page number ');
                      // print(i);
                      var book = bookpagemodel.BookPage![i];

                      return BookReadPageCardWidget(
                        book: book.page,
                        fontfamily: _fontfamilys,
                        ischeck_black: ischeck_black,
                        ischeck_read: ischeck_read,
                        ischeck_white: ischeck_white,
                        highlight: highlight,
                        pagenumber: i, //index
                        start: start,
                        end: end,
                      );
                    }),
                //  ),
              ),
              Positioned(
                  top: ischeck == false ? 38.25.h : 50.0.h,
                  left: .5.h,
                  child: Center(
                    child: IconButton(
                        onPressed: () {
                          if (pagenumber > 1 &&
                              bookpagemodel.BookPage!.length > pagenumber) {
                            _pageController.animateToPage(pagenumber - 1 - 1,
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
                  top: ischeck == false ? 38.25.h : 50.0.h,
                  right: .5.h,
                  child: Center(
                    child: IconButton(
                        onPressed: () {
                          if (pagenumber >= 0 &&
                              bookpagemodel.BookPage!.length > pagenumber) {
                            _pageController.animateToPage(pagenumber + 1 - 1,
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
        ischeck == false
            ? Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      blurRadius: 2,
                      spreadRadius: 2,
                      color: Colors.black26,
                      offset: Offset(0.1, 0.3))
                ]),
                height: 13.0.h,
                child: Column(
                  children: [
                    // Container(
                    //   height: 10.0.h,
                    //   color: Colors.blue,
                    // ),
                    //---page number count ------
                    pagecheck == false
                        ? Container(
                            margin: EdgeInsets.only(left: 15.0.w),
                            height: 7.0.h,
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
                                          _pageController.animateToPage(
                                              int.parse('1') - 1,
                                              duration:
                                                  Duration(milliseconds: 400),
                                              curve: Curves.easeIn);
                                        } else if (bookpagemodel
                                                .BookPage!.length >=
                                            int.parse(value)) {
                                          _pageController.animateToPage(
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
                                    '${LocaleKeys.page_number.tr()}: $pagenumber',
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
                    mode == true
                        ? Container(
                            height: 7.0.h,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 30.0.w, right: 30.0.w),
                                  child: Row(
                                    children: [
                                      BookReadSelectMode(
                                        onTap: () {
                                          setState(() {
                                            ischeck_white = true;
                                            ischeck_read = false;
                                            ischeck_black = false;
                                          });
                                        },
                                        boxColor: Colors.white,
                                        iconactive: ischeck_white,
                                      ),
                                      BookReadSelectMode(
                                        onTap: () {
                                          setState(() {
                                            ischeck_white = false;
                                            ischeck_read = true;
                                            ischeck_black = false;
                                          });
                                        },
                                        boxColor: Color(0xFFF4ECD8),
                                        iconactive: ischeck_read,
                                      ),
                                      BookReadSelectMode(
                                        onTap: () {
                                          setState(() {
                                            ischeck_white = false;
                                            ischeck_read = false;
                                            ischeck_black = true;
                                          });
                                        },
                                        boxColor: Colors.grey.shade900,
                                        iconactive: ischeck_black,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ))
                        : Container(height: 0.0.h),
                    // ------------------------ FontStyle ------------------

                    _fontmode == true
                        ? Container(
                            height: 7.0.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _font.length,
                              itemBuilder: (context, index) {
                                var fontname = _font[index];
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      _fontfamilys = fontname;
                                    });
                                  },
                                  child: Container(
                                    color: Colors.white,
                                    height: 5.0.h,
                                    width: 35.0.w,
                                    child: Center(
                                      child: Container(
                                        child: AutoSizeText(fontname,
                                            style: TextStyle(
                                                color: fontname == _fontfamilys
                                                    ? Colors.red
                                                    : Colors.black,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Container(height: 0.0.h),

                    Container(
                      height: 4.5.h,
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
                                    _scaffoldKey.currentState?.openDrawer();
                                  })),
                          //-------------- page ----------
                          Expanded(
                              flex: 1,
                              child: IconButton(
                                  icon: Icon(Icons.pageview_sharp,
                                      color: Colors.black),
                                  onPressed: () {
                                    setState(() {
                                      pagecheck = false;
                                      mode = false;
                                      _fontmode = false;
                                      audiomode = false;
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
                                      pagecheck = true;
                                      mode = false;
                                      _fontmode = true;
                                      audiomode = false;
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
                                      pagecheck = true;
                                      _fontmode = false;
                                      mode = true;
                                      audiomode = false;
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

//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
  //-----------------LandScape Model ---------------

  Widget buildLandscapes(bookpagemodel, highlight) {
    return SingleChildScrollView(
      child: Column(children: [
        ischeck == false
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
              ischeck = !ischeck;
              if (ischeck == false) {
                // _currentSliderValue = 13;
              } else {
                // _currentSliderValue = 15;
              }
            });
          },
          child: Stack(
            children: [
              Container(
                height: ischeck == false ? 30.50.h : 50.0.h,
                //width: 300.0.w,
                padding: EdgeInsets.only(top: ischeck == false ? .50.h : 2.0.h),
                color: ischeck_white == true
                    ? Colors.white
                    : ischeck_read == true
                        ? Color(0xFFF4ECD8)
                        : ischeck_black == true
                            ? Colors.grey.shade900
                            : Colors.white,
                alignment: Alignment.topLeft,
                child: PageView.builder(
                    //  controller: _controller,

                    scrollDirection: Axis.horizontal,
                    controller: _pageController,
                    onPageChanged: (page) async {
                      addOrUpdateNote();
                      setState(() {
                        pagenumber = page + 1;
                      });
                    },
                    itemCount: bookpagemodel.BookPage!.length,
                    itemBuilder: (ctx, i) {
                      // print('this is data 1');
                      // // print(i);
                      // pagenumber = i + 1;
                      // print('page number ');
                      // print(i);
                      var book = bookpagemodel.BookPage![i];
                      return BookReadPageCardWidget(
                        book: book.page,
                        fontfamily: _fontfamilys,
                        ischeck_black: ischeck_black,
                        ischeck_read: ischeck_read,
                        ischeck_white: ischeck_white,
                        highlight: highlight,
                        pagenumber: i, //index
                        start: start,
                        end: end,
                      );
                    }),
                //  ),
              ),
              Positioned(
                  top: ischeck == false ? 15.0.h : 25.0.h,
                  left: .5.h,
                  child: Center(
                    child: IconButton(
                        onPressed: () {
                          if (pagenumber > 1 &&
                              bookpagemodel.BookPage!.length > pagenumber) {
                            _pageController.animateToPage(pagenumber - 1 - 1,
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
                  top: ischeck == false ? 15.0.h : 25.0.h,
                  right: .5.h,
                  child: Center(
                    child: IconButton(
                        onPressed: () {
                          if (pagenumber >= 0 &&
                              bookpagemodel.BookPage!.length > pagenumber) {
                            _pageController.animateToPage(pagenumber + 1 - 1,
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
        ischeck == false
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
                    pagecheck == false
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
                                          _pageController.animateToPage(
                                              int.parse('1') - 1,
                                              duration:
                                                  Duration(milliseconds: 400),
                                              curve: Curves.easeIn);
                                        } else if (bookpagemodel
                                                .BookPage!.length >=
                                            int.parse(value)) {
                                          _pageController.animateToPage(
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
                                    '${LocaleKeys.page_number.tr()}: $pagenumber',
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
                    mode == true
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
                                            ischeck_white = true;
                                            ischeck_read = false;
                                            ischeck_black = false;
                                          });
                                        },
                                        boxColor: Colors.white,
                                        iconactive: ischeck_white,
                                      ),
                                      BookReadSelectMode(
                                        onTap: () {
                                          setState(() {
                                            ischeck_white = false;
                                            ischeck_read = true;
                                            ischeck_black = false;
                                          });
                                        },
                                        boxColor: Color(0xFFF4ECD8),
                                        iconactive: ischeck_read,
                                      ),
                                      BookReadSelectMode(
                                        onTap: () {
                                          setState(() {
                                            ischeck_white = false;
                                            ischeck_read = false;
                                            ischeck_black = true;
                                          });
                                        },
                                        boxColor: Colors.grey.shade900,
                                        iconactive: ischeck_black,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ))
                        : Container(height: 0.0.h),
                    // ------------------------ FontStyle ------------------

                    _fontmode == true
                        ? Container(
                            height: 5.0.h,
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(top: 1.0.h),
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _font.length,
                                itemBuilder: (context, index) {
                                  var fontname = _font[index];
                                  return InkWell(
                                      onTap: () {
                                        setState(() {
                                          _fontfamilys = fontname;
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
                                                    color:
                                                        fontname == _fontfamilys
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
                                    _scaffoldKey.currentState?.openDrawer();
                                  })),
                          //-------------- page ----------
                          Expanded(
                              flex: 1,
                              child: IconButton(
                                  icon: Icon(Icons.pageview_sharp,
                                      color: Colors.black),
                                  onPressed: () {
                                    setState(() {
                                      pagecheck = false;
                                      mode = false;
                                      _fontmode = false;
                                      audiomode = false;
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
                                      pagecheck = true;
                                      mode = false;
                                      _fontmode = true;
                                      audiomode = false;
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
                                      pagecheck = true;
                                      _fontmode = false;
                                      mode = true;
                                      audiomode = false;
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
