import 'dart:convert';

import 'package:dhanshirisapp/model/book_request.dart';
import 'package:dhanshirisapp/utill/app_constants.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class Bookreadapi {
  String? page;
  Bookreadapi({
    @required this.page,
  });
}

class BookReadtModel with ChangeNotifier {
  List<Bookreadapi>? _readbook = [];
  List<Bookreadapi>? get BookPage => _readbook;
  List<BookRequestModel> _bookrequest = [];
  List<BookRequestModel> get bookrequested => _bookrequest;

  String? audio_book;
  String? get audiobook => audio_book;
  bool isloadingmodel = true;
  bool isloadinbookrequest = true;

  Future<Map<String, dynamic>?> bookreadapicall(token, int book_id) async {
    isloadingmodel = true;
    String? mapResponse1 = "null";
    notifyListeners();
    try {
      _readbook = [];
      // var url = Uri.parse(
      //     'https://dapi.counslink.com/api/v1/archive/book-content/$book_id/300/');
      var url = Uri.parse(
          '${AppConstants.BASE_URL}${AppConstants.BOOK_CONTENT}/$book_id/190/');
      http.Response response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      print(response.body);
      List<Bookreadapi> _dataList = [];
      if (response.statusCode == 200) {
        mapResponse1 = jsonDecode((utf8.decode(response.bodyBytes)));

        String string1 =
            mapResponse1!.replaceAll(" ", " ").replaceAll("\n", " ");
        print("bbbbbbbbbbbbbbbbbbbbb");
        print(string1);
        developer.log(string1);
        print("ccccccccccccccccccccc");
        //Map<String, dynamic>
        List<dynamic> mapResponse = JsonDecoder().convert(string1);
        // print("ccccccccccccccccccccccc");
        // // print(response.body);

        // List<dynamic> _fatchdata = json.decode(response.body);
        mapResponse.forEach((dynamic datalist) {
          final Bookreadapi _product = Bookreadapi(page: datalist['page']);
          //  print(_product.page);
          _dataList.add(_product);
        });
        _readbook = _dataList;
        isloadingmodel = false;
        notifyListeners();
      } else {
        mapResponse1 = "null";
        isloadingmodel = false;
        notifyListeners();
      }
    } catch (e) {
      isloadingmodel = false;
      notifyListeners();
      print(e);
    }
    return {'book_details': mapResponse1};
  }

  Future<Map<String, dynamic>?> audioBookapicall(token, book_id) async {
    isloadingmodel = true;
    notifyListeners();
    try {
      // var url = Uri.parse(
      //     'https://dapi.counslink.com/api/v1/archive/audio-book/$book_id');
      var url = Uri.parse(
          '${AppConstants.BASE_URL}${AppConstants.AUDIO_BOOK}book_id');
      http.Response response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      if (response.statusCode == 200) {
        Map<String, dynamic> mapResponse = JsonDecoder().convert(response.body);
        audio_book = mapResponse['audio_file'];
        isloadingmodel = false;
        notifyListeners();
      }
    } catch (e) {
      isloadingmodel = false;
      notifyListeners();
      print(e);
    }
  }

  // ------------------book request get method --------------
  Future<dynamic> fetchbookrequest(token) async {
    String message = '';
    isloadinbookrequest = true;

    print('----------token----------');
    print(token);
    try {
      var url =
          Uri.parse('${AppConstants.BASE_URL}${AppConstants.MY_BOOK_REQUESTS}');
      http.Response response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      List<BookRequestModel> _bookRequestTmp = [];
      Map<String, dynamic> responseData =
          jsonDecode((utf8.decode(response.bodyBytes)));
      // Map<String, dynamic> responseData = JsonDecoder().convert(response.body);
      print(responseData);
      responseData['results'].forEach((dynamic data) {
        final BookRequestModel _bookRequest = BookRequestModel.fromJson(data);
        print(_bookRequest.additional_note);
        _bookRequestTmp.add(_bookRequest);
      });
      _bookrequest = _bookRequestTmp;
      isloadinbookrequest = false;
      notifyListeners();
    } catch (error) {
      //turn off loader
      message = 'failed';
      isloadinbookrequest = false;
      notifyListeners();
    }
    return {'message': message};
  }
}
