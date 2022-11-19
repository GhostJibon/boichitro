import 'dart:async';
import 'dart:convert';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dhanshirisapp/db/history_database.dart';
import 'package:dhanshirisapp/db/history_data.dart';
import 'package:dhanshirisapp/provider/book_read.dart';
import 'package:dhanshirisapp/widget/book_read_selectMode.dart';
import 'package:dhanshirisapp/widget/debouncer.dart';
import 'package:dhanshirisapp/widget/drower_customer/add_drower_customer.dart';
import 'package:dhanshirisapp/widget/page_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class historyDetailsPage extends StatefulWidget {
//  BookReadtModel bookpagemodel;
  String? book_details;
  int? book_id;
  int? pagenumber;
  String? book_name;
//  Orther orther;
  historyDetailsPage(
      {
      //required this.bookpagemodel,
      required this.book_name,
      //  required this.orther,
      required this.pagenumber,
      required this.book_details,
      this.book_id});
  @override
  _BookReadScreenState createState() => _BookReadScreenState();
}

class _BookReadScreenState extends State<historyDetailsPage> {
  late List<Note> notes;
  Note? notedata;
  List<Bookreadapi>? _readbook = [];
  String? audio_book;
  List<Bookreadapi>? get BookPage => _readbook;
  PageController _pageController = PageController();
  @override
  void initState() {
    _pageController = PageController(initialPage: widget.pagenumber! - 1);

    pagenumber = widget.pagenumber!;
    // HistoryProvider historyProvider =
    //     Provider.of<HistoryProvider>(context, listen: false);
    print('-----------widget.book-details --------------');
    print(widget.book_details);
    List<Bookreadapi> _dataList = [];
    String string1 =
        widget.book_details!.replaceAll(" ", " ").replaceAll("\n", " ");
    //Map<String, dynamic>
    List<dynamic> mapResponse = JsonDecoder().convert(string1);
    // List<dynamic> _fatchdata = json.decode(response.body);
    mapResponse.forEach((dynamic datalist) {
      final Bookreadapi _product = Bookreadapi(page: datalist['page']);
      print(_product.page);
      _dataList.add(_product);
    });
    _readbook = _dataList;
    print(
        '----------------------------------Book_Details ---------------------------');
    print(widget.book_details);
    super.initState();
    // _pageManager = PageManager();
    //  pageManager();
  }

  // pageManager() async {
  //   await _pageManager.audiofile(widget.bookpagemodel.audio_book);
  //   await _pageManager.initcall();
  // }

  @override
  void dispose() {
    //  _pageManager.dispose();
    super.dispose();
  }

  // Future addNote() async {
  //   final note = Note(
  //     book_id: widget.book_id,
  //     title: widget.book_name!,
  //     pagenumber: pagenumber,
  //     book_details: widget.book_details!,
  //     createdTime: DateTime.now(),
  //   );
  //   await NotesDatabase.instance.create(note);
  // }

  // void addOrUpdateNote() async {
  //   // final isValid = _formKey.currentState!.validate();
  //   notes = await NotesDatabase.instance.readAllNotes();
  //   print('-----notes-----');
  //   for (int i = 0; i < notes.length; i++) {
  //     if (notes[i].book_id == widget.book_id!) {
  //       notedata = notes[i];
  //     } else {
  //       notedata = null;
  //     }
  //     print(notes[i].book_id);
  //   }

  //   final isUpdating = notedata != null;
  //   if (isUpdating) {
  //     print('i am working updating');
  //     await updateNote();
  //   } else {
  //     print('i am working add note');
  //     await addNote();
  //     // await updateNote();
  //   }
  //   print('i am working both');
  //   //  Navigator.of(context).pop();
  // }

  // Future updateNote() async {
  //   final note = notedata!.copy(
  //       // book_details: widget.book_details!,
  //       book_id: widget.book_id,
  //       title: widget.book_name!,
  //       pagenumber: pagenumber,
  //       createdTime: DateTime.now());

  //   await NotesDatabase.instance.update(note);
  // }

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
  double _scaleFactor = 1.0;
  double _baseScaleFactor = 1.0;
  int pagenumber = 1;
  final Debouncer onSearchDebouncer = new Debouncer(
    delay: new Duration(milliseconds: 500),
  );
  bool ischeck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawerCustomer(),
      body: SingleChildScrollView(
          child: Column(children: [
        ischeck == false
            ? Container(
                padding: EdgeInsets.only(top: 2.0.h),
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

        GestureDetector(
          onTap: () {
            setState(() {
              ischeck = !ischeck;
              if (ischeck == false) {
                // _currentSliderValue = 13;
              } else {
                // _currentSliderValue = 15;
              }
            });
          },
          child: Container(
            height: ischeck == false ? 76.5.h : 100.0.h,
            width: 100.0.w,
            padding: EdgeInsets.only(top: ischeck == false ? 1.0.h : 3.0.h),
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
                  //  addOrUpdateNote();
                  setState(() {
                    pagenumber = page + 1;
                  });
                },
                itemCount: BookPage!.length,
                itemBuilder: (ctx, i) {
                  print('page number ');
                  print(i);
                  var book = BookPage![i];
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
                          margin: EdgeInsets.only(left: 02.0.w, right: 02.0.w),
                          decoration: BoxDecoration(),
                          padding: EdgeInsets.only(
                            top: 4.0.w,
                            left: 03.0.w,
                            right: 03.0.w,
                          ),
                          child: Text(
                            book.page.toString(),
                            style: TextStyle(
                              fontFamily: _fontfamilys,
                              fontSize: _currentSliderValue,
                              color: ischeck_white == true
                                  ? Colors.black
                                  : ischeck_read == true
                                      ? Colors.black
                                      : ischeck_black == true
                                          ? Colors.white
                                          : Colors.black,
                            ),
                            textScaleFactor: _scaleFactor,
                            textAlign: TextAlign.justify,
                            // group: AutoSizeGroup(),
                          )),
                    ),
                  );
                }),
            //  ),
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
                            margin: EdgeInsets.only(left: 20.0.w),
                            height: 7.0.h,
                            child: Row(
                              children: [
                                Container(
                                    child: Text(
                                  'Search Page',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 1.5.h),
                                )),
                                SizedBox(
                                  width: 5.0.w,
                                ),
                                Container(
                                    width: 15.0.w,
                                    height: 3.5.h,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      maxLines: 1,

                                      // keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                        hintText: pagenumber.toString(),
                                        enabled: true,
                                        contentPadding: const EdgeInsets.only(
                                            top: 2.0,
                                            bottom: 2.0,
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
                                        } else if (BookPage!.length >=
                                            int.parse(value)) {
                                          _pageController.animateToPage(
                                              int.parse(value) - 1,
                                              duration:
                                                  Duration(milliseconds: 400),
                                              curve: Curves.easeIn);
                                        }
                                      },
                                    )),

                                // Center(
                                //   child: Text(
                                //     'Page Number : $pagenumber',
                                //     style: TextStyle(
                                //         color: Colors.black,
                                //         fontWeight: FontWeight.bold,
                                //         fontSize: 1.0.h),
                                //   ),
                                // ),
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
                    //---------------audio ----------------------

                    Container(
                        height: 4.50.h,
                        //    color: Colors.red,
                        child: Row(
                          children: [
                            //--------------- App Drawer --------------
                            // Expanded(
                            //     flex: 1,
                            //     child: IconButton(
                            //         icon: Icon(Icons.menu_sharp,
                            //             color: Colors.black),
                            //         onPressed: () {
                            //           print('data is here');
                            //           _scaffoldKey.currentState?.openDrawer();
                            //         })),
                            //-------------- page ----------
                            Expanded(
                                flex: 1,
                                child: IconButton(
                                    icon: Icon(Icons.pageview_sharp,
                                        color: Colors.black),
                                    onPressed: () {
                                      setState(() {
                                        //print(i);
                                        //  widget.orther.pagenumber(i);
                                        //  pagenumbe = i;

                                        // _controller.jumpToPage(3);
                                        // _controller.animateToPage(3,
                                        //     curve: Curves.decelerate,
                                        //     duration:
                                        //         Duration(milliseconds: 300));
                                        // for animated jump. Requires a curve and a duration

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
                                child: IconButton(
                                    icon: Icon(Icons.wb_sunny_rounded,
                                        color: Colors.black),
                                    onPressed: () {
                                      setState(() {
                                        pagecheck = true;
                                        _fontmode = false;
                                        mode = true;
                                        audiomode = false;
                                      });
                                    })),
                            //-------------- audio ------------------
                            // Expanded(
                            //     flex: 1,
                            //     child: IconButton(
                            //         icon: Icon(Icons.campaign,
                            //             color: Colors.black),
                            //         onPressed: () {
                            //           setState(() {
                            //             pagecheck = true;
                            //             _fontmode = false;
                            //             mode = false;
                            //             audiomode = true;
                            //           });
                            //         }))
                          ],
                        ))
                  ],
                ))
            : Container(),
        // SizedBox(
        //   height: 1.0.h,
        // ),
      ])),
    );
  }

  // void previousPage() {
  //   _pageController.animateToPage(pagenumbe,
  //       duration: Duration(milliseconds: 400), curve: Curves.easeIn);
  // }
}
