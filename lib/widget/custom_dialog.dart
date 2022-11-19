import 'package:auto_size_text/auto_size_text.dart';
import 'package:dhanshirisapp/widget/price_cart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

_createPlayer() {
  return CustomDialog();
}

class CustomDialog extends StatefulWidget {
  @override
  createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  bool ischeckone = false;
  bool ischecktwo = false;
  bool ischeckthere = false;

  build(BuildContext context) {
    return AlertDialog(
      content: Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: SingleChildScrollView(
          child: Column(
            //  alignment: Alignment.topCenter,
            //  overflow: Overflow.visible,
            children: [
              // Positioned(
              //   child: FloatingActionButton(
              //     child: Icon(Icons.add),
              //     onPressed: () {
              //       print('FAB tapped!');
              //     },
              //     backgroundColor: Colors.blueGrey,
              //   ),
              //   right: 10,
              //   height: 5.0.h,
              //   top: 1.0.h,
              // ),
              // Positioned(
              //     top: -05.0.h,
              //     right: .001.w,
              //     width: 15.0.w,
              //     height: 05.0.h,
              //     child: IconButton(
              //       icon: Icon(
              //         Icons.cancel,
              //         size: 35,
              //         color: Colors.white,
              //       ),
              //       onPressed: () {

              //         print('click');
              //         Navigator.pop(context, true);
              //       },
              //       color: Colors.white,
              //     )),
              Container(
                height: 50.0.h,
                width: 100.0.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  // gradient: LinearGradient(
                  //     begin: Alignment.topLeft,
                  //     end: Alignment.bottomLeft,
                  //     colors: [Color(0xff7b65f4), Color(0xff7dded0)])
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 2.0.h,
                        left: 05.0.w,
                      ),
                      alignment: Alignment.topCenter,
                      child: Row(
                        children: [
                          Container(
                            width: 60.0.w,
                            child: Text(
                              "Unlock \nEverything Now !",
                              style: TextStyle(
                                  fontSize: 2.0.h,
                                  color: Color(0xffb8242a),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                              child: IconButton(
                            icon: Icon(
                              Icons.cancel,
                              size: 35,
                              color: Color(0xffb8242a),
                            ),
                            onPressed: () {
                              print('click');
                              Navigator.pop(context, true);
                            },
                            color: Color(0xffb8242a),
                          )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.5.h,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 05.0.w),
                      child: AutoSizeText("Choose a Plan",
                          style: TextStyle(
                              color: Color(0xffb8242a),
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                      height: 3.0.h,
                    ),
                    SizedBox(height: 1.0.h),
                    PriceCart(
                        ischeck: ischeckone,
                        onTap: () {
                          setState(() {
                            ischeckone = true;
                            ischecktwo = false;
                            ischeckthere = false;
                          });
                        }),
                    SizedBox(height: 1.0.h),
                    PriceCart(
                        ischeck: ischecktwo,
                        onTap: () {
                          setState(() {
                            ischeckone = false;
                            ischecktwo = true;
                            ischeckthere = false;
                          });
                        }),
                    SizedBox(height: 1.0.h),
                    PriceCart(
                        ischeck: ischeckthere,
                        onTap: () {
                          setState(() {
                            ischeckone = false;
                            ischecktwo = false;
                            ischeckthere = true;
                          });
                        })
                    // Container(
                    //     margin: EdgeInsets.only(left: 05.0.w, right: 05.0.w),
                    //     width: 70.0.w,
                    //     height: 6.0.h,
                    //     decoration: BoxDecoration(
                    //       color: Color(0xffb8242a),
                    //       borderRadius: BorderRadius.circular(5),
                    //     ),
                    //     child: Row(
                    //       children: [
                    //         Expanded(
                    //           flex: 1,
                    //           child: Container(
                    //               margin: EdgeInsets.only(
                    //                   left: 05.0.w,
                    //                   top: 02.0.h,
                    //                   bottom: 02.0.h,
                    //                   right: 3.0.w),
                    //               decoration: BoxDecoration(
                    //                   color: Colors.white,
                    //                   border: Border.all(
                    //                     width: 1,
                    //                     color: Color(0xffb8242a),
                    //                   ),
                    //                   shape: BoxShape.circle),
                    //               child: Center(
                    //                 child: Icon(
                    //                   Icons.done_rounded,
                    //                   size: 10,
                    //                   color: Color(0xffb8242a),
                    //                 ),
                    //               )),
                    //         ),
                    //         Expanded(
                    //           flex: 5,
                    //           child: Column(
                    //             children: [
                    //               Expanded(
                    //                 flex: 3,
                    //                 child: Container(
                    //                     alignment: Alignment.bottomLeft,
                    //                     child: AutoSizeText(
                    //                         '৳100.99 / One Years',
                    //                         style: TextStyle(
                    //                             fontWeight: FontWeight.bold,
                    //                             color: Colors.white))),
                    //               ),
                    //               Expanded(
                    //                 flex: 2,
                    //                 child: Container(
                    //                     alignment: Alignment.topLeft,
                    //                     child: AutoSizeText('Forever access',
                    //                         style: TextStyle(
                    //                             fontSize: 10,
                    //                             fontWeight: FontWeight.bold,
                    //                             color: Colors.white))),
                    //               )
                    //             ],
                    //           ),
                    //         )
                    //       ],
                    //     ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
