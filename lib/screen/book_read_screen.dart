// import 'dart:async';

// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:dhanshirisapp/provider/book_read.dart';
// import 'package:dhanshirisapp/provider/category_provider.dart';
// import 'package:dhanshirisapp/provider/order.dart';
// import 'package:dhanshirisapp/widget/book_read_box.dart';
// import 'package:dhanshirisapp/widget/debouncer.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sizer/sizer.dart';

// class BookReadScreens extends StatefulWidget {
//   BookReadtModel bookpagemodel;
//   Orther orther;
//   BookReadScreen({required this.bookpagemodel, required this.orther});
//   @override
//   _BookReadScreenState createState() => _BookReadScreenState();
// }

// class _BookReadScreenState extends State<BookReadScreen> {
//   PageController _pageController = PageController();
//   double _currentSliderValue = 0;
//   double _scaleFactor = 1.0;
//   double _baseScaleFactor = 1.0;
//   int pagenumbe = 1;
//   final Debouncer onSearchDebouncer = new Debouncer(
//     delay: new Duration(milliseconds: 500),
//   );
//   PageController _controller =
//       PageController(viewportFraction: 1, keepPage: true);
//   @override
//   Widget build(BuildContext context) {
//     BookReadtModel bookpagemodel = Provider.of<BookReadtModel>(context);
//     return SingleChildScrollView(
//         child: Container(
//             height: 88.5.h,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(20),
//                   // bottomLeft: Radius.circular(20),
//                   // bottomRight: Radius.circular(20),
//                   topRight: Radius.circular(20)),
//             ),
//             child: Column(children: [
//               Container(
//                 height: 84.50.h,
//                 width: 100.0.w,

//                 alignment: Alignment.topLeft,
//                 // margin:
//                 //     EdgeInsets.only(left: 05.0.w, right: 05.0.w, bottom: 0.5.h),
//                 // child: ListView.builder(
//                 //     shrinkWrap: false,
//                 //     scrollDirection: Axis.horizontal,
//                 //     itemCount: 5,
//                 //     itemBuilder: (context, index) {
//                 //       return BookReadBox();
//                 //     }),
//                 child: PageView.builder(
//                     //  controller: _controller,
//                     scrollDirection: Axis.horizontal,
//                     controller: _pageController,
//                     // onPageChanged: (page) {
//                     //   setState(() {
//                     //     widget.orther.pagenumber(page);
//                     //   });
//                     // },
//                     itemCount: bookpagemodel.BookPage!.length,
//                     itemBuilder: (ctx, i) {
//                       print('this is data 1');
//                       // print(i);

//                       var book = bookpagemodel.BookPage![i];
//                       print(book.page);
//                       return GestureDetector(
//                         // onScaleStart: (details) {
//                         //   setState(() {
//                         //     _baseScaleFactor = _scaleFactor;
//                         //   });
//                         // },
//                         // onScaleUpdate: (details) {
//                         //   setState(() {
//                         //     _scaleFactor = _baseScaleFactor * details.scale;
//                         //   });
//                         // },
//                         onTap: () async {
//                           SharedPreferences prefs =
//                               await SharedPreferences.getInstance();
//                           setState(() {
//                             print(i);
//                             //  widget.orther.pagenumber(i);
//                             //  pagenumbe = i;
//                             String? a = prefs.getString('pagenumber');
//                             _controller.jumpToPage(pagenumbe);
//                             _controller.animateToPage(pagenumbe,
//                                 curve: Curves.decelerate,
//                                 duration: Duration(milliseconds: 300));
//                             // for animated jump. Requires a curve and a duration
//                           });
//                         },
//                         child: BookReadBox(
//                           id: i,
//                           i: book.page,
//                           orther: widget.orther,
//                           onfunction: (value) {
//                             Timer(const Duration(seconds: 3), () {
//                               pagenumbe = int.parse(value);
//                               _pageController.animateToPage(pagenumbe - 1,
//                                   duration: Duration(milliseconds: 400),
//                                   curve: Curves.easeIn);
//                             });
//                             // onSearchDebouncer
//                             //     .debounce(() =>
//                           },
//                         ),
//                       );
//                     }),
//               ),

//               // SizedBox(
//               //   height: 1.0.h,
//               // ),
//             ])));
//   }

//   void previousPage() {
//     _pageController.animateToPage(pagenumbe,
//         duration: Duration(milliseconds: 400), curve: Curves.easeIn);
//   }
// }
