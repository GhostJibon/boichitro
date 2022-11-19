// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';

// class BottomOptions extends StatefulWidget {
//   BottomOptions(
//       {Key? key,
//       //  required this.isPortrait,
//       required this.scaffoldKey,
//       required this.fontmode})
//       : super(key: key);
//   // final bool isPortrait;
//   final GlobalKey<ScaffoldState> scaffoldKey;
//   // final bool pagecheck;
//   // final bool mode;
//   // final bool audiomode;
//   bool fontmode;

//   @override
//   State<BottomOptions> createState() => _BottomOptionsState();
// }

// class _BottomOptionsState extends State<BottomOptions> {
//   // GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//   bool pagecheck = false;
//   bool mode = false;
//   bool audiomode = false;
//   // bool fontmode = false;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       //  height: widget.isPortrait ? 4.5.h : 4.0.h,
//       height: 4.5.h,
//       child: Row(
//         children: [
//           //--------------- App Drawer --------------
//           Expanded(
//               flex: 1,
//               child: IconButton(
//                   icon: Icon(Icons.menu_sharp, color: Colors.black),
//                   onPressed: () {
//                     print('data is here');
//                     widget.scaffoldKey.currentState?.openDrawer();
//                   })),
//           //-------------- page ----------
//           Expanded(
//               flex: 1,
//               child: IconButton(
//                   icon: Icon(Icons.pageview_sharp, color: Colors.black),
//                   onPressed: () {
//                     setState(() {
//                       pagecheck = false;
//                       mode = false;
//                       widget.fontmode = false;
//                       audiomode = false;
//                     });
//                   })),
//           //-------------- fond ----------
//           Expanded(
//               flex: 1,
//               child: IconButton(
//                   icon: Icon(Icons.font_download, color: Colors.black),
//                   onPressed: () {
//                     setState(() {
//                       pagecheck = true;
//                       mode = false;
//                       widget.fontmode = true;
//                       audiomode = false;
//                     });
//                   })),
//           //---------------- mode -----------------
//           Expanded(
//               flex: 1,
//               child: InkWell(
//                   child: CircleAvatar(
//                       backgroundColor: Colors.white,
//                       child: Image(
//                         image: AssetImage('assets/modechange.png'),
//                       )),
//                   onTap: () {
//                     setState(() {
//                       pagecheck = true;
//                       widget.fontmode = false;
//                       mode = true;
//                       audiomode = false;
//                     });
//                   })),
//           //-------------- audio ------------------
//         ],
//       ),
//     );
//   }
// }
