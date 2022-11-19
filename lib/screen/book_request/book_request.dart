import 'dart:convert';

import 'package:dhanshirisapp/constants/app_constants.dart';
import 'package:dhanshirisapp/model/book_request.dart';
import 'package:dhanshirisapp/res/colors.dart';
import 'package:dhanshirisapp/screen/book_request/book_requested_screen.dart';
import 'package:dhanshirisapp/services/secure_storage_service.dart';
import 'package:dhanshirisapp/translations/locale_keys.g.dart';
import 'package:dhanshirisapp/utill/app_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as API;
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../provider/auth.dart';
import '../../provider/theme_provider.dart';

class BookRequest extends StatefulWidget {
  @override
  _BookRequestState createState() => _BookRequestState();
}

class _BookRequestState extends State<BookRequest> {
  late String _bookTitle, _bookDetails, _bookCategory;
  TextEditingController bookTitle = TextEditingController();
  TextEditingController bookBody = TextEditingController();
  TextEditingController bookExtras = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: AppColorFactory.appPrimaryColor,
      appBar: AppBar(
          backgroundColor: AppColorFactory.appPrimaryColor,
          elevation: 0,
          title: Text(
            LocaleKeys.book_request.tr(),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            new Container(
              //  height: MediaQuery.of(context).size.height * .25,
              height: 25.00.h,
              color: Color(0xffc60e13),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 1.0.h,
                    ),
                    // Center(
                    //   child: Align(
                    //     alignment: Alignment.topCenter,
                    //     child: SizedBox(
                    //       child: SizedBox(
                    //         height: 20.0.h,
                    //         child: Padding(
                    //           padding: EdgeInsets.all(10),
                    //           child: Image(
                    //             image: AssetImage(
                    //               'assets/logo.png',
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Center(
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            child: CircleAvatar(
                              radius: 60.0,
                              backgroundColor: Colors.white,
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
                  ]),
            ),
            new Container(
                decoration: BoxDecoration(
                    // color: Color(0xffd3b6b6),
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
                height: 63.35.h,
                child: Column(
                  children: [
                    Container(
                        // padding: EdgeInsets.all(16),
                        margin: EdgeInsets.only(
                            left: 10.0.w, right: 10.0.w, top: 3.0.h),
                        child: Form(
                          key: _formkey,
                          child: Column(
                            children: <Widget>[
                              // E-mail TextField
                              Container(
                                child: TextFormField(
                                  controller: bookTitle,
                                  keyboardType: TextInputType.text,
                                  cursorColor: Colors.white,
                                  style: TextStyle(color: Colors.white),
                                  validator: (input) {
                                    if (input!.isEmpty) {
                                      return 'Provide a title';
                                    }
                                  },
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColorFactory
                                                  .appPrimaryColor),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      contentPadding: EdgeInsets.all(15),
                                      suffixIcon: Icon(
                                        Icons.title, //book_rounded
                                        color: Colors.white,
                                      ),
                                      filled: true,
                                      fillColor:
                                          AppColorFactory.appPrimaryColor,
                                      focusColor:
                                          AppColorFactory.appPrimaryColor,
                                      border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      hintStyle: TextStyle(color: Colors.white),
                                      hintText: 'Book Title'),
                                  onSaved: (input) => _bookTitle = input!,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                              ),
                              // BookDetails TextField
                              Container(
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: bookBody,
                                  cursorColor: Colors.white,
                                  style: TextStyle(color: Colors.white),
                                  // obscureText: true,
                                  validator: (input) {
                                    if (input!.length < 3) {
                                      return 'Book Details must be at least 3 char long';
                                    }
                                  },
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColorFactory
                                                  .appPrimaryColor),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      contentPadding: EdgeInsets.all(15),
                                      suffixIcon: Icon(
                                        Icons.category,
                                        color: Colors.white,
                                      ),
                                      filled: true,
                                      fillColor:
                                          AppColorFactory.appPrimaryColor,
                                      focusColor:
                                          AppColorFactory.appPrimaryColor,
                                      border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      hintStyle: TextStyle(color: Colors.white),
                                      hintText: 'Category '),
                                  onSaved: (input) => _bookCategory = input!,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20),
                              ),
                              Container(
                                child: TextFormField(
                                  controller: bookExtras,
                                  minLines: 3,
                                  maxLines: 5,
                                  keyboardType: TextInputType.multiline,
                                  cursorColor: Colors.white,
                                  style: TextStyle(color: Colors.white),
                                  obscureText: false,
                                  validator: (input) {
                                    if (input!.length < 1) {
                                      return 'Please submit a note';
                                    }
                                  },
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColorFactory
                                                  .appPrimaryColor),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      contentPadding: EdgeInsets.all(15),
                                      suffixIcon: Icon(
                                        Icons.note_add,
                                        color: Colors.white,
                                      ),
                                      filled: true,
                                      fillColor:
                                          AppColorFactory.appPrimaryColor,
                                      focusColor:
                                          AppColorFactory.appPrimaryColor,
                                      border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      hintStyle: TextStyle(color: Colors.white),
                                      hintText: 'Additional Note '),
                                  onSaved: (input) => _bookDetails = input!,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 60),
                              ),
                              Container(
                                width: 75.00.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 3),
                                    )
                                  ],
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          AppColorFactory.appPrimaryColor,
                                      padding:
                                          EdgeInsets.fromLTRB(80, 15, 80, 15),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadiusDirectional.circular(
                                                  10))),
                                  // padding: EdgeInsets.fromLTRB(80, 15, 80, 15),
                                  // color: AppColorFactory.appPrimaryColor,
                                  // shape: RoundedRectangleBorder(
                                  //   borderRadius:
                                  //       BorderRadiusDirectional.circular(10),
                                  // ),
                                  onPressed: () {
                                    if (!_formkey.currentState!.validate()) {
                                      return;
                                    }
                                    _formkey.currentState!.save();
                                    showSpinner(context);
                                  },
                                  child: Text(
                                    // 'Submit',
                                    LocaleKeys.submit.tr(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(top: 20),
                              ),
                            ],
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 1.6.h),
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

  Future<void> showSpinner(BuildContext context) async {
    print("Submitting the book request");

    var alert = AlertDialog(
      title: Text("Please wait..."),
      content: Text(
        "Book request is being submitted!",
        style: TextStyle(fontSize: 12),
      ),
      elevation: 24,
    );

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return alert;
        });
    var token = await SecureStorageService().readValue(key: AUTH_TOKEN_KEY);
    sendBookRequest(token).then((value) =>
        // dismiss the alert dialogue
        Navigator.of(context).pop()).then((value) =>
            Navigator.of(context).pushNamed(BookRequestingScreen.routeName)
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => BookRequestingScreen(),
        //   ),
        // ),
        );

    // ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Your request is sent to the server'))));
  }

  Future<void> sendBookRequest(token) async {
    var requestData = {
      "request_title": bookTitle.text,
      "request_body": bookBody.text,
      "additional_note": bookExtras.text
    };
    // hide the keyboard first
    FocusScope.of(context).unfocus();

    // clear the text field
    bookTitle.clear();
    bookBody.clear();
    bookExtras.clear();

    var url = Uri.parse(
        '${AppConstants.BASE_URL}${AppConstants.CREATE_BOOK_REQUEST}');
    API.Response response =
        await API.post(url, body: json.encode(requestData), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });

    print(response.body);
  }
}
