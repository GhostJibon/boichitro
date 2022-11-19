// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:sizer/sizer.dart';

// class FontsStyle extends StatefulWidget {
//   FontsStyle({Key? key, required this.font, required this.fontfamilys})
//       : super(key: key);
//    List font;
//   String fontfamilys;

//   @override
//   State<FontsStyle> createState() => _FontsStyleState();
// }

// class _FontsStyleState extends State<FontsStyle> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 7.0.h,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: widget.font.length,
//         itemBuilder: (context, index) {
//           var fontname = widget.font[index];
//           return InkWell(
//             onTap: () {
//               setState(() {
//                 widget.fontfamilys = fontname;
//               });
//             },
//             child: Container(
//               color: Colors.white,
//               height: 5.0.h,
//               width: 35.0.w,
//               child: Center(
//                 child: Container(
//                   child: AutoSizeText(fontname,
//                       style: TextStyle(
//                           color: fontname == widget.fontfamilys
//                               ? Colors.red
//                               : Colors.black,
//                           fontWeight: FontWeight.bold)),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
