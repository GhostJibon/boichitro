import 'package:dhanshirisapp/model/book_request.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BookRequestCart extends StatelessWidget {
  final BookRequestModel bookrequest;
  BookRequestCart(this.bookrequest);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 10.0.h,
      width: 100.0.w,
      margin: EdgeInsets.only(left: 3.0.w, right: 3.0.w, bottom: 1.0.h),
      padding: EdgeInsets.only(left: 3.0.w, top: 1.0.h, bottom: 1.0.h),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[300]!,
                blurRadius: 2,
                spreadRadius: 2,
                offset: Offset.zero)
          ]),
      child: Row(
        children: [
          Expanded(
            flex: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: Text(
                  'Book Title :  ${bookrequest.request_title}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 1.7.h,
                      color: Color(0xffc60e13)),
                )),
                Expanded(
                    child: Text(
                  'Category : ${bookrequest.request_body}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 1.7.h,
                      color: Color(0xffc60e13)),
                )),
                Expanded(
                    child: Text(
                  'Additional Note : ${bookrequest.additional_note}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 1.7.h,
                      color: Color(0xffc60e13)),
                )),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              // margin: EdgeInsets.only(),
              //color: Colors.red,
              child: Center(
                child: Text(
                  bookrequest.status ?? ' ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 2.2.h,
                      color: Color(0xffc60e13)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
