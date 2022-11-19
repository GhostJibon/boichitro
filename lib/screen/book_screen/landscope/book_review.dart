import 'package:dhanshirisapp/components/review_design.dart';
import 'package:dhanshirisapp/constants/app_constants.dart';
import 'package:dhanshirisapp/provider/auth.dart';
import 'package:dhanshirisapp/provider/review.dart';
import 'package:dhanshirisapp/res/colors.dart';
import 'package:dhanshirisapp/services/secure_storage_service.dart';
import 'package:dhanshirisapp/translations/locale_keys.g.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class BookReviewLandscope extends StatefulWidget {
  final book_id;
  BookReviewLandscope(this.book_id);
  @override
  _BookReviewState createState() => _BookReviewState();
}

class _BookReviewState extends State<BookReviewLandscope> {
  final _globalKey = GlobalKey<FormState>();

  int? book_id;

  Map<String, dynamic> _registrationForm = {
    'subject': 'subject',
    'book': null,
    'comment': null,
    'rating': '3',
  };

  // _submitForm(ReviewProvider reviewProvider, name) async {
  //   final Map<String, dynamic> authentication =
  //       await reviewProvider.postreview(_registrationForm, name);
  //   if (authentication['success']) {
  //     print('woking');
  //     // Navigator.pop(context);
  //   } else {}
  // }

  @override
  void initState() {
    _registrationForm['book'] = widget.book_id;
    _registrationForm['comment'] = null;
    _registrationForm['rating'] = '3';
    setState(() {});
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    //------initial call-------
    var token = await SecureStorageService().readValue(key: AUTH_TOKEN_KEY);
    print(token);
    ReviewProvider reviewProvider =
        Provider.of<ReviewProvider>(context, listen: false);
    await reviewProvider.getreview(widget.book_id);
    super.didChangeDependencies();
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    return SingleChildScrollView(
      child: Form(
        key: _globalKey,
        child: Container(
          height: 60.0.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                // height: 15.0.h,
                width: 100.0.w,
                margin: EdgeInsets.only(
                  left: 03.0.w,
                  right: 03.0.w,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 3.0.h,
                          margin: EdgeInsets.only(
                            left: 10.0.w,
                          ),
                          child: Text(
                            LocaleKeys.rating.tr(),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 01.0.w, right: 10.0.w),
                          height: 4.0.h,
                          child: RatingBar.builder(
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 30,
                            itemPadding: EdgeInsets.symmetric(horizontal: 5.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                              _registrationForm['rating'] = rating.toString();
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: .5.h,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 08.0.w, right: 10.0.w),
                      child: TextFormField(
                          //controller: bookExtras,
                          minLines: 2,
                          maxLines: 3,
                          keyboardType: TextInputType.multiline,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          //obscureText: false,
                          validator: (input) {
                            if (input!.length < 1) {
                              return 'Please leave a note';
                            }
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey[300]!),
                                borderRadius: BorderRadius.circular(30)),
                            contentPadding: EdgeInsets.all(15),
                            filled: true,
                            fillColor: Colors.grey[300],
                            focusColor: Colors.grey[300],
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(30)),
                            hintStyle: TextStyle(color: Colors.black),
                            hintText: LocaleKeys.comment.tr(),
                          ),
                          onSaved: (input) {
                            _registrationForm['comment'] = input;
                          },
                          enableInteractiveSelection: false),
                    ),
                    SizedBox(
                      height: 1.0.h,
                    ),
                    //--------- submit button ---------
                    Consumer<ReviewProvider>(
                        child: Container(
                          height: 5.0.h,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.red,
                            ),
                          ),
                        ),
                        builder: (context, model, child) {
                          return model.isloadingpostreview
                              ? child as Widget
                              : GestureDetector(
                                  onTap: () async {
                                    if (!_globalKey.currentState!.validate()) {
                                      return;
                                    }
                                    _globalKey.currentState!.save();
                                    Map<String, dynamic>? authdata =
                                        await model.postreview(
                                            _registrationForm,
                                            authProvider
                                                .userInfodata!.full_name);
                                    print('1234457473735737');
                                    _registrationForm['comment'] = null;
                                    _registrationForm['rating'] = null;
                                    print(authdata);
                                  },
                                  child: Container(
                                      height: 5.0.h,
                                      width: 100.0.w,
                                      margin: EdgeInsets.only(
                                          left: 20.0.w, right: 20.0.w),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 2,
                                              spreadRadius: 2,
                                              offset: Offset.zero,
                                              color: Colors.red[300]!,
                                            )
                                          ]),
                                      child: Center(
                                        child: Text(
                                          LocaleKeys.submit.tr(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )),
                                );
                        })
                  ],
                ),
              ),

              SizedBox(
                height: 2.0.h,
              ),
              Consumer<ReviewProvider>(
                  child: Container(
                    height: 3.0.h,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    ),
                  ),
                  builder: (context, model, child) {
                    return model.isloadinggetreview
                        ? child as Widget
                        : Container(
                            height: 3.0.h,
                            margin:
                                EdgeInsets.only(left: 10.0.w, right: 05.0.w),
                            child: Text(
                              '${LocaleKeys.review.tr()}( ${model.items.length}) ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 2.0.h),
                            ),
                          );
                  }),
              Padding(
                padding: EdgeInsets.only(left: 05.0.w, right: 05.0.w),
                child: Divider(
                  height: 03.0.h,
                  thickness: .10.h,
                  color: Colors.black12,
                ),
              ),
              Consumer<ReviewProvider>(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  ),
                  builder: (context, model, child) {
                    return model.isloadinggetreview
                        ? child as Widget
                        : Container(
                            height: 27.0.h,
                            child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                //  itemCount: model.reviewlist.length,
                                itemCount: model.items.length,
                                itemBuilder: (context, index) {
                                  //  var data = model.reviewlist[index];
                                  var data = model.items.values.toList()[index];
                                  print(data.id);
                                  print(data.name);
                                  print(data.rating);
                                  print(data.comment);
                                  return ReviewDesign(
                                    data: data,
                                  );
                                }),
                          );
                  }),
              //  ReviewDesign(),
              // Container(
              //   height: 20.0.h,
              // ),
              SizedBox(
                height: 1.0.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
