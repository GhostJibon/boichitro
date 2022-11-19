import 'package:dhanshirisapp/screen/setting/dark_mode_toggler.dart';
import 'package:dhanshirisapp/screen/setting/language_select.dart';
import 'package:dhanshirisapp/constants/brightness.dart';
import 'package:dhanshirisapp/provider/theme_provider.dart';
import 'package:dhanshirisapp/res/colors.dart';
import 'package:dhanshirisapp/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sizer/sizer.dart';

class Setting extends StatelessWidget {
  static const routeName = '/setting';
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
            LocaleKeys.settings.tr(),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              // color: AppColorFactory.appPrimaryColor,
              height: 10.h,
            ),
            Container(
              height: 78.35.h,
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
                  ),
                  // color: Color(0xffd3b6b6),
                  //themeProvider.isDarkMode ? Colors.white : Colors.grey,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 3.0.h,
                  ),
                  SettingOfDropDownItem(),
                  SettingOfDarkModeToggler(),
                  Brightness(),
                  Padding(
                    //  padding: EdgeInsets.only(top: 32.9.h),
                    padding: EdgeInsets.only(top: 37.35.h),
                    child: Container(
                      // height: 13.0.h,
                      // width: 100.0.w,
                      child: Image(
                        image: AssetImage(
                          'assets/sriti_shoudho2.png',
                        ),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
