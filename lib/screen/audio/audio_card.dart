import 'dart:convert';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dhanshirisapp/constants/app_constants.dart';
import 'package:dhanshirisapp/model/audio_book.dart';
import 'package:dhanshirisapp/provider/deshboard.dart';
import 'package:dhanshirisapp/provider/favourit_list.dart';
import 'package:dhanshirisapp/provider/subcription.dart';
import 'package:dhanshirisapp/provider/theme_provider.dart';
import 'package:dhanshirisapp/screen/audio/audio_book_details.dart';
import 'package:dhanshirisapp/screen/book_api_call.dart';
import 'package:dhanshirisapp/screen/text_audio_file.dart';
import 'package:dhanshirisapp/services/secure_storage_service.dart';
import 'package:dhanshirisapp/widget/carosel_image_slider.dart';
import 'package:dhanshirisapp/widget/shimmer.dart';
import 'package:dhanshirisapp/widget/subcription_cart.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dhanshirisapp/screen/book_screen/modal_tab_bar.dart';
import 'package:dhanshirisapp/screen/book_screen/rating_bar.dart';
import 'package:dhanshirisapp/translations/locale_keys.g.dart';
import 'package:dhanshirisapp/widget/popup_Screen.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AudioBookCart extends StatefulWidget {
  AudioBookModel audiobookdetails;
  AudioBookCart(
    this.audiobookdetails,
  );
  @override
  _BookCartState createState() => _BookCartState();
}

class _BookCartState extends State<AudioBookCart> {
  build(BuildContext context) {
    Uint8List _bytesImage;
    // _bytesImage =
    //     Base64Decoder().convert(widget.audiobookdetails.cover_image.toString());
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).pushNamed(AudioBookDetails.routeName, arguments: [
        //   widget.audiobookdetails,
        //   widget.audiobookdetails.cover_image.toString()
        // ]);
        //////////////////
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AudioBookDetails(
              widget.audiobookdetails,
              widget.audiobookdetails.cover_image.toString(),
            ),
          ),
        );
      },
      child: Container(
          margin: EdgeInsets.only(top: 1.0.h, bottom: 1.0.h, left: 2.30.w),
          height: 25.0.h,
          width: 36.0.w,
          decoration: BoxDecoration(
              color: themeProvider.isDarkMode
                  ? Colors.grey.shade900
                  : Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 1,
                    spreadRadius: 1,
                    offset: Offset.zero)
              ]),
          child: Column(
            children: [
              Expanded(
                flex: 10,
                child: CachedNetworkImage(
                  imageUrl:
                      "https://res.cloudinary.com/boichitro/${widget.audiobookdetails.cover_image.toString()}",
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(05),
                            topRight: Radius.circular(05)),
                        image: DecorationImage(
                            image:
                                imageProvider, // image: AssetImage('assets/Music-Icon.png'),
                            fit: BoxFit.fill)),
                  ),
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),

              // SizedBox(height: 0.5.h),
              Expanded(
                flex: 2,
                child: Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(
                      left: 02.0.w,
                      right: 02.0.w,
                    ),
                    child: AutoSizeText(widget.audiobookdetails.bookname ?? ' ',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 1.5.h,

                          // color: Colors.black
                        ))),
              ),
              widget.audiobookdetails.is_paid == true
                  ? Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: GestureDetector(
                              onDoubleTap: () {},
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 2.0.w, bottom: 0.5.h, top: 0.4.h),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        bottomLeft: Radius.circular(5)),
                                    //color: Colors.white,
                                    border: Border.all(
                                      width: 1.5,
                                      color: Color(0xffb8242a),
                                    )),
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: 0.5.h, left: .50.w, bottom: 0.5.h),
                                  child: Center(
                                      child: Text(
                                    'Free',
                                    style: TextStyle(fontSize: 1.0.h),
                                  )),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: GestureDetector(
                              onTap: () {
                                // Navigator.of(context).pushNamed(AudioBookDetails.routeName, arguments: [
                                //   widget.audiobookdetails,
                                //   widget.audiobookdetails.cover_image.toString()
                                // ]);
                                //////////////////
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AudioBookDetails(
                                      widget.audiobookdetails,
                                      widget.audiobookdetails.cover_image
                                          .toString(),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                  margin: EdgeInsets.only(
                                      bottom: 0.5.h, top: 0.4.h, right: 1.0.w),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(2),
                                          bottomRight: Radius.circular(2)),
                                      color: Color(0xffb8242a),
                                      border: Border.all(
                                        width: 1.5,
                                        color: Color(0xffb8242a),
                                      )),
                                  child: Center(
                                    child: AutoSizeText(LocaleKeys.listen.tr(),
                                        //readnow,
                                        minFontSize: 3,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal)),
                                  )),
                            ),
                          )
                        ],
                      ))
                  : Container(),

              //color: Colors.white,

              widget.audiobookdetails.is_paid == false
                  ? Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.of(context).pushNamed(AudioBookDetails.routeName, arguments: [
                          //   widget.audiobookdetails,
                          //   widget.audiobookdetails.cover_image.toString()
                          // ]);
                          //////////////////
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AudioBookDetails(
                                widget.audiobookdetails,
                                widget.audiobookdetails.cover_image.toString(),
                              ),
                            ),
                          );
                        },
                        child: Container(
                            margin: EdgeInsets.only(
                              top: 0.4.h,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5)),
                                color: Color(0xffb8242a),
                                border: Border.all(
                                  width: 1.5,
                                  color: Color(0xffb8242a),
                                )),
                            child: Center(
                              child: AutoSizeText(LocaleKeys.listen.tr(),
                                  //readnow,
                                  minFontSize: 3,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal)),
                            )),
                      ),
                    )
                  : Container(),
            ],
          )),
    );
  }
}
