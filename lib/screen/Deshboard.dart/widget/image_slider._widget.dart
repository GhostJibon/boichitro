import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../provider/deshboard.dart';
import '../../../widget/no_data_available.dart';
import '../../../widget/shimmer.dart';
import '../slider_screen.dart/slider_splash.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({Key? key}) : super(key: key);

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  @override
  Widget build(BuildContext context) {
    return //-------product image slider------
        Consumer<CategoryProvider>(
            child: ImageSliderShimmer(),
            builder: (context, model, child) {
              print('i check');
              print(model.isLoadingBookPreview);
              return Center(
                child: Container(
                    height: 20.0.h,
                    width: 90.0.w,
                    child: model.isLoadingBookPreview
                        ? child
                        : model.slider_images.length == 0
                            ? NodataAvailableClass(
                                'No Slider Available', 25.0.h)
                            : SplashScreenSecond(
                                image: model.slider_images,
                              )),
              );
            });
  }
}
