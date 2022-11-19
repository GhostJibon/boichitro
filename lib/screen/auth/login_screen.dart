import 'package:dhanshirisapp/provider/auth.dart';
import 'package:dhanshirisapp/provider/singinmodel.dart';
import 'package:dhanshirisapp/res/colors.dart';
import 'package:dhanshirisapp/screen/Deshboard.dart/Dashboard.dart';
import 'package:dhanshirisapp/screen/auth/dialog.dart';
import 'package:dhanshirisapp/screen/auth/dialog_loader.dart';
import 'package:dhanshirisapp/screen/auth/or_box.dart';
import 'package:dhanshirisapp/screen/first_loadingscreen.dart';
import 'package:dhanshirisapp/screen/auth/otp_screen.dart';
import 'package:dhanshirisapp/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:sms_autofill/sms_autofill.dart';

class LoginScreen extends StatefulWidget {
  @override
  static const routeName = '/login-screen';
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String phone = ' ';
  String phone_no = '';
  bool is_futurebuilder = false;
  bool is_futurebuilders = false;
  String? dropdownValue = 'Eng';

  List<String> lanvalur = ['Eng', 'বাংলা'];
  @override
  void initState() {
    phone = '';
    sharedPreferences();
    super.initState();
  }

  Future _submitForm(
      BuildContext context, AuthProvider model, first_name, email) async {
    DialogLoaderClass.confirmDialog(context, 'Loading...');
    final Map<String, dynamic> authentication =
        await model.authenticationSocialMedia(first_name, email);
    print(authentication);
    if (authentication['success']) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
    } else {
      DialogClass.confirmDialog(context, authentication['message']);
    }
  }

  void sharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var a = await prefs.get('language');
    print(a);
    if (LocaleKeys.name.tr() == "Name") {
      setState(() {
        dropdownValue = "Eng";
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

  ErrorIcon _errorWidget = new ErrorIcon(false);

  set errorWidget(ErrorIcon value) {
    setState(() {
      _errorWidget = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final signInModel = Provider.of<AuthProvider>(context, listen: false);
    print('---------------------loginpage --------------');
    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: OrientationBuilder(builder: (context, orientation) {
            if (MediaQuery.of(context).orientation == Orientation.portrait) {
              print('i am protrait');
              return buildProtraits(signInModel);
            } else {
              print('i am landscape');
              return buildLandscapes(signInModel);
            }
          }),
        ),
      ),
    );
  }

//-----------------------------------------------------------Build Protraits ---------------
//--------------------------------buildProtraits -------------------------------------------
  Widget buildProtraits(signInModel) {
    return SingleChildScrollView(
      child: Form(
        key: _globalKey,
        child: Container(
          height: 100.0.h,
          width: 100.0.w,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/Background-4.jpeg'))),
          child: Column(
            children: [
              Container(
                height: 10.0.h,
                width: 40.0.w,
                margin: EdgeInsets.only(left: 55.0.w, top: 5.0.h, right: 5.0.w),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/Bangladesh-50years-&-Mujib-100.png'))),
              ),
//-----Boichitro Logo -----
              // Container(
              //   height: 20.0.h,
              //   width: 40.0.w,
              //   margin: EdgeInsets.only(top: 10.0.h),
              //   decoration: BoxDecoration(
              //     image:
              //         DecorationImage(image: AssetImage('assets/logo.png')),
              //   ),
              // ),

              SizedBox(
                height: 18.0.h,
              ),

              // Container(
              //   height: 5.0.h,
              //   width: 100.0.w,
              //   child: Center(
              //     child: Text(
              //       // 'Phone Number',
              //       LocaleKeys.phone_number.tr(),
              //       style: TextStyle(
              //           color: AppColorFactory.appPrimaryColor,
              //           fontSize: 2.5.h),
              //     ),
              //   ),
              // ),
              Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                    left: 7.0.h,
                    right: 7.0.h,
                  ),
                  height: 6.0.h,
                  width: 70.0.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    border: Border.all(
                        color: AppColorFactory.appPrimaryColor, width: 0.2.h),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(left: 3.0.w),
                    width: 60.0.w,
                    alignment: Alignment.center,
                    child: TextFormField(
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      onChanged: (text) {
                        // DEFINE YOUR RULES HERE
                        // text[3].contains('1')
                        (text.contains("1") && text.length == 10)
                            ? setState(() {
                                phone = '';
                                errorWidget = new ErrorIcon(false);
                                FocusScope.of(context).unfocus();
                                print('Phone number is : ');
                                //  phone = "+880$text";
                                phone_no = text;

                                print(phone_no);
                              })
                            : setState(() {
                                errorWidget = new ErrorIcon(true);
                                phone_no = '';
                              });
                      },
                      decoration: InputDecoration(
                        hintText: "Phone Number",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        suffixIcon: _errorWidget,
                        prefixText: '+88 0',
                        border: InputBorder.none,
                      ),
                      style:
                          TextStyle(color: Color(0xffb8242a), fontSize: 2.2.h),
                    ),
                  )),
              SizedBox(height: 3.0.h),
              Center(
                child: Container(
                  width: 25.0.w,
                  height: 4.5.h,
                  child:
                      Consumer<AuthProvider>(builder: (context, model, child) {
                    return model.isloadingsign
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: AppColorFactory.appPrimaryColor,
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                            ),
                            child: Text(
                              // 'Next',
                              LocaleKeys.next.tr(),
                              style: TextStyle(
                                fontSize: 2.0.h,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: phone_no.length == 10
                                ? () async {
                                    print('i ma working');
                                    print(phone.length);

                                    phone = "+880$phone_no";
                                    await _submitFormauth(context, signInModel);
                                  }
                                : () {
                                    print(phone.length);
                                  },
                          );
                  }),
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(20)),
                ),
              ),
              SizedBox(
                height: 3.0.h,
              ),
              Container(
                height: 3.5.h,
                child: Center(
                  child: Text(
                    //'Connect with ',
                    LocaleKeys.connect_with.tr(),
                    style: TextStyle(
                      color: Color(0xffc60e13),
                      fontSize: 2.5.h,
                    ),
                  ),
                ),
              ),
              Container(
                  height: 7.0.h,
                  margin:
                      EdgeInsets.only(left: 35.0.w, right: 35.0.w, top: 2.0.h),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Consumer<AuthProvider>(
                              builder: (context, model, child) {
                            return GestureDetector(
                              onTap: () async {
                                try {
                                  Map<String, dynamic> value =
                                      await model.googleLogin();
                                  print('---------------------------');
                                  print(value['message']['name']);
                                  print(value['message']['email']);

                                  if (value['message']['name'] != '' &&
                                      value['message']['email'] != '') {
                                    print('---------value--------');
                                    print(value);
                                    await _submitForm(
                                        context,
                                        model,
                                        value['message']['name'],
                                        value['message']['email']);
                                  } else {
                                    print('this is wrong');
                                  }
                                  value = {};
                                } catch (e) {}
                              },
                              child: CircleAvatar(
                                  radius: 22,
                                  child: Image(
                                      image: AssetImage('assets/google.png'))),
                            );
                          })),
                      // Expanded(
                      //     flex: 1,
                      //     child: CircleAvatar(
                      //         radius: 22,
                      //         child: Image(
                      //             image:
                      //                 AssetImage('assets/twitter.png')))),

                      //.........FACEBOOK.........

                      Expanded(
                        flex: 1,
                        child: Consumer<AuthProvider>(
                          builder: (context, model, child) {
                            return GestureDetector(
                              onTap: () async {
                                try {
                                  FacebookAuth.instance.login(permissions: [
                                    "public_profile",
                                    "email"
                                  ]).then((value) {
                                    FacebookAuth.instance
                                        .getUserData()
                                        .then((value) async {
                                      Map<String, dynamic> authdata;
                                      authdata = {
                                        'name': value['name'],
                                        'email': value['email'],
                                        'image': value['picture']['data']['url']
                                      };

                                      print(authdata);
                                      if (authdata['name'] != '' &&
                                          authdata['email'] != '') {
                                        await _submitForm(
                                          context,
                                          model,
                                          authdata['name'],
                                          authdata['email'],
                                        );
                                      }

                                      print(value);
                                    });
                                  });
                                } catch (e) {
                                  print(e);
                                }
                              },
                              child: CircleAvatar(
                                  radius: 22,
                                  child: Image(
                                      image:
                                          AssetImage('assets/facebook.png'))),
                            );
                          },
                        ),
                      ),
                      /////
                    ],
                  )),
              // ------ ict logo -----
              Container(
                height: 9.0.h,
                width: 50.0.w,
                margin:
                    EdgeInsets.only(left: 25.0.w, right: 25.0.w, top: 8.0.h),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/ict.png'), fit: BoxFit.fill)),
              ),
              //--------- Dhansiri logo ---------
              Container(
                height: 8.0.h,
                width: 40.0.w,
                margin:
                    EdgeInsets.only(left: 30.0.w, right: 30.0.w, top: 1.0.h),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/Dhanshiri-Digital.png'),
                        fit: BoxFit.contain)),
              ),
              SizedBox(
                height: 9.0.h,
              ),
              Container(
                height: 3.0.h,
                width: 100.0.w,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/1-Border-Lin.png'),
                        fit: BoxFit.fill)),
              )
            ],
          ),
        ),
      ),
    );
  }

//-----------------------------------------------------------Build Protraits ---------------
//--------------------------------buildProtraits -------------------------------------------
  Widget buildLandscapes(signInModel) {
    return SingleChildScrollView(
      child: Center(
        child: Form(
          key: _globalKey,
          child: Container(
            height: 90.0.h,
            width: 150.0.w,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/Background-4.jpeg'))),
            child: Column(
              children: [
                SizedBox(
                  height: 20.0.h,
                ),
                Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                      left: 7.0.h,
                      right: 7.0.h,
                    ),
                    height: 6.0.h,
                    width: 70.0.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      border: Border.all(
                          color: AppColorFactory.appPrimaryColor, width: 0.2.h),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(left: 3.0.w),
                      width: 60.0.w,
                      alignment: Alignment.center,
                      child: TextFormField(
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (text) {
                          // DEFINE YOUR RULES HERE
                          // text[3].contains('1')
                          (text.contains("1") && text.length == 10)
                              ? setState(() {
                                  phone = '';
                                  errorWidget = new ErrorIcon(false);
                                  FocusScope.of(context).unfocus();
                                  print('Phone number is : ');
                                  //  phone = "+880$text";
                                  phone_no = text;

                                  print(phone_no);
                                })
                              : setState(() {
                                  errorWidget = new ErrorIcon(true);
                                  phone_no = '';
                                });
                        },
                        decoration: InputDecoration(
                          hintText: "Phone Number",
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          suffixIcon: _errorWidget,
                          prefixText: '+88 0',
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                            color: Color(0xffb8242a), fontSize: 2.2.h),
                      ),
                    )),
                SizedBox(height: 3.0.h),
                Center(
                  child: Container(
                    width: 25.0.w,
                    height: 4.5.h,
                    child: Consumer<AuthProvider>(
                        builder: (context, model, child) {
                      return model.isloadingsign
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: AppColorFactory.appPrimaryColor,
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                ),
                              ),
                              child: Text(
                                // 'Next',
                                LocaleKeys.next.tr(),
                                style: TextStyle(
                                  fontSize: 2.0.h,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: phone_no.length == 10
                                  ? () async {
                                      print('i ma working');
                                      print(phone.length);

                                      phone = "+880$phone_no";
                                      await _submitFormauth(
                                          context, signInModel);
                                    }
                                  : () {
                                      print(phone.length);
                                    },
                            );
                    }),
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                SizedBox(
                  height: 3.0.h,
                ),
                Container(
                  height: 3.5.h,
                  child: Center(
                    child: Text(
                      //'Connect with ',
                      LocaleKeys.connect_with.tr(),
                      style: TextStyle(
                        color: Color(0xffc60e13),
                        fontSize: 2.5.h,
                      ),
                    ),
                  ),
                ),
                Container(
                    height: 7.0.h,
                    margin: EdgeInsets.only(
                        left: 35.0.w, right: 35.0.w, top: 2.0.h),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Consumer<AuthProvider>(
                                builder: (context, model, child) {
                              return GestureDetector(
                                onTap: () async {
                                  try {
                                    Map<String, dynamic> value =
                                        await model.googleLogin();
                                    print('---------------------------');
                                    print(value['message']['name']);
                                    print(value['message']['email']);

                                    if (value['message']['name'] != '' &&
                                        value['message']['email'] != '') {
                                      print('---------value--------');
                                      print(value);
                                      await _submitForm(
                                          context,
                                          model,
                                          value['message']['name'],
                                          value['message']['email']);
                                    } else {
                                      print('this is wrong');
                                    }
                                    value = {};
                                  } catch (e) {}
                                },
                                child: CircleAvatar(
                                    radius: 22,
                                    child: Image(
                                        image:
                                            AssetImage('assets/google.png'))),
                              );
                            })),
                        // Expanded(
                        //     flex: 1,
                        //     child: CircleAvatar(
                        //         radius: 22,
                        //         child: Image(
                        //             image:
                        //                 AssetImage('assets/twitter.png')))),
                        Expanded(
                            flex: 1,
                            child: Consumer<AuthProvider>(
                                builder: (context, model, child) {
                              return GestureDetector(
                                onTap: () async {
                                  try {
                                    FacebookAuth.instance.login(permissions: [
                                      "public_profile",
                                      "email"
                                    ]).then((value) {
                                      FacebookAuth.instance
                                          .getUserData()
                                          .then((value) async {
                                        Map<String, dynamic> authdata;
                                        authdata = {
                                          'name': value['name'],
                                          'email': value['email'],
                                          'image': value['picture']['data']
                                              ['url']
                                        };
                                        print('1234567890');
                                        print(authdata);
                                        if (authdata['name'] != '' &&
                                            authdata['email'] != '') {
                                          print('i am working ');
                                          await _submitForm(
                                            context,
                                            model,
                                            authdata['name'],
                                            authdata['email'],
                                          );
                                        }

                                        print(value);
                                      });
                                    });
                                  } catch (e) {}
                                },
                                child: CircleAvatar(
                                    radius: 22,
                                    child: Image(
                                        image:
                                            AssetImage('assets/facebook.png'))),
                              );
                            })),
                      ],
                    )),
                // ------ ict logo -----
                Container(
                  height: 9.0.h,
                  width: 50.0.w,
                  margin:
                      EdgeInsets.only(left: 25.0.w, right: 25.0.w, top: 8.0.h),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/ict.png'),
                          fit: BoxFit.fill)),
                ),
                //--------- Dhansiri logo ---------
                Container(
                  height: 8.0.h,
                  width: 40.0.w,
                  margin:
                      EdgeInsets.only(left: 30.0.w, right: 30.0.w, top: 1.0.h),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/Dhanshiri-Digital.png'),
                          fit: BoxFit.contain)),
                ),
                SizedBox(
                  height: 9.0.h,
                ),
                // Container(
                //   height: 3.0.h,
                //   width: 100.0.w,
                //   margin: EdgeInsets.only(left: 10.0.w, right: 10.0.w),
                //   decoration: BoxDecoration(
                //       image: DecorationImage(
                //           image: AssetImage('assets/1-Border-Lin.png'),
                //           fit: BoxFit.fill)),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _submitFormauth(BuildContext context, AuthProvider singInModel) async {
    debugPrint('Phone no is submitted');
    String app_key = await SmsAutoFill().getAppSignature;
    await singInModel.refreshtoken();
    Map<String, dynamic>
        // doctor Sign up
        authentication = await singInModel.authentication(phone, app_key);
    if (authentication['success']) {
      ///   Navigator.pop(context, true);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => OtpScreen(phone, "login")));
    } else if (authentication['message'] == "already register") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SplashScreen()));
    } else {
      showDialog(
          // barrierColor: Color(0xFFdab13c),
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Color(0xFFefe7dc),
              title: Text(
                'An error Occurred',
              ),
              content: Text(
                authentication['message'],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }
}

class ErrorIcon extends StatelessWidget {
  bool _isError;
  ErrorIcon(this._isError);
  bool get isError => _isError;
  @override
  Widget build(BuildContext context) {
    Widget out;
    debugPrint("Rebuilding ErrorWidget");
    isError
        ? out = new Icon(
            Icons.error,
            color: Color(Colors.red.value),
          )
        : out = new Icon(null);

    return out;
  }
}
