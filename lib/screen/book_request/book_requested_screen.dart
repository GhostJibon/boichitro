import 'package:dhanshirisapp/constants/app_constants.dart';
import 'package:dhanshirisapp/provider/book_read.dart';
import 'package:dhanshirisapp/provider/deshboard.dart';
import 'package:dhanshirisapp/screen/book_request/widget/book_request_cart.dart';
import 'package:dhanshirisapp/services/secure_storage_service.dart';
import 'package:dhanshirisapp/translations/locale_keys.g.dart';
import 'package:dhanshirisapp/widget/no_data_available.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../provider/theme_provider.dart';
import '../../res/colors.dart';

class BookRequestingScreen extends StatefulWidget {
  static const routeName = '/bookrequest-screen';
  @override
  State<BookRequestingScreen> createState() => _BookRequestingScreenState();
}

class _BookRequestingScreenState extends State<BookRequestingScreen> {
  @override
  void didChangeDependencies() async {
    //------initial call-------
    var token = await SecureStorageService().readValue(key: AUTH_TOKEN_KEY);

    BookReadtModel book = Provider.of<BookReadtModel>(context, listen: false);
    book.fetchbookrequest(token);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: AppColorFactory.appPrimaryColor,
      appBar: AppBar(
        backgroundColor: AppColorFactory.appPrimaryColor,
        elevation: 0,
        title: Text(
          LocaleKeys.book_request_list.tr(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: themeProvider.isDarkMode
                        ? [
                            Colors.grey.shade900,
                            Color.fromARGB(255, 170, 147, 147),
                            // Color(0xffFFFFFF),
                          ]
                        : [
                            Color(0xffD3B6B6),
                            Color(0xffFFFFFF),
                          ],
                    //  [
                    //   Color(0xffD3B6B6),
                    //   Color(0xffFFFFFF),
                    // ],
                  ),
                  //themeProvider.isDarkMode ? Colors.white : Colors.grey,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              height: 88.37.h,
              child: Column(
                children: [
                  SizedBox(
                    height: 4.0.h,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      //  height: 55.0.h,
                      // height: 88.38.h,
                      margin: EdgeInsets.only(left: 01.0.w, bottom: 0.5.h),
                      child: Consumer<BookReadtModel>(
                        child: SizedBox(
                          //  height: 55.0.h,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        builder: (context, modal, child) {
                          return modal.isloadinbookrequest
                              ? child as Widget
                              : modal.bookrequested.length == 0
                                  ? NodataAvailableClass(
                                      'No requested result', 55.0.h)
                                  : ListView.builder(
                                      shrinkWrap: false,
                                      scrollDirection: Axis.vertical,
                                      itemCount: modal.bookrequested.length,
                                      itemBuilder: (context, index) {
                                        final bookrequest =
                                            modal.bookrequested[index];
                                        return BookRequestCart(bookrequest);
                                      });
                        },
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(top: 20.4.h),
                  //   child: Container(
                  //     // height: 13.0.h,
                  //     // width: 100.0.w,
                  //     child: Image(
                  //       image: AssetImage(
                  //         'assets/sriti_shoudho2.png',
                  //       ),
                  //       fit: BoxFit.fitWidth,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
