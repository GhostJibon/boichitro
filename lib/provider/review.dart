import 'dart:convert';
import 'dart:math';
import 'package:dhanshirisapp/constants/app_constants.dart';
import 'package:dhanshirisapp/model/review_list.dart';
import 'package:dhanshirisapp/utill/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/secure_storage_service.dart';

class ReviewProvider with ChangeNotifier {
  List<ReviewList> reviewlist = [];

  //---- bool value ----
  bool isloadingpostreview = false;
  bool isloadinggetreview = true;

  Future<Map<String, dynamic>?> postreview(
      Map<String, dynamic> _registration, name) async {
    bool hasError = true;
    String type = '';
    String message = 'Something went wrong.';
    try {
      isloadingpostreview = true;
      notifyListeners();
      debugPrint("Sign in model is called");
      // final Map<String, dynamic> authdata = {
      //   'subject': subject,
      //   'book': book_id,
      //   'comment':comment,
      //   'rating': rating,
      // };
      var token = await SecureStorageService().readValue(key: AUTH_TOKEN_KEY);

      print(_registration);

      // var url = Uri.parse(
      //     'http://www.dapi.counslink.com/api/v1/archive/submit-review/');
      var url =
          Uri.parse('${AppConstants.BASE_URL}${AppConstants.SUBMIT_REVIEW}');
      http.Response response =
          await http.post(url, body: json.encode(_registration), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token'
      });
      final String res = response.body;
      Random random = new Random();
      print(response.body);
      final Map<String, dynamic> responseData = json.decode(response.body);

      ///List<dynamic> mapResponse = JsonDecoder().convert(res);
      //----parse popular books-----

      addReview(
        id: random.nextInt(100),
        subject: 'subject',
        comment: _registration['comment'],
        rating: _registration['rating'].toString(),
        name: name,
      );

      message = "success";
      hasError = false;

      isloadingpostreview = false;
      notifyListeners();
    } catch (e) {
      isloadingpostreview = false;
      notifyListeners();
      print(e);
    }
    return {'success': !hasError, 'message': message, 'type': type};
  }

  Future<Map<String, dynamic>> getreview(book_id) async {
    bool hasError = true;
    String type = '';
    String message = 'Something went wrong.';
    isloadinggetreview = true;

    try {
      reviewlist = [];
      _items = {};
      notifyListeners();
      var token = await SecureStorageService().readValue(key: AUTH_TOKEN_KEY);
      print(token);
      print(book_id);
      // var url = Uri.parse(
      //   'http://www.dapi.counslink.com/api/v1/archive/get-reviews/?book_id=$book_id');
      var url = Uri.parse(
          '${AppConstants.BASE_URL}${AppConstants.GET_REVIEW}?book=$book_id');
      http.Response response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token'
      });
      print('i have data ');
      print(response.body);
      List<ReviewList> reviewlistTemp = [];
      Map<String, dynamic> mapResponse =
          jsonDecode((utf8.decode(response.bodyBytes)));
      // Map<String, dynamic> mapResponse = JsonDecoder().convert(res);
      if (response.statusCode == 200 || response.statusCode == 201) {
        mapResponse['results'].forEach((dynamic data) {
          final ReviewList _reviewlist = ReviewList.fromJson(data);
          print('rating');
          print(_reviewlist.rating);
          addReview(
              id: _reviewlist.id,
              subject: _reviewlist.subject,
              comment: _reviewlist.comment,
              rating: _reviewlist.rating,
              name: _reviewlist.name);
          reviewlistTemp.add(_reviewlist);
        });
        reviewlist = reviewlistTemp;
        isloadinggetreview = false;
        notifyListeners();
        message = "success";
      } else {
        isloadinggetreview = false;
        message = "unsuccess";
      }
      print(mapResponse);

      hasError = false;
      isloadinggetreview = false;
      notifyListeners();
    } catch (e) {
      isloadinggetreview = false;
      message = "Check Internet";
      notifyListeners();
      print(e);
    }
    return {'success': !hasError, 'message': message, 'type': type};
  }

  //---------------- Local manage --------------------

  Map<String, ReviewList> _items = {};
  int get itemsCount {
    return _items.length;
  }

  Map<String, ReviewList> get items {
    return {..._items};
  }

  addReview({
    int? id,
    String? subject,
    String? name,
    String? comment,
    String? rating,
  }) {
    // print(cat_id);
    // print(vendor_id);
    // print(invoice_no);
    if (_items.containsKey(id)) {
      _items.update(
          id.toString(),
          (value) => ReviewList(
              id: value.id,
              subject: value.subject,
              name: value.name,
              comment: value.comment,
              rating: value.rating));
      notifyListeners();
    } else {
      _items.putIfAbsent(
          id.toString(),
          () => ReviewList(
              id: id,
              subject: subject,
              name: name,
              comment: comment,
              rating: rating));
    }
    notifyListeners();
  }
}
