// import 'dart:convert';
// import 'dart:typed_data';

// import 'package:dhanshirisapp/provider/category_provider.dart';
// import 'package:dhanshirisapp/provider/categories_product_list.dart';
// import 'package:dhanshirisapp/screen/book_list.dart';
// import 'package:dhanshirisapp/screen/bookdetails.dart';
// import 'package:dhanshirisapp/translations/locale_keys.g.dart';
// import 'package:dhanshirisapp/widget/popup_Screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:sizer/sizer.dart';
// import 'package:easy_localization/easy_localization.dart';

// class CatagorybookListDetails extends StatefulWidget {
//   final ProductList recentlist;
//   CatagorybookListDetails({required this.recentlist});

//   @override
//   _CatagoribookState createState() => _CatagoribookState();
// }

// class _CatagoribookState extends State<CatagorybookListDetails> {
//   GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   @override
//   Widget build(BuildContext context) {
//     Uint8List _bytesImage;
//     _bytesImage =
//         Base64Decoder().convert(widget.recentlist.cover_image.toString());
//     return GestureDetector(
//       onTap: () {
//         _showModalBottomSheet(widget.recentlist, _bytesImage);
//         // print("Opening bottom Sheet");
//         // var sheetController = _scaffoldKey.currentState
//         //     ?.showBottomSheet((context) => BottomSheetWidget());
//         // print(sheetController);
//         // sheetController?.closed.then((value) {
//         //   print("Bottom Sheet Closed");
//         //   // print(value);
//         //   // if (value == 1) {
//         //   // setState(() {
//         //   //   print('i am working');
//         //   // });
//         //   // }
//         // });

//         // Navigator.push(
//         //     context, MaterialPageRoute(builder: (context) => BookDetails()));
//       },
//       child: Container(
//         // width: 25.0.w,
//         // height: 25.0.h,
//         margin: EdgeInsets.only(
//             top: 1.0.h, bottom: 1.0.h, left: 3.0.w, right: 3.0.w),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 4,
//                 spreadRadius: 5,
//                 offset: Offset.zero,
//               )
//             ]),
//         //   margin: EdgeInsets.only(left: 5.0.w, top: 1.0.h),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               alignment: Alignment.topLeft,
//               height: 14.0.h,
//               // width: 25.0.w,
//               decoration: BoxDecoration(
//                 //  color: Colors.black26,
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(10),
//                     topRight: Radius.circular(10)),

//                 //color: const Color(0xff7c94b6),
//                 image: new DecorationImage(
//                   fit: BoxFit.fill,
//                   image: MemoryImage(_bytesImage),
//                 ),
//               ),
//               //   child: Image.memory(_bytesImage),
//             ),
//             Container(
//               alignment: Alignment.centerLeft,
//               height: 3.0.h,
//               child: Center(
//                 child: Text(
//                   widget.recentlist.bookname.toString(),
//                   style: TextStyle(
//                       //  color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 1.5.h),
//                 ),
//               ),
//             ),
//             Container(
//               height: 2.0.h,
//               child: Center(
//                 child: RatingBarIndicator(
//                     rating: double.parse(widget.recentlist.rating.toString()),
//                     itemBuilder: (context, index) => Icon(
//                           Icons.star,
//                           // color: Colors.amber,
//                         ),
//                     itemCount: 5,
//                     itemSize: 17.0,
//                     direction: Axis.horizontal),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   _showModalBottomSheet(ProductList recentlist, Uint8List _bytesImage) {
//     return showModalBottomSheet(
//         context: context,
//         builder: (context) {
//           return Container(
//             height: 90.0.h,
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Container(
//                     height: 25.0.h,
//                     child: Row(
//                       children: [
//                         Container(
//                           margin: EdgeInsets.only(
//                               top: 2.5.h,
//                               left: 5.0.w,
//                               right: 3.0.w,
//                               bottom: 5.0.h),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15),
//                               image: DecorationImage(
//                                   image: MemoryImage(_bytesImage),
//                                   fit: BoxFit.fill),
//                               boxShadow: [
//                                 BoxShadow(
//                                     blurRadius: 2,
//                                     spreadRadius: 3,
//                                     color: Colors.black12,
//                                     offset: Offset.zero)
//                               ]),
//                           width: 30.0.w,
//                         ),
//                         Container(
//                           margin: EdgeInsets.only(top: 2.0.h, left: 5.0.w),
//                           child: Column(
//                             children: [
//                               PopUpScreen(
//                                 //   name: "Name",
//                                 name: LocaleKeys.name.tr(),
//                                 title: recentlist.bookname.toString(),
//                               ),
//                               PopUpScreen(
//                                 // name: "Writer Name",
//                                 name: LocaleKeys.writername.tr(),
//                                 title: recentlist.author.toString(),
//                               ),
//                               PopUpScreen(
//                                 //name: "Publications",
//                                 name: LocaleKeys.publicaions.tr(),
//                                 title: recentlist.publisher.toString(),
//                               ),
//                               PopUpScreen(
//                                 // name: "Published",
//                                 name: LocaleKeys.published.tr(),
//                                 title: "-------",
//                               ),
//                               PopUpScreen(
//                                 //  name: "Version",
//                                 name: LocaleKeys.version.tr(),
//                                 title: recentlist.edition.toString(),
//                               ),
//                               PopUpScreen(
//                                 name: "ISBN",
//                                 title: recentlist.isbn.toString(),
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(left: 5.0.w),
//                     alignment: Alignment.centerLeft,
//                     height: 4.0.h,
//                     child: Text(
//                       //  'About Book',
//                       LocaleKeys.aboutbook.tr(),
//                       style: TextStyle(
//                           fontSize: 2.5.h, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(left: 5.0.w, right: 5.0.w),
//                     alignment: Alignment.centerLeft,
//                     height: 20.0.h,
//                     child: ListView(
//                       children: [
//                         Text(
//                           recentlist.cover_note.toString(),
//                           textAlign: TextAlign.justify,
//                           style: TextStyle(
//                               fontSize: 1.5.h, fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) => BooksList(name:recentlist.na)));
//                     },
//                     child: Container(
//                       margin: EdgeInsets.only(left: 5.0.w, right: 5.0.w),
//                       decoration: BoxDecoration(
//                           color: Colors.red,
//                           borderRadius: BorderRadius.circular(15)),
//                       height: 5.0.h,
//                       width: 100.0.w,
//                       child: Center(
//                         child: Text(
//                           // 'Read More',
//                           LocaleKeys.readmore.tr(),
//                           style: TextStyle(
//                               fontSize: 2.5.h,
//                               //  color: Colors.white,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           );
//         });
//   }
// }

// // class BottomSheetWidget extends StatefulWidget {
// //   const BottomSheetWidget({
// //     Key? key,
// //   }) : super(key: key);

// //   @override
// //   _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
// // }

// // class _BottomSheetWidgetState extends State<BottomSheetWidget> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //         height: 55.0.h,
// //         child: Container(
// //             height: 0.0.h,
// //             child: Column(children: [
// //               Container(
// //                 margin: EdgeInsets.only(
// //                     left: 05.0.w, right: 05.0.w, top: 1.0.h, bottom: 1.0.h),
// //                 decoration: BoxDecoration(
// //                     borderRadius: BorderRadius.all(Radius.circular(20)),
// //                     boxShadow: [
// //                       BoxShadow(
// //                           blurRadius: 2,
// //                           color: Colors.black12,
// //                           offset: Offset(0, 2),
// //                           spreadRadius: 4)
// //                     ]),
// //               )
// //             ])));
// //   }
// // }
