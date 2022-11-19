import 'package:dhanshirisapp/provider/theme_provider.dart';
import 'package:dhanshirisapp/translations/locale_keys.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:dhanshirisapp/screen/setting/language_select.dart';
import 'package:dhanshirisapp/widget/change_theme_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../res/colors.dart';

class SettingOfDropDownItem extends StatefulWidget {
  // var dropdownValue;

  // var dropDownValues;

  // SettingOfDropDownItem({
  //   required this.dropdownValue,
  //   required this.dropDownValues,
  // });
  @override
  _SettingOfDropDownItemState createState() => _SettingOfDropDownItemState();
}

class _SettingOfDropDownItemState extends State<SettingOfDropDownItem> {
  String? dropdownValue = 'English';

  bool values = true;

  List<String> lanvalur = ['English', 'বাংলা'];

  void sharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var a = await prefs.get('language');
    print(a);
    if (LocaleKeys.name.tr() == "Name") {
      setState(() {
        dropdownValue = "English";
      });
    } else {
      setState(() {
        dropdownValue = "বাংলা";
      });
    }
    // if (a != null) {
    //   setState(() {
    //     dropdownValue = a.toString();
    //   });
    // }
  }

  @override
  void initState() {
    sharedPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Container(
      margin: new EdgeInsets.all(10),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 4.0.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColorFactory.appPrimaryColor,
                ),
                width: 15.0.w,
                child: Center(
                    child: Icon(
                  Icons.language,
                  color: Colors.white,
                  size: 19,
                )),
              ),
              // Container(
              //   height: 4.0.h,
              //   decoration: BoxDecoration(shape: BoxShape.circle),
              //   width: 15.0.w,
              //   child: Center(
              //       child: Icon(
              //     Icons.language,
              //     // color: Colors.black,
              //     size: 19,
              //   )),
              // ),
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
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: Text(LocaleKeys.language.tr(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 1.9.h,
                        )),
                  ),
                  SizedBox(
                    width: 30.0.w,
                  ),
                  Container(
                    // padding: EdgeInsets.only(
                    //   right: 08.0.w,
                    //   top: 4.0.h,
                    // ),

                    // ignore: missing_required_param

                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        // isExpanded: true,
                        //  dropdownColor: Color(0xffc60e13),
                        dropdownColor: themeProvider.isDarkMode
                            ? Colors.grey.shade900
                            : Colors.white,
                        style: TextStyle(fontSize: 2.0.h),
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_drop_down_sharp),
                        iconSize: 20,
                        elevation: 0,

                        // underline: Container(
                        //   height: 1,
                        //   color: Color(0xFFdab13c),
                        // ),
                        onChanged: (newValue) async {
                          if (newValue == "English") {
                            dropdownValue = newValue;
                            await context.setLocale(Locale('en'));
                          } else {
                            dropdownValue = newValue;
                            await context.setLocale(Locale('bn'));
                          }
                        },
                        items: lanvalur
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style: TextStyle(
                                  color: themeProvider.isDarkMode
                                      ? Colors.white
                                      : Colors.grey.shade900,
                                )),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          ////////////
        ],
      ),
    );
  }
}
