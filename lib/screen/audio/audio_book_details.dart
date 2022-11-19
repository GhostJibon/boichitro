import 'dart:convert';
import 'dart:typed_data';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dhanshirisapp/constants/app_constants.dart';
import 'package:dhanshirisapp/provider/deshboard.dart';
import 'package:dhanshirisapp/provider/favourit_list.dart';
import 'package:dhanshirisapp/provider/subcription.dart';
import 'package:dhanshirisapp/provider/theme_provider.dart';
import 'package:dhanshirisapp/screen/book_api_call.dart';
import 'package:dhanshirisapp/services/secure_storage_service.dart';
import 'package:dhanshirisapp/widget/carosel_image_slider.dart';
import 'package:dhanshirisapp/widget/page_manager.dart';
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
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AudioBookDetails extends StatefulWidget {
  static const routeName = '/audioBook-details';
  final recentlist;
  final bytesImage;

  AudioBookDetails(
    this.recentlist,
    this.bytesImage,
  );

  @override
  State<AudioBookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<AudioBookDetails> {
  late final PageManager _pageManager;

  @override
  void initState() {
    // HistoryProvider historyProvider =
    //     Provider.of<HistoryProvider>(context, listen: false);
    print(
        '----------------------------------Book_Details ---------------------------');
    super.initState();
    _pageManager = PageManager();
    pageManager();
  }

  pageManager() async {
    // dynamic videos ;
    await _pageManager.audiofile(
        'http://test.boichitro.com.bd/media/audio_books/sany-you-have-a-call.mp3');
    await _pageManager.initcall();
  }

  @override
  void dispose() {
    _pageManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Uint8List _bytesImage;
    // _bytesImage =
    //     Base64Decoder().convert(widget.recentlist.cover_image.toString());
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xffc60e13)),
      body: SingleChildScrollView(
        child: Container(
          height: 90.0.h,
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
          child: Column(
            children: [
              Container(
                height: 30.0.h,
                width: 100.0.w,
                child: Row(
                  children: [
                    Column(
                      children: [
                        CachedNetworkImage(
                          imageUrl:
                              "https://res.cloudinary.com/boichitro/${widget.recentlist.cover_image.toString()}",
                          imageBuilder: (context, imageProvider) => Container(
                            height: 22.0.h,
                            margin: EdgeInsets.only(
                              top: 2.5.h,
                              left: 5.0.w,
                              right: 3.0.w,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: imageProvider,
                                    //  image: MemoryImage(_bytesImage),
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
                                  // height: 2.0.h,
                                  width: 50.0.w,
                                  child: Text(
                                    // ' abcd',
                                    widget.recentlist.bookname ?? ' ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 1.5.h),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 2.0.h,
                          ),
                          // PopUpScreen(
                          //   //   name: "Name",
                          //   name: LocaleKeys.name.tr(),
                          //   title: recentlist.bookname.toString(),
                          // ),

                          PopUpScreen(
                            // name: "Writer Name",
                            name: LocaleKeys.writername.tr(),
                            //title: ' abcd',
                            title: widget.recentlist.author ?? ' ',
                          ),
                          PopUpScreen(
                              //name: "Publications",
                              name: LocaleKeys.publicaions.tr(),
                              //title: ' abcd',
                              title: widget.recentlist.publisher ?? ' '),
                          PopUpScreen(
                              //  name: "Version",
                              name: LocaleKeys.version.tr(),
                              //  title: ' abcd',
                              title: widget.recentlist.edition ?? ' '),
                          PopUpScreen(
                            name: "ISBN",
                            //title: ' abcd',
                            title: widget.recentlist.isbn ?? ' ',
                          ),
                          Row(children: [
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
                                height: 3.1.h,
                                width: 30.0.w,
                                margin: EdgeInsets.only(bottom: 1.4.h),
                                child: RatingBarIndicator(
                                    rating: double.parse(
                                        widget.recentlist.rating.toString()),
                                    //   widget.recentlist.rating.toString()),
                                    itemBuilder: (context, index) => Icon(
                                          Icons.star,
                                          // color: Colors.amber,
                                        ),
                                    itemCount: 5,
                                    itemSize: 17.0,
                                    direction: Axis.horizontal)),
                          ])
                        ],
                      ),
                    )
                  ],
                ),
              ),
///////================================----  Audio Book ----------------------------
              SizedBox(
                height: 2.0.h,
              ),
              Container(
                  height: 30.0.h,
                  width: 100.0.w,
                  margin: EdgeInsets.only(left: 05.0.w, right: 05.0.w),
                  child: SingleChildScrollView(
                    child: Text(
                      widget.recentlist.cover_note,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 1.7.h, fontWeight: FontWeight.normal),
                    ),
                  )),
              SizedBox(
                height: 2.0.h,
              ),
              Container(
                height: 20.0.h,
                width: 100.0.w,
                margin: EdgeInsets.only(left: 8.0.w, right: 8.0.w),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Center(
                    child: WebView(
                  initialUrl: widget.recentlist.description,

                  // initialUrl:
                  //     'https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/1216818949%3Fsecret_token%3Ds-UuOzIxSiZiw&color=%23ff5500&auto_play=true&hide_related=false&show_comments=true&show_user=true&show_reposts=false&show_teaser=true&visual=true',
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {},
                  onPageStarted: (String url) {
                    print('Page started loading: $url');
                  },
                  onPageFinished: (String url) {
                    print('Page finished loading: $url');
                  },
                  gestureNavigationEnabled: true,
                )),
              )
              // Container(
              //   margin:
              //       EdgeInsets.only(left: 05.0.w, right: 05.0.w, top: 2.0.h),
              //   child: Column(
              //     children: [
              //       // Spacer(),

              //       ValueListenableBuilder<ProgressBarState>(
              //         valueListenable: _pageManager.progressNotifier,
              //         builder: (_, value, __) {
              //           return ProgressBar(
              //             progress: value.current,
              //             buffered: value.buffered,
              //             total: value.total,
              //             onSeek: _pageManager.seek,
              //           );
              //         },
              //       ),
              //       ValueListenableBuilder<ButtonState>(
              //         valueListenable: _pageManager.buttonNotifier,
              //         builder: (_, value, __) {
              //           switch (value) {
              //             case ButtonState.loading:
              //               return Container(
              //                 margin: EdgeInsets.all(8.0),
              //                 width: 32.0,
              //                 height: 32.0,
              //                 child: CircularProgressIndicator(),
              //               );
              //             case ButtonState.paused:
              //               return IconButton(
              //                 icon: Icon(Icons.play_arrow),
              //                 iconSize: 32.0,
              //                 onPressed: _pageManager.play,
              //               );
              //             case ButtonState.playing:
              //               return IconButton(
              //                 icon: Icon(Icons.pause),
              //                 iconSize: 32.0,
              //                 onPressed: _pageManager.pause,
              //               );
              //           }
              //         },
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
