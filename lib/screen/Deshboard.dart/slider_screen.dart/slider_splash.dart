import 'dart:async';

import 'package:dhanshirisapp/model/bookInfo.dart';

import 'package:dhanshirisapp/screen/Deshboard.dart/slider_screen.dart/slider_dots.dart';
import 'package:dhanshirisapp/screen/Deshboard.dart/slider_screen.dart/slider_item.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../model/slider_model.dart';

class SplashScreenSecond extends StatefulWidget {
  final List<SliderModel> image;
  SplashScreenSecond({required this.image});
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreenSecond> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < widget.image.length) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 20.0.h,
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: <Widget>[
              PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: widget.image.length,
                  itemBuilder: (ctx, i) {
                    SliderModel data = widget.image[i];
                    return SlideItem(data);
                  }),
              Stack(
                alignment: AlignmentDirectional.topStart,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for (int i = 0; i < widget.image.length; i++)
                          if (i == _currentPage)
                            SlideDots(true)
                          else
                            SlideDots(false)
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        // SignInBox(
        //     color: Color(0xFFdab13c),
        //     name: 'NEXT',
        //     onPressed: () {
        //       Navigator.push(context,
        //           MaterialPageRoute(builder: (context) => LogInScreen()));
        //     }),
        // SizedBox(height: 1.5.h),
        //OrBox(),
        // SignInBox(
        //     name: 'SIGN IN',
        //     onPressed: () {
        //       Navigator.push(context,
        //           MaterialPageRoute(builder: (context) => LogInScreen()));
        //     }),
        // OrBox(),
        // SignUpBox(
        //     name: 'SIGN UP',
        //     onPressed: () {
        //       Navigator.push(context,
        //           MaterialPageRoute(builder: (context) => LogInScreen()));
        //     }),
      ],
    );
  }
}
