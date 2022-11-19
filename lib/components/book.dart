import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';

class BookSingle extends StatelessWidget {
  var widget;

  var bytesImage;

  BookSingle({this.bytesImage, this.widget});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 25.0.w,
      margin: EdgeInsets.only(top: 1.0.h, bottom: 1.0.h, left: 3.0.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              spreadRadius: 5,
              offset: Offset.zero,
            )
          ]),
      //   margin: EdgeInsets.only(left: 5.0.w, top: 1.0.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.topLeft,
            height: 14.0.h,
            width: 25.0.w,
            decoration: BoxDecoration(
              //  color: Colors.black26,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),

              //color: const Color(0xff7c94b6),
              image: new DecorationImage(
                fit: BoxFit.fill,
                image: MemoryImage(bytesImage),
              ),
            ),
            //   child: Image.memory(_bytesImage),
          ),
          Container(
            alignment: Alignment.center,
            height: 3.0.h,
            padding: EdgeInsets.only(left: 2.0.w),
            child: Center(
              child: Text(
                widget.recentBooks.bookname.toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    //  color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 1.5.h),
              ),
            ),
          ),
          Container(
            height: 2.0.h,
            margin: EdgeInsets.only(bottom: 1),
            child: Center(
              child: RatingBarIndicator(
                  rating: double.parse(widget.recentBooks.rating.toString()),
                  itemBuilder: (context, index) => Icon(
                        Icons.star,
                        // color: Colors.amber,
                      ),
                  itemCount: 5,
                  itemSize: 17.0,
                  direction: Axis.horizontal),
            ),
          ),
        ],
      ),
    );
  }
}
