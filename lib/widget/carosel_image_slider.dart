import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselWithIndicator extends StatefulWidget {
  List<String>? images = [];

  CarouselWithIndicator({this.images});

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;

  List<Widget> imageSliders() {
    return widget.images!
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  // child: Image.network(item, fit: BoxFit.cover, width: 1000.0),
                  child: CachedNetworkImage(
                    imageUrl: "https://res.cloudinary.com/boichitro/$item",
                    // placeholder: (context, url) => CircularProgressIndicator(),
                    // errorWidget: (context, url, error) => Icon(Icons.error),
                  ),

                  //  Image.network(
                  //   'https://res.cloudinary.com/boichitro/$item',
                  //   fit: BoxFit.fitWidth,
                  //   width: 1000,
                  // ),

                  //  Image.memory(
                  //   Base64Decoder().convert(item),
                  //   fit: BoxFit.cover,
                  //   width: 1000,
                  // ),
                ),
              ),
            ))
        .toList();
  }

  //imgList.map((item) => ).toList();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CarouselSlider(
          items: imageSliders(),
          options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 1.50,
              viewportFraction: 1.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Positioned(
          bottom: 25,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: widget.images!.map((url) {
              int index = widget.images!.indexOf(url);
              return Container(
                width: 12.0,
                height: 12.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? Color.fromRGBO(255, 99, 71, 0.6)
                      : Color.fromRGBO(240, 240, 240, 1),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
