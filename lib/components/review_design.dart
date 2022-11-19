import 'package:dhanshirisapp/model/review_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';

class ReviewDesign extends StatelessWidget {
  ReviewList data;
  ReviewDesign({required this.data});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 05.0.h, right: 05.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 3.0.h,
                //s  margin: EdgeInsets.only(left: 05.0.h, right: 05.0.h),
                alignment: Alignment.centerLeft,
                child: Text(
                  data.name != null ? data.name! : "Unknown",
                  style: TextStyle(
                      // color: Colors.black,
                      // fontWeight: FontWeight.bold,
                      fontSize: 1.8.h),
                ),
              ),
              Container(
                height: 2.5.h,
                alignment: Alignment.centerLeft,
                child: RatingBarIndicator(
                  rating: double.parse(data.rating!),
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 30.0,
                  direction: Axis.horizontal,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: .50.h,
        ),
        Container(
          // height: 9.0.h,
          margin: EdgeInsets.only(left: 05.0.h, right: 05.0.h),
          alignment: Alignment.centerLeft,
          child: Text(data.comment!,
              style: TextStyle(

                  ///  color: Colors.black,
                  // fontWeight: FontWeight.bold,
                  fontSize: 1.50.h)),
        ),
        SizedBox(
          height: 1.5.h,
        ),
      ],
    );
  }
}
