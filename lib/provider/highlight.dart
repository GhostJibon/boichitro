import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/highlight.dart';

class HighlightProvider with ChangeNotifier {
  bool isLoadinghighlightget = false;
  bool isLoadinghighlightpost = false;

  // -----fetch all category form api--------
  // Future<dynamic> fetchaHighlightData(int product_id) async {
  //   String message = '';
  //   isLoadinghighlightget = true;
  //   try {
  //     List<HighLight> _HighLight = [];
  //     _items = {};
  //     Map<String, dynamic>? mapResponse = await ApiCallMethod.get(
  //         urls:
  //             '${AppConstants.BASE_URL}${AppConstants.PRODUCT_QUESTION_ANSWER}?product_id=$product_id');
  //     print('---------question answer list------------');
  //     print(mapResponse);
  //     mapResponse!['data'].forEach((dynamic datalist) {
  //       HighLight _highlightdata = HighLight.fromJson(datalist);
  //       // _askSallerQuestionanswerTeam.add(_askSallerQuestion);

  //       print('i am working');
  //       addQuestion(
  //           pk: _highlightdata.pk,
  //           page_number: _highlightdata.page_number,
  //           start: _highlightdata.start,
  //           end: _highlightdata.end);
  //       //  askSallerQuestionAnswerList.add(_askSallerQuestion);
  //     });

  //     message = 'success';
  //     print(message);
  //     isLoadinghighlightget = false;
  //     notifyListeners();
  //   } catch (error) {
  //     message = 'failed';
  //      isLoadinghighlightget = false;
  //     notifyListeners();
  //   }
  //   return {'message': message};
  // }

  // Future<dynamic> HightLightPost(
  //     {int? user_id, int? book_id, int? page_number, int? start, int ?end }) async {
  // isLoadinghighlightpost= true;
  //   // notifyListeners();
  //   bool hasError = true;
  //   String message = 'Something went wrong.';
  //   String result = "Something went wrong";
  //   Dio dioRequest = dio.Dio();
  //   print('------registration-------');

  //   try {
  //     var formData = new dio.FormData.fromMap({
  //       'user_id': user_id,
  //       'book_id':book_id,
  //       'page_number':page_number,
  //       'start':start,
  //       'end':end
  //     });

  //     Map<String, dynamic>? mapResponse = await ApiCallMethod.post(
  //         formData: formData,
  //         urls: '${AppConstants.BASE_URL}${AppConstants.ASK_THE_SELLER}');
  //     print('-------------------askthesaller-------------------');
  //     print(mapResponse);
  //     print(mapResponse);
  //     if (mapResponse!['status'] == "success") {
  //       message = 'success';
  //       result = mapResponse['data'];
  //     } else {
  //       result = mapResponse['data'];
  //     }
  //      isLoadinghighlightpost = false;
  //     notifyListeners();
  //   } catch (error) {
  //     message = 'failed';
  //  isLoadinghighlightpost = false;
  //     notifyListeners();
  //   }
  //   return {'message': message, 'result': result};
  // }

//-------------------------- localymange---------------------

  Map<String, HighLight> _items = {};
  int get itemsCount {
    return _items.length;
  }

  Map<String, HighLight> get items {
    return {..._items};
  }

  void clean() {
    _items = {};
    notifyListeners();
  }

  addQuestion({
    int? page_number,
    int? start,
    int? end,
  }) {
    print('------------------Add Question ----------------');
    print(page_number);
    print(start);
    print(end);
    if (_items.containsKey(page_number.toString())) {
      print('------------update-------------');
      _items.update(
          page_number.toString(),
          (value) => HighLight(
              page_number: value.page_number, start: start, end: end));
      notifyListeners();
    } else {
      _items.putIfAbsent(page_number.toString(),
          () => HighLight(page_number: page_number, start: start, end: end));
    }
    notifyListeners();
  }

  void incrementCartiteam({
    int? start,
    int? end,
    int? page_number,
  }) async {
    try {
      print('-------update value------');
      _items.update(
          page_number.toString(),
          (value) => HighLight(
              page_number: value.page_number, start: start, end: end));
      //------count total amount ----
    } catch (e) {}
    notifyListeners();
  }
}
