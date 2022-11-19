// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:dhanshirisapp/provider/order.dart';
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';

// class BookReadBox extends StatelessWidget {
//   final String? i;
//   // int id;
//   // Orther orther;
//   Function(String)? onfunction;
//   BookReadBox({
//     required this.i,
//     // required this.id,
//     // required this.orther,
//     required this.onfunction,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           height: 80.5.h,
//           width: 100.0.w,
//           margin: EdgeInsets.only(left: 02.0.w, right: 02.0.w),
//           decoration: BoxDecoration(),
//           padding: EdgeInsets.only(
//             top: 4.0.w,
//             left: 03.0.w,
//             right: 03.0.w,
//           ),
//           child: AutoSizeText(
//             i.toString(),

//             style: TextStyle(
//                 fontSize: 30.0,
//                 fontFamily: orther.getfont.toString(),
//                 height: .16.h,
//                 letterSpacing: 4.10),
//             textAlign: TextAlign.justify,

//             // maxLines: 23,
//             // minFontSize: 25,
//             // maxFontSize: 25,
//             group: AutoSizeGroup(),
//           ),
//         ),
//         Container(
//           height: 4.0.h,
//           width: 100.0.w,
//           margin: EdgeInsets.only(left: 50.0.w),
//           alignment: Alignment.centerRight,
//           child: Row(
//             children: [
//               Container(
//                 height: 3.5.h,
//                 width: 25.0.w,
//                 margin: EdgeInsets.only(right: 2.0.w),
//                 alignment: Alignment.centerRight,
//                 child: Text(
//                   'Page :',
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.grey[700],
//                       fontSize: 1.7.h),
//                 ),
//               ),
//               Container(
//                 height: 3.5.h,
//                 width: 15.0.w,
//                 decoration: BoxDecoration(
//                     border: Border.all(width: 2, color: Colors.red)),
//                 margin: EdgeInsets.only(right: 5.0.w),
//                 // alignment: Alignment.centerRight,
//                 child: Center(
//                   child: TextField(
//                     maxLines: 1,
//                     textAlignVertical: TextAlignVertical.center,
//                     textAlign: TextAlign.center,
//                     decoration: InputDecoration(
//                       hintText: "${id + 1}",
//                       hintStyle: TextStyle(fontWeight: FontWeight.bold),
//                       // border: new OutlineInputBorder(
//                       //     borderSide: new BorderSide(color: Colors.teal)),
//                     ),
//                     onChanged: onfunction,
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.grey[700],
//                         fontSize: 1.5.h),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
