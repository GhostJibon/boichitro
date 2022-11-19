import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dhanshirisapp/constants/app_constants.dart';
import 'package:dhanshirisapp/provider/auth.dart';
import 'package:dhanshirisapp/provider/profiledata.dart';
import 'package:dhanshirisapp/screen/Deshboard.dart/Dashboard.dart';
import 'package:dhanshirisapp/screen/History/history_page.dart';
import 'package:dhanshirisapp/screen/auth/login_screen.dart';
import 'package:dhanshirisapp/services/secure_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../provider/theme_provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _LoadinScreenState createState() => _LoadinScreenState();
}

class _LoadinScreenState extends State<SplashScreen> {
  String message = 'check';

  Future _authCheck(BuildContext context) async {
    AuthProvider profileModel =
        Provider.of<AuthProvider>(context, listen: false);
    // var token;
    // await SecureStorageService().writeValue(
    //     key: AUTH_TOKEN_KEY,
    //     value:
    //         '3e21293c1dbbf030142eecb316a58da37cef5535094f61017dcb5a0b99fd6691');
    var token = await SecureStorageService().readValue(key: AUTH_TOKEN_KEY);
    if (token != null) {
      final Map<String, dynamic> authentication =
          await profileModel.authenticationProfiledata(token.toString());

      print(authentication);
      message = authentication['message'];
      if (authentication['success']) {
        // go to dahsboard
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Dashboard()));
      } else if (authentication['message'] == "Loginscreen") {
        Navigator.of(context).pushNamed(LoginScreen.routeName);
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => LoginScreen()));
      } else if (authentication['message'] == "No Internet") {
        Navigator.of(context).pushNamed(HistoryPage.routeName);
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => HistoryPage()));
      }
    } else {
      Timer(
        Duration(seconds: 2),
        () {
          // go to login screen
          Navigator.of(context).pushNamed(LoginScreen.routeName);
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => LoginScreen()));
        },
      );
    }
  }

  @override
  void didChangeDependencies() {
    _authCheck(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('----main splash screen----');
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(0),
          padding: EdgeInsets.all(0),
          height: 100.0.h,
          // width: 100.0.w,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/backgroundImage03.png',
                  ),
                  fit: BoxFit.cover)),
          child: Column(
            children: [
              Container(
                height: 15.0.h,
                width: 35.0.w,
                margin: EdgeInsets.only(
                  left: 32.0.w,
                  right: 32.0.w,
                  top: 38.0.h,
                ),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset.zero,
                        blurRadius: 3,
                        spreadRadius: 4)
                  ],
                  // image: DecorationImage(
                  //     image: AssetImage('assets/loading_gif.gif'))
                ),
                child: Image(
                  image: AssetImage('assets/loading_gif.gif'),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5.0.h),
                height: 7.0.h,
                child: Center(
                  child: AutoSizeText(
                    message == "Please Check your Internet Connection"
                        ? "Please Check your Internet Connection"
                        : 'Loading...',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      // fontSize: 3.5.h,

                      color: Color(0xffb8242a),
                    ),
                  ),
                ),
              ),
              Center(
                  child: Container(
                height: 15.0.h,
                width: 35.0.w,
                margin: EdgeInsets.only(top: 10.0.h),
                decoration: BoxDecoration(
                    image: themeProvider.isDarkMode
                        ? DecorationImage(
                            image: AssetImage('assets/logo_white.png'))
                        : DecorationImage(image: AssetImage('assets/logo.png'))

                    //  DecorationImage(image: AssetImage('assets/logo.png')),
                    ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
