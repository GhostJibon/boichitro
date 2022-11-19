import 'package:dhanshirisapp/provider/theme_provider.dart';
import 'package:dhanshirisapp/screen/History/history_page.dart';
import 'package:dhanshirisapp/screen/about_app.dart';
import 'package:dhanshirisapp/screen/book_request/book_requested_screen.dart';
import 'package:dhanshirisapp/screen/wishlist/my_wishlist.dart';
import 'package:dhanshirisapp/screen/auth/login_screen.dart';
import 'package:dhanshirisapp/screen/setting.dart';
import 'package:dhanshirisapp/screen/user/user_profile.dart';
import 'package:dhanshirisapp/translations/locale_keys.g.dart';
import 'package:dhanshirisapp/widget/drower_customer/drawer_list_box.dart';
import 'package:dhanshirisapp/widget/drower_customer/line_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../screen/about page/aboutpage.dart';
import '../../screen/setting/setting.dart';

class AppDrawerCustomer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return new Drawer(
      backgroundColor: Color(0xffd3b6b6),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 8.0.h,
            ),

            Container(
              height: 75.0.h,
              child: Column(
                children: [
                  Container(
                    //   width: 60.0.w,
                    height: 12.0.h,
                    // color: Color(0xffc60e13),
                    margin: EdgeInsets.only(
                        bottom: 3.0.h, left: 5.0.h, right: 5.0.h),

                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,

                    decoration: BoxDecoration(
                        image:
                            //  themeProvider.isDarkMode
                            //     ? DecorationImage(
                            //         image: AssetImage('assets/logo_white.png'))
                            //     :
                            DecorationImage(
                                image: AssetImage('assets/logo.png'))),
                    // child: Text(
                    //   LocaleKeys.boichitro.tr(),
                    //   // TODO: has to make this a reusable widget
                    //   style: TextStyle(
                    //       color: Color(0xffc60e13),
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 3.5.h),
                    // ),
                  ),
                  SizedBox(
                    height: 3.0.h,
                  ),
                  DrawerListBox(
                    // title: "My Profile",
                    title: LocaleKeys.myprofile.tr(),
                    image: 'assets/profile.png',
                    onTap: () {
                      Navigator.of(context).pushNamed(ProfileInfo.routeName);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ProfileInfo()));
                    },
                  ),
                  LineBox(),
                  DrawerListBox(
                    //   title: "Help",
                    title: LocaleKeys.about.tr(),
                    image: 'assets/about.png',
                    onTap: () {
                      Navigator.of(context).pushNamed(AboutPage.routeName);
                      // Navigator.pushNamed(context,
                      //     MaterialPageRoute(builder: (context) => AboutPage.routeName));
                    },
                  ),
                  LineBox(),
                  DrawerListBox(
                    //  title: "Subscribe",
                    title: LocaleKeys.history.tr(),
                    image: 'assets/history.png',
                    onTap: () {
                      Navigator.of(context).pushNamed(HistoryPage.routeName);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => HistoryPage()));
                    },
                  ),
                  LineBox(),
                  DrawerListBox(
                    //  title: "Subscribe",
                    title: LocaleKeys.mywishlist.tr(),
                    image: 'assets/mywishlist.png',
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(FavouriteScreen.routeName);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => FavouriteScreen()));
                    },
                  ),

                  LineBox(),
                  DrawerListBox(
                    title: LocaleKeys.book_request.tr(),

                    // " Requested ",
                    //title: LocaleKeys.subscribe.tr(),
                    image: 'assets/bookrequest.png',
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(BookRequestingScreen.routeName);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => BookRequestingScreen()));
                    },
                  ),
                  LineBox(),
                  DrawerListBox(
                    // title: "Setting",
                    title: LocaleKeys.settings.tr(),
                    image: 'assets/setting.png',
                    onTap: () {
                      Navigator.of(context).pushNamed(Setting.routeName);
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => Setting()));
                    },
                  ),

                  LineBox(),
                  // DrawerListBox(
                  //     //     title: "Terms & conditions",
                  //     title: LocaleKeys.termsconditions.tr(),
                  //     icon: Icons.article,
                  //     onTap: () {}),
                  DrawerListBox(

                      //title: "Log Out",
                      title: LocaleKeys.logout.tr(),
                      image: 'assets/logout.png',
                      onTap: () async {
                        final storage = new FlutterSecureStorage();
                        await storage.deleteAll();
                        Navigator.of(context).pushNamed(LoginScreen.routeName);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => LoginScreen()));
                      }),
                  LineBox(),
                ],
              ),
            ),

            //  Expanded(flex: 7, child: Container()),
          ],
        ),
      ),
    );
  }
}
