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
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class WishlistBookDetails extends StatefulWidget {
  final recentlist;
  final bytesImage;

  WishlistBookDetails(
    this.recentlist,
    this.bytesImage,
  );

  @override
  State<WishlistBookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<WishlistBookDetails> {
  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: widget.recentlist.book_image_url,
        chooserTitle: 'Example Chooser Title');
  }

  @override
  Widget build(BuildContext context) {
    Uint8List _bytesImage;

    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffc60e13),
        title: Text('Book Details'),
      ),
      body:
          //  Container(
          //   child: OrientationBuilder(builder: (context, orientation) {
          //     if (MediaQuery.of(context).orientation == Orientation.portrait) {
          //       print('i am protrait');
          //       return buildProtraits(themeProvider, authProvider);
          //     } else {
          //       print('i am landscape');
          //       return buildLandscapes(themeProvider, authProvider);
          //     }
          //   }),
          // ),

          SingleChildScrollView(
        child: Container(
          width: 100.0.w,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color:
                themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 5.0,
              ),
            ],
          ),
          // height: 60.0.h,
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    //_showMyDialog(context);

                    //---------------- Subcription ---------------
                    if (authProvider.userInfodata!.email != '' &&
                        authProvider.userInfodata!.phone != '' &&
                        authProvider.userInfodata!.full_name != '') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookApiCall(
                                    book_id: widget.recentlist.book_id,
                                    book_name:
                                        widget.recentlist.bookname.toString(),
                                  )));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserProfileEdit(
                                    profiledata: authProvider,
                                    checkdata: 1,
                                    bookid: widget.recentlist.pk,
                                    bookname:
                                        widget.recentlist.bookname.toString(),
                                  )));
                    }
                  },
                  child: Container(
                    height: 33.0.h,
                    width: 100.0.w,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  "https://res.cloudinary.com/boichitro/${widget.recentlist.cover_image.toString()}",
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                height: 17.0.h,
                                margin: EdgeInsets.only(
                                  top: 2.5.h,
                                  left: 4.0.w,
                                  right: 3.0.w,
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5)),
                                    image: DecorationImage(
                                        image: imageProvider,
                                        //MemoryImage(_bytesImage),
                                        fit: BoxFit.fill),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 2,
                                          spreadRadius: 3,
                                          color: Colors.black12,
                                          offset: Offset.zero)
                                    ]),
                                width: 30.0.w,
                              ),
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                            widget.recentlist.is_paid == true
                                ? Container(
                                    height: 3.5.h,
                                    width: 33.0.w,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: GestureDetector(
                                            onDoubleTap: () {},
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: 2.0.w,
                                                  bottom: 0.5.h,
                                                  top: 0.4.h),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft: Radius
                                                              .circular(5),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  5)),
                                                  color:
                                                      themeProvider.isDarkMode
                                                          ? Colors.grey.shade900
                                                          : Colors.white,
                                                  border: Border.all(
                                                    width: 1.5,
                                                    color: Color(0xffb8242a),
                                                  )),
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    top: 0.5.h,
                                                    left: .50.w,
                                                    bottom: 0.5.h),
                                                child: Center(
                                                    child: Text(
                                                  'Subcription',
                                                  style: TextStyle(
                                                      fontSize: 1.0.h),
                                                )),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: GestureDetector(
                                            onTap: () {
                                              //_showMyDialog(context);

                                              //---------------- Subcription ---------------
                                              if (authProvider.userInfodata!.email != '' &&
                                                  authProvider.userInfodata!
                                                          .phone !=
                                                      '' &&
                                                  authProvider.userInfodata!
                                                          .full_name !=
                                                      '') {
                                                print('i have a info');
                                                print(authProvider
                                                    .userInfodata!.email);
                                                print(authProvider
                                                    .userInfodata!.full_name);
                                                print(authProvider
                                                    .userInfodata!.phone);

                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            BookApiCall(
                                                              book_id: widget
                                                                  .recentlist
                                                                  .book_id,
                                                              book_name: widget
                                                                  .recentlist
                                                                  .bookname
                                                                  .toString(),
                                                            )));
                                              } else {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            UserProfileEdit(
                                                              profiledata:
                                                                  authProvider,
                                                              checkdata: 1,
                                                              bookid: widget
                                                                  .recentlist
                                                                  .pk,
                                                              bookname: widget
                                                                  .recentlist
                                                                  .bookname
                                                                  .toString(),
                                                            )));
                                              }
                                            },
                                            child: Container(
                                                margin: EdgeInsets.only(
                                                    bottom: 0.5.h,
                                                    top: 0.4.h,
                                                    right: 1.0.w),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight: Radius
                                                                .circular(2),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    2)),
                                                    color: Color(0xffb8242a),
                                                    border: Border.all(
                                                      width: 1.5,
                                                      color: Color(0xffb8242a),
                                                    )),
                                                child: Center(
                                                  child: AutoSizeText(
                                                      LocaleKeys.readnow.tr(),
                                                      //readnow,
                                                      minFontSize: 3,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight
                                                              .normal)),
                                                )),
                                          ),
                                        )
                                      ],
                                    ))
                                : Container(),
                            // is there have no subcription
                            widget.recentlist.is_paid == false
                                ? Container(
                                    height: 3.5.h,
                                    width: 33.0.w,
                                    margin: EdgeInsets.only(
                                      left: 4.0.w,
                                      right: 3.0.w,
                                    ),
                                    decoration: BoxDecoration(),
                                    child: GestureDetector(
                                      onTap: () {
                                        //_showMyDialog(context);

                                        //---------------- Subcription ---------------
                                        if (authProvider.userInfodata!.email != '' &&
                                            authProvider.userInfodata!.phone !=
                                                '' &&
                                            authProvider
                                                    .userInfodata!.full_name !=
                                                '') {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BookApiCall(
                                                        book_id: widget
                                                            .recentlist.pk,
                                                        book_name: widget
                                                            .recentlist.bookname
                                                            .toString(),
                                                      )));
                                        } else {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UserProfileEdit(
                                                        profiledata:
                                                            authProvider,
                                                        checkdata: 1,
                                                        bookid: widget
                                                            .recentlist.pk,
                                                        bookname: widget
                                                            .recentlist.bookname
                                                            .toString(),
                                                      )));
                                        }
                                      },
                                      child: Container(
                                          margin: EdgeInsets.only(
                                              left: 1.5.w,
                                              bottom: 0.5.h,
                                              // top: 0.4.h,
                                              right: 1.5.w),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(5),
                                                  bottomRight:
                                                      Radius.circular(5)),
                                              color: Color(0xffb8242a),
                                              border: Border.all(
                                                width: 1.5,
                                                color: Color(0xffb8242a),
                                              )),
                                          child: Center(
                                            child: AutoSizeText(
                                                LocaleKeys.readnow.tr(),
                                                //readnow,
                                                minFontSize: 3,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.normal)),
                                          )),
                                    ))
                                : Container(),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 2.0.h, left: 5.0.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  bottom: 0.50.w,
                                ),
                                // height: 2.5.h,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      //height: 2.0.h,
                                      width: 40.0.w,
                                      child: Text(
                                        widget.recentlist.bookname.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 1.8.h),
                                      ),
                                    ),
                                    Consumer<FavouriteProviderModel>(
                                      builder: (context, model, child) {
                                        return Container(
                                          height: 2.50.h,
                                          width: 10.0.w,
                                          child: Align(
                                            child: Center(
                                              child: IconButton(
                                                padding: EdgeInsets.zero,
                                                icon: Icon(Icons.delete,
                                                    size: 2.5.h),
                                                onPressed: () async {
                                                  model.selectProduct(
                                                      widget.recentlist.pk);
                                                  Map<String, dynamic>?
                                                      authmessage = await model
                                                          .toggleProductFavoriteStatusdeleted(
                                                    book_id: widget
                                                        .recentlist.book_id,
                                                  );
                                                  print(authmessage);

                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          duration: Duration(
                                                              seconds: 2),
                                                          backgroundColor:
                                                              Color(0xffc60e13),
                                                          content: Text(
                                                              authmessage![
                                                                  'message'],
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      1.8.h,
                                                                  color: Colors
                                                                      .white))));

                                                  Navigator.pop(context, true);
                                                },
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 1.0.h,
                              ),
                              // PopUpScreen(
                              //   //   name: "Name",
                              //   name: LocaleKeys.name.tr(),
                              //   title: recentlist.bookname.toString(),
                              // ),

                              PopUpScreen(
                                // name: "Writer Name",
                                name: LocaleKeys.writername.tr(),
                                title: widget.recentlist.author.toString(),
                              ),
                              PopUpScreen(
                                //name: "Publications",
                                name: LocaleKeys.publicaions.tr(),
                                title: widget.recentlist.publisher.toString(),
                              ),
                              PopUpScreen(
                                //  name: "Version",
                                name: LocaleKeys.version.tr(),
                                title: widget.recentlist.edition.toString(),
                              ),
                              PopUpScreen(
                                name: "ISBN",
                                title: widget.recentlist.isbn.toString(),
                              ),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 3.1.h,
                                      width: 25.0.w,
                                      child: Text(
                                        LocaleKeys.rating.tr(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 1.5.h),
                                      ),
                                    ),
                                    Container(
                                        height: 2.5.h,
                                        width: 30.0.w,
                                        margin: EdgeInsets.only(bottom: 1.4.h),
                                        child: RatingBarIndicator(
                                            rating: double.parse(widget
                                                .recentlist.rating
                                                .toString()),
                                            itemBuilder: (context, index) =>
                                                Icon(
                                                  Icons.star,
                                                  // color: Colors.amber,
                                                ),
                                            itemCount: 5,
                                            itemSize: 17.0,
                                            direction: Axis.horizontal)),
                                  ]),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 3.1.h,
                                      width: 25.0.w,
                                      child: Text(
                                        LocaleKeys.share.tr(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 1.5.h),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        await share();
                                      },
                                      child: Container(
                                          height: 4.5.h,
                                          width: 30.0.w,
                                          //  margin: EdgeInsets.only(top: .50.h),
                                          child: Center(
                                            child: Icon(
                                              Icons.share,
                                              color: Colors.red,
                                              size: 25,
                                            ),
                                          )),
                                    ),
                                  ])
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                ModalTabBar(
                  aboutNote: widget.recentlist.cover_note.toString(),
                  bookdetails: widget.recentlist,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
