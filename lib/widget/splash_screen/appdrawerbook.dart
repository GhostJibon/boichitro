import 'package:dhanshirisapp/provider/order.dart';
import 'package:dhanshirisapp/screen/auth/login_screen.dart';
import 'package:dhanshirisapp/screen/setting.dart';
import 'package:dhanshirisapp/screen/setting/setting.dart';
import 'package:dhanshirisapp/screen/user/user_profile.dart';
import 'package:dhanshirisapp/translations/locale_keys.g.dart';
import 'package:dhanshirisapp/widget/change_theme_button_widget.dart';
import 'package:dhanshirisapp/widget/drower_customer/drawer_list_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

class AppDrawerBook extends StatefulWidget {
  final Orther orther;
  AppDrawerBook({required this.orther});
  @override
  _AppDrawerBookState createState() => _AppDrawerBookState();
}

class _AppDrawerBookState extends State<AppDrawerBook> {
  double _currentSliderValue = 20;
  String? dropdownValue = 'Bensenhandwriti';

  bool values = true;

  List<String> lanvalur = [
    'Bensenhandwriti',
    'Muktinarrow',
    'Mitra',
    "Adorsholipi"
  ];
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // DrawerListBox is contain 2 data title ,and function,
          SizedBox(
            height: 5.0.h,
          ),
          Container(
            height: 5.0.h,
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      Container(
                        height: 5.0.h,
                        width: 20.0.w,
                        child: IconButton(
                          icon: Icon(Icons.arrow_forward),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Container(
                          width: 30.0.w,
                          child: Text('Quick Tools',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 2.0.h,
                              ))),
                      Container(
                        height: 5.0.h,
                        width: 20.0.w,
                        child: IconButton(
                          icon: Icon(Icons.settings),
                          onPressed: () {
                            Navigator.of(context).pushNamed(Setting.routeName);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => Setting()));
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 2.0.h,
          ),
          Container(
            margin: EdgeInsets.only(left: 4.0.w),
            height: 5.0.h,
            child: Row(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  height: 4.0.h,
                  width: 10.0.w,
                  child: Icon(
                    Icons.grid_4x4_rounded,
                    color: Colors.grey,
                  ),
                ),
                Container(
                    height: 4.0.h,
                    width: 35.0.w,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Bangle Font Size',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                        fontSize: 1.6.h,
                      ),
                    )),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                height: 4.0.h,
                width: 45.0.w,
                margin: EdgeInsets.only(left: 05.0.w),
                child: Slider(
                  value: _currentSliderValue,
                  min: 11,
                  max: 30,
                  divisions: 19,
                  label: _currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                  },
                ),
              ),
              Container(
                  height: 4.0.h,
                  width: 20.0.w,
                  child: Center(child: Text(_currentSliderValue.toString())))
            ],
          ),
          SizedBox(
            height: 3.0.h,
          ),
          Container(
            margin: EdgeInsets.only(
              left: 02.0.w,
            ),
            child: Row(
              children: [
                Container(
                  height: 4.0.h,
                  decoration: BoxDecoration(
                      color: Colors.black12, shape: BoxShape.circle),
                  width: 12.0.w,
                  child: Center(
                      child: Icon(
                    Icons.language,
                    color: Colors.grey[700],
                    size: 19,
                  )),
                ),
                SizedBox(
                  width: 03.0.w,
                ),
                Container(
                  width: 23.0.w,
                  child: Text('Bangla Font',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                        fontSize: 1.6.h,
                      )),
                ),
                SizedBox(
                  width: 01.0.w,
                ),
                Container(
                  width: 30.0.w,
                  // padding: EdgeInsets.only(
                  //   right: 08.0.w,
                  //   top: 4.0.h,
                  // ),

                  alignment: Alignment.centerLeft,

                  // ignore: missing_required_param

                  child: DropdownButton<String>(
                    // isExpanded: true,
                    dropdownColor: Colors.white,
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 1.3.h,
                        fontWeight: FontWeight.bold),
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_drop_down_sharp),
                    iconSize: 15,
                    elevation: 0,

                    underline: Container(
                      height: 0,
                      color: Color(0xFFdab13c),
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        widget.orther.fontmethod(newValue.toString());
                        dropdownValue = newValue;
                      });

                      // if (newValue == "Eng") {
                      //   dropdownValue = newValue;
                      //   await context.setLocale(Locale('en'));
                      // } else {
                      //   dropdownValue = newValue;
                      //   await context.setLocale(Locale('bn'));
                      // }
                    },
                    items:
                        lanvalur.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            height: 2.0.h,
          ),
          Container(
            margin: EdgeInsets.only(
              left: 2.0.w,
            ),
            child: Row(
              children: [
                Container(
                  height: 4.0.h,
                  decoration: BoxDecoration(
                      color: Colors.black12, shape: BoxShape.circle),
                  width: 15.0.w,
                  child: Center(
                      child: Icon(
                    Icons.bedtime_sharp,
                    color: Colors.blue,
                    size: 19,
                  )),
                ),
                SizedBox(
                  width: 02.0.w,
                ),
                Container(
                  child: Text('Dark Mode',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                        fontSize: 1.6.h,
                      )),
                ),
                SizedBox(
                  width: 02.0.w,
                ),
                //   ThemeDropdownButton()
                ChangeThemeButtonWidget(),
                // ThemeDropdownButton()
                // Switch(
                //     value: values,
                //     onChanged: (val) {
                //       setState(() {
                //         values = val;
                //       });
                //     }),
              ],
            ),
          )
          //  Expanded(flex: 7, child: Container()),
        ],
      ),
    );
  }
}
