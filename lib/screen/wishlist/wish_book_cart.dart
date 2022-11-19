import 'dart:convert';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dhanshirisapp/constants/app_constants.dart';
import 'package:dhanshirisapp/provider/auth.dart';
import 'package:dhanshirisapp/provider/deshboard.dart';
import 'package:dhanshirisapp/provider/favourit_list.dart';
import 'package:dhanshirisapp/provider/subcription.dart';
import 'package:dhanshirisapp/provider/theme_provider.dart';
import 'package:dhanshirisapp/screen/book_api_call.dart';
import 'package:dhanshirisapp/screen/user/user_profile_edit.dart';
import 'package:dhanshirisapp/screen/wishlist/my_wishlist_details.dart';
import 'package:dhanshirisapp/services/secure_storage_service.dart';
import 'package:dhanshirisapp/widget/carosel_image_slider.dart';
import 'package:dhanshirisapp/widget/custom_dialog.dart';
import 'package:dhanshirisapp/widget/price_cart.dart';
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
import 'dart:typed_data';

class WishBookCart extends StatefulWidget {
  final bookdetails;
  WishBookCart({required this.bookdetails});

  @override
  _BookCartState createState() => _BookCartState();
}

class _BookCartState extends State<WishBookCart> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  build(BuildContext context) {
    Uint8List _bytesImage;
    // _bytesImage =
    //     Base64Decoder().convert(widget.bookdetails.cover_image.toString());
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        // _showModalBottomSheet(widget.bookdetails, _bytesImage, themeProvider);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WishlistBookDetails(
              widget.bookdetails,
              widget.bookdetails.cover_image.toString(),
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
                      "https://res.cloudinary.com/boichitro/${widget.bookdetails.cover_image.toString()}",
                  imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(05),
                              topRight: Radius.circular(05)),
                          image: DecorationImage(
                              image: imageProvider,

                              // MemoryImage(_bytesImage),
                              fit: BoxFit.fill))),
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
                    child: AutoSizeText(widget.bookdetails.short_name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ))),
              ),
              Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 6,
                          child: Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(
                                left: 02.0.w,
                              ),
                              child: AutoSizeText(
                                widget.bookdetails.bookname.toString(),
                                style: TextStyle(),
                                maxLines: 1,
                                minFontSize: 9,
                              ))),
                      Expanded(
                          flex: 3,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  child: Center(
                                    child: Icon(
                                      Icons.star_outline_outlined,
                                      color: Colors.orange,
                                      size: 15,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                      margin: EdgeInsets.only(right: 1.0.w),
                                      child: Center(
                                          child: AutoSizeText(
                                              widget.bookdetails.rating,
                                              style: TextStyle()))))
                            ],
                          ))
                    ],
                  )),
              widget.bookdetails.is_paid == true
                  ? Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                                margin: EdgeInsets.only(
                                    left: 2.0.w, bottom: 0.5.h, top: 0.4.h),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        bottomLeft: Radius.circular(5)),
                                    color: Colors.white,
                                    border: Border.all(
                                      width: 1.5,
                                      color: Color(0xffb8242a),
                                    )),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 3,
                                        child: Container(
                                            // color: themeProvider.isDarkMode
                                            //     ? Colors.grey.shade900
                                            //     : Colors.white,
                                            margin: EdgeInsets.only(
                                              right: 01.0.w,
                                              left: 01.0.w,
                                            ),
                                            child: Center(
                                                child: Text(
                                              'Subcription',
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize: 1.0.h,
                                                  color: Colors.black),
                                            )))),
                                  ],
                                )),
                          ),
                          Expanded(
                            flex: 3,
                            child: GestureDetector(
                              onTap: () {
                                //---------------- Subcription ---------------
                                if (authProvider.userInfodata!.email != '' &&
                                    (authProvider.userInfodata!.phone != '') &&
                                    authProvider.userInfodata!.full_name !=
                                        '' &&
                                    (authProvider.userInfodata!.gender ==
                                            "Male" ||
                                        authProvider.userInfodata!.gender ==
                                            "Female")) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BookApiCall(
                                                book_id:
                                                    widget.bookdetails.book_id,
                                                book_name: widget
                                                    .bookdetails.bookname
                                                    .toString(),
                                              )));
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UserProfileEdit(
                                                profiledata: authProvider,
                                                checkdata: 1,
                                                bookid:
                                                    widget.bookdetails.book_id,
                                                bookname: widget
                                                    .bookdetails.bookname
                                                    .toString(),
                                              )));
                                }
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
                                    child: AutoSizeText(LocaleKeys.readnow.tr(),
                                        minFontSize: 5,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal)),
                                  )),
                            ),
                          )
                        ],
                      ))
                  : Expanded(
                      flex: 3,
                      child: GestureDetector(
                        onTap: () {
                          //---------------- Subcription ---------------
                          if (authProvider.userInfodata!.email != '' &&
                              (authProvider.userInfodata!.phone != '') &&
                              authProvider.userInfodata!.full_name != '' &&
                              (authProvider.userInfodata!.gender == "Male" ||
                                  authProvider.userInfodata!.gender ==
                                      "Female")) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookApiCall(
                                          book_id: widget.bookdetails.book_id,
                                          book_name: widget.bookdetails.bookname
                                              .toString(),
                                        )));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserProfileEdit(
                                          profiledata: authProvider,
                                          checkdata: 1,
                                          bookid: widget.bookdetails.book_id,
                                          bookname: widget.bookdetails.bookname
                                              .toString(),
                                        )));
                          }
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
                              child: AutoSizeText(LocaleKeys.readnow.tr(),
                                  minFontSize: 5,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal)),
                            )),
                      ),
                    ),
            ],
          )),
    );
  }
}
