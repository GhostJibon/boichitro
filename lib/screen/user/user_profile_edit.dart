import 'dart:async';

import 'package:dhanshirisapp/components/list_item.dart';
import 'package:dhanshirisapp/provider/auth.dart';
import 'package:dhanshirisapp/res/colors.dart';
import 'package:dhanshirisapp/screen/auth/login_screen.dart';
import 'package:dhanshirisapp/screen/book_api_call.dart';
import 'package:dhanshirisapp/provider/theme_provider.dart';
import 'package:dhanshirisapp/translations/locale_keys.g.dart';
import 'package:dhanshirisapp/widget/drower_customer/line_box.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class UserProfileEdit extends StatefulWidget {
  final profiledata;
  final int checkdata;
  final bookid;
  final bookname;
  UserProfileEdit(
      {required this.profiledata,
      required this.checkdata,
      required this.bookid,
      required this.bookname});
  @override
  _UserProfileEditState createState() => _UserProfileEditState();
}

class _UserProfileEditState extends State<UserProfileEdit> {
  // TextEditingController userFullName = TextEditingController();
  // TextEditingController userPhoneNo = TextEditingController();
  // TextEditingController userEmail = TextEditingController();
  String userGender = "Male";
  String? userFullname;
  String? userPhoneNo;
  String? userEmail;

  /* Creating key to check FormState(status) */

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    print(widget.profiledata.userInfodata!.full_name);
    print(widget.profiledata.userInfodata!.email);
    print(widget.profiledata.userInfodata!.gender);
    print(widget.profiledata.userInfodata!.username_type);
    userFullname = widget.profiledata.userInfodata!.full_name;
    userEmail = widget.profiledata.userInfodata!.email;
    userPhoneNo = widget.profiledata.userInfodata!.phone;
    widget.profiledata.userInfodata!.gender == null
        ? userGender = "Male"
        : userGender = widget.profiledata.userInfodata!.gender;
  }

  /* Showing the error message */
  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(errormessage),
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

  ErrorIcon _errorWidget = new ErrorIcon(false);

  set errorWidget(ErrorIcon value) {
    setState(() {
      _errorWidget = value;
    });
  }

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
            LocaleKeys.profile_view.tr(),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            new Container(
              //  height: MediaQuery.of(context).size.height * .25,
              height: 24.35.h,
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
                          height: 6.0.h,
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
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  // Icon(Icons.edit)
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    //////
                  ]),
            ),

            //-------------------field -----------
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
                  // color: Color(0xffd3b6b6),
                  //themeProvider.isDarkMode ? Colors.white : Colors.grey,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),

              height: 64.00.h,
              //  child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: 4.0.h, left: 10.0.w, right: 10.0.w),
                      child: Column(
                        children: <Widget>[
                          // E-mail TextField
                          Container(
                            child: TextFormField(
                              initialValue:
                                  widget.profiledata.userInfodata!.full_name,
                              onChanged: (value) {
                                userFullname = value;
                              },
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.white,
                              style: TextStyle(color: Colors.white),
                              validator: (input) {
                                if (input!.isEmpty) {
                                  return 'Provide your name';
                                }
                              },
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              AppColorFactory.appPrimaryColor),
                                      borderRadius: BorderRadius.circular(10)),
                                  contentPadding: EdgeInsets.all(15),
                                  suffixIcon: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                  filled: true,
                                  fillColor: AppColorFactory.appPrimaryColor,
                                  focusColor: AppColorFactory.appPrimaryColor,
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10)),
                                  hintStyle: TextStyle(color: Colors.white),
                                  hintText: 'Your Name'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                          ),
                          // BookDetails TextField
                          Container(
                            child: TextFormField(
                              //   TextFormField(
                              initialValue: widget.profiledata.userInfodata!
                                              .phone ==
                                          widget.profiledata.userInfodata!
                                              .email ||
                                      widget.profiledata.userInfodata!.phone ==
                                          'null'
                                  ? null
                                  : widget.profiledata!.userInfodata.phone,
                              onChanged: widget.profiledata.userInfodata!
                                          .username_type !=
                                      'phone'
                                  ? (text) {
                                      // DEFINE YOUR RULES HERE
                                      // text[3].contains('1')
                                      (text.contains("1") && text.length == 11)
                                          ? setState(() {
                                              userPhoneNo = '';
                                              errorWidget =
                                                  new ErrorIcon(false);
                                              FocusScope.of(context).unfocus();
                                              print('Phone number is : ');
                                              //  phone = "+880$text";
                                              userPhoneNo = "$text";

                                              print(userPhoneNo);
                                            })
                                          : setState(() {
                                              errorWidget = new ErrorIcon(true);
                                              userPhoneNo = '';
                                            });
                                    }
                                  : (value) {},
                              //   keyboardType: TextInputType.text,
                              //   cursorColor: Colors.white,
                              //   style: TextStyle(color: Colors.white),
                              validator: (value) {
                                if (value!.length < 11) {
                                  return 'Please enter a valid phone number';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              AppColorFactory.appPrimaryColor),
                                      borderRadius: BorderRadius.circular(10)),
                                  contentPadding: EdgeInsets.all(15),
                                  suffixIcon: Icon(
                                    Icons.phone,
                                    color: Colors.white,
                                  ),
                                  filled: true,
                                  fillColor: AppColorFactory.appPrimaryColor,
                                  focusColor: AppColorFactory.appPrimaryColor,
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10)),
                                  hintStyle: TextStyle(color: Colors.white),
                                  hintText: 'Your Phone'),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              textAlign: TextAlign.start,
                            ),

                            //   textAlign: TextAlign.start,
                            //   keyboardType: TextInputType.number,
                            //   inputFormatters: <TextInputFormatter>[
                            //     FilteringTextInputFormatter.digitsOnly
                            //   ],
                            //   initialValue: widget.profiledata.userInfodata!
                            //                   .phone ==
                            //               widget.profiledata.userInfodata!
                            //                   .email ||
                            //           widget.profiledata.userInfodata!
                            //                   .phone ==
                            //               'null'
                            //       ? null
                            //       : widget.profiledata!.userInfodata.phone,
                            //   onChanged: widget.profiledata.userInfodata!
                            //               .username_type !=
                            //           'phone'
                            //       ? (text) {
                            //           // DEFINE YOUR RULES HERE
                            //           // text[3].contains('1')
                            //           (text.contains("1") &&
                            //                   text.length == 11)
                            //               ? setState(() {
                            //                   userPhoneNo = '';
                            //                   errorWidget =
                            //                       new ErrorIcon(false);
                            //                   FocusScope.of(context)
                            //                       .unfocus();
                            //                   print('Phone number is : ');
                            //                   //  phone = "+880$text";
                            //                   userPhoneNo = "$text";

                            //                   print(userPhoneNo);
                            //                 })
                            //               : setState(() {
                            //                   errorWidget =
                            //                       new ErrorIcon(true);
                            //                   userPhoneNo = '';
                            //                 });
                            //         }
                            //       : (value) {},
                            //   validator: (value) {
                            //     if (value!.length < 11) {
                            //       return 'Please enter a valid phone number';
                            //     } else {
                            //       return null;
                            //     }
                            //   },
                            //   decoration: InputDecoration(
                            //     hintText: "Phone Number",
                            //     hintStyle: TextStyle(color: Colors.white),
                            //     suffixIcon: _errorWidget,
                            //     //prefixText: '+88 0',
                            //     // border: InputBorder.none,
                            //     filled: true,
                            //     fillColor: AppColorFactory.appPrimaryColor,
                            //     focusColor: AppColorFactory.appPrimaryColor,
                            //     border: OutlineInputBorder(
                            //         borderSide:
                            //             BorderSide(color: Colors.white),
                            //         borderRadius: BorderRadius.circular(10)),
                            //   ),
                            //   // style: TextStyle(
                            //   //     color: Colors.white, fontSize: 2.2.h),
                            // ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                          ),

                          Container(
                            decoration: BoxDecoration(
                              color: AppColorFactory.appPrimaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    LocaleKeys.gender.tr(),
                                    style: TextStyle(
                                        color: AppColorFactory.colorWhite,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  DropdownButton<String>(
                                    value: userGender,
                                    items: <String>['Male', 'Female']
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                              backgroundColor: AppColorFactory
                                                  .appPrimaryColor,
                                              color:
                                                  AppColorFactory.colorWhite),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        userGender = newValue!;
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                          ),
                          Container(
                            child: TextFormField(
                              initialValue:
                                  widget.profiledata.userInfodata!.email,
                              onChanged: widget.profiledata.userInfodata!
                                          .username_type !=
                                      'email'
                                  ? (value) {
                                      userEmail = value;
                                    }
                                  : (value) {},
                              minLines: 1,
                              maxLines: 1,
                              keyboardType: TextInputType.multiline,
                              cursorColor: Colors.white,
                              style: TextStyle(color: Colors.white),
                              obscureText: false,
                              validator: (value) {
                                if (value!.isEmpty ||
                                    !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                        .hasMatch(value)) {
                                  return 'Please enter a valid email';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              AppColorFactory.appPrimaryColor),
                                      borderRadius: BorderRadius.circular(10)),
                                  contentPadding: EdgeInsets.all(15),
                                  suffixIcon: Icon(
                                    Icons.mark_email_read,
                                    color: Colors.white,
                                  ),
                                  filled: true,
                                  fillColor: AppColorFactory.appPrimaryColor,
                                  focusColor: AppColorFactory.appPrimaryColor,
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10)),
                                  hintStyle: TextStyle(color: Colors.white),
                                  hintText: 'Your Email'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.0.h),
                          ),
                          Consumer<AuthProvider>(
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.red,
                                ),
                              ),
                              builder: (context, model, child) {
                                return model.isloadingprofileupdate
                                    ? child as Widget
                                    : Container(
                                        width: 90.0.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ]),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.fromLTRB(
                                                80, 15, 80, 15),
                                            backgroundColor:
                                                AppColorFactory.appPrimaryColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadiusDirectional
                                                      .circular(10),
                                            ),
                                          ),
                                          // padding: EdgeInsets.fromLTRB(
                                          //     80, 15, 80, 15),
                                          // color:
                                          //     AppColorFactory.appPrimaryColor,
                                          // shape: RoundedRectangleBorder(
                                          //   borderRadius:
                                          //       BorderRadiusDirectional
                                          //           .circular(10),
                                          // ),
                                          onPressed: () {
                                            if (!_formkey.currentState!
                                                .validate()) {
                                              return;
                                            }
                                            _formkey.currentState!.save();
                                            _submitForm(
                                                widget.profiledata,
                                                widget.checkdata,
                                                widget.bookid,
                                                widget.bookname);
                                          },
                                          child: Text(
                                            // 'Save',
                                            LocaleKeys.save.tr(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        ),
                                      );
                              }),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 3.25.h),
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
            ),
            // )
          ],
        ),
      ),
    );
  }

  _submitForm(profileModel, checkdata, bookid, bookname) async {
    final Map<String, dynamic> authentication =
        await profileModel.profileUpdate(
      userEmail.toString(),
      userGender.toString(),
      userFullname.toString(),
      userPhoneNo.toString(),
    );
    if (authentication['success']) {
      print('woking');
      // setState(() {});
      if (checkdata == 1) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BookApiCall(
                      book_id: bookid,
                      book_name: bookname,
                    )));
      } else {
        Navigator.pop(context);
      }
    } else {}
  }
}
