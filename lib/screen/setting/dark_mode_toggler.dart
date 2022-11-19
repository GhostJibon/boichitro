import 'package:dhanshirisapp/provider/theme_provider.dart';
import 'package:dhanshirisapp/translations/locale_keys.g.dart';
import 'package:dhanshirisapp/widget/change_theme_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../res/colors.dart';

class SettingOfDarkModeToggler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Container(
      margin: new EdgeInsets.all(10),
      child: Row(
        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 4.0.h,
                decoration: BoxDecoration(
                    color: AppColorFactory.appPrimaryColor,
                    shape: BoxShape.circle),
                width: 15.0.w,
                child: Center(
                    child: Icon(
                  Icons.bedtime_sharp,
                  color: Colors.white,
                  size: 19,
                )),
              ),
              SizedBox(
                width: 01.0.w,
              ),
            ],
          ),
          Container(
            width: 72.0.w,
            decoration: BoxDecoration(
              color: AppColorFactory.appPrimaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 03.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Text(LocaleKeys.mode.tr(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 1.9.h,
                        )),
                  ),
                  SizedBox(
                    width: 30.0.w,
                  ),
                  ChangeThemeButtonWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
