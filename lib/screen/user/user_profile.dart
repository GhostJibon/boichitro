import 'dart:async';

import 'package:dhanshirisapp/components/list_item.dart';
import 'package:dhanshirisapp/provider/auth.dart';
import 'package:dhanshirisapp/res/colors.dart';
import 'package:dhanshirisapp/screen/book_request/book_request.dart';
import 'package:dhanshirisapp/screen/user/user_profile_edit.dart';
import 'package:dhanshirisapp/provider/theme_provider.dart';
import 'package:dhanshirisapp/translations/locale_keys.g.dart';
import 'package:dhanshirisapp/widget/drower_customer/line_box.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProfileInfo extends StatefulWidget {
  static const routeName = '/profile-info';
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfileInfo> {
  var settingList = [
    SettingItem(LocaleKeys.myprofile.tr(), Icons.people_alt),
    SettingItem(LocaleKeys.bookrequest.tr(), Icons.book),
  ];
  build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    AuthProvider _profiledata =
        Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: AppColorFactory.appPrimaryColor,
      appBar: AppBar(
          backgroundColor: AppColorFactory.appPrimaryColor,
          elevation: 0,
          title: Text(
            LocaleKeys.profile.tr(),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            new Container(
              //  height: MediaQuery.of(context).size.height * .25,
              height: 26.00.h,
              color: Color(0xffc60e13),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 1.0.h,
                    ),
                    Center(
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            child: CircleAvatar(
                              radius: 60.0,
                              backgroundColor: Colors.white,
                              // backgroundImage: AssetImage(
                              //   'assets/logo.png',

                              // ),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Image(
                                  image: AssetImage(
                                    'assets/logo.png',
                                  ),
                                ),
                              ),
                            ),
                          )),
                    ),
                    new Consumer<AuthProvider>(
                        builder: (context, model, child) {
                      return Container(
                        height: 8.0.h,
                        width: 100.0.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 1.0.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  model.userInfodata!.full_name.toString(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                // Icon(Icons.edit)
                              ],
                            ),
                            Text(
                              model.userInfodata!.phone ==
                                          model.userInfodata!.phone ||
                                      model.userInfodata!.phone == 'null'
                                  ? ' '
                                  : model.userInfodata!.phone,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ]),
            ),
            new Container(
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
                      // [
                      //   Color(0xffD3B6B6),
                      //   Color(0xffFFFFFF),
                      // ],
                    ),
                    //themeProvider.isDarkMode ? Colors.white : Colors.grey,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                height: 62.35.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    new Container(
                        margin: EdgeInsets.only(top: 2.0.h),
                        height: 40.0.h,
                        width: 80.0.w,
                        child: ListView.builder(
                            // padding: EdgeInsets.all(0),
                            shrinkWrap: false,
                            scrollDirection: Axis.vertical,
                            itemCount: settingList.length,
                            itemBuilder: (context, index) {
                              final item = settingList[index];
                              return GestureDetector(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                        title: item.buildTitle(context),
                                        subtitle: item.buildSubtitle(context),
                                        onTap: () {
                                          var nextPage;
                                          switch (index) {
                                            case 0:
                                              nextPage = UserProfileEdit(
                                                profiledata: _profiledata,
                                                checkdata: 0,
                                                bookid: 0,
                                                bookname: 'text',
                                              );

                                              break;
                                            // case 1:
                                            //   nextPage = SubscriptionScreen();
                                            //   break;

                                            case 1:
                                              nextPage = BookRequest();
                                              break;
                                            default:
                                              return;
                                          }
                                          // TODO: Make your routes from here
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      nextPage));
                                        }),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      width: 50.0.w,
                                      child: LineBox(),
                                    )
                                  ],
                                ),
                              );
                            })),
                    Padding(
                      padding: EdgeInsets.only(top: 11.85.h),
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
                )),
          ],
        ),
      ),
    );
  }
}
