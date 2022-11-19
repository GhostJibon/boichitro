import 'package:dhanshirisapp/model/bookInfo.dart';
import 'package:dhanshirisapp/model/sliderimage.dart';
import 'package:dhanshirisapp/provider/auth.dart';
import 'package:dhanshirisapp/screen/book_api_call.dart';
import 'package:dhanshirisapp/screen/book_screen/book_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sizer/sizer.dart';

import '../../../model/slider_model.dart';

class SlideItem extends StatelessWidget {
  final SliderModel sliderimage;
  SlideItem(this.sliderimage);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BookDetails(
                      sliderimage,
                      sliderimage.cover_image.toString(),
                    )));
      },
      child: Column(
        children: [
          Container(
            //  margin: EdgeInsets.only(left: 05.0.w, right: 05.0.w),
            height: 18.0.h,
            width: 100.0.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(
                      "https://res.cloudinary.com/boichitro/${sliderimage.slider__image}",
                    ),
                    fit: BoxFit.cover)),
            // child: Image(
            //     image: NetworkImage(
            //       "https://res.cloudinary.com/boichitro/${image.name.toString()}",
            //     ),
            //     fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }
}
