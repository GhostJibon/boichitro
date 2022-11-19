import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Orther with ChangeNotifier {
  String? _font = 'Bensenhandwriti';
  int? _fontsize;
  int _pagenumber = 4;

  void fontmethod(String? font) {
    _font = font;
    notifyListeners();
  }

  String? get getfont {
    return _font;
  }

  void fontsize(int? fontsize) {
    _fontsize = fontsize;
    notifyListeners();
  }

  int? get getfontsize {
    return _fontsize;
  }

  void pagenumber(int page) {
    _pagenumber = page;
    notifyListeners();
  }

  int get getPagenumber {
    return _pagenumber;
  }
}
