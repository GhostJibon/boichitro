import 'dart:async';
import 'dart:convert';
import 'package:dhanshirisapp/model/Category.dart';
import 'package:dhanshirisapp/model/audio_book.dart';
import 'package:dhanshirisapp/model/bookInfo.dart';
import 'package:dhanshirisapp/model/slider_model.dart';
import 'package:dhanshirisapp/model/sliderimage.dart';
import 'package:dhanshirisapp/utill/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'dart:developer' as developer;
import 'dart:developer' as developer;

class CategoryProvider with ChangeNotifier {
  List<Category> _categoryList = [];

  // ---list variable---
  List<String> _categoryNames = [];
  List<BookInfo> _recentBooks = [];
  List<BookInfo> _popularBooks = [];
  List<AudioBookModel> _audiobookmodel = [];

  //-----getters-----
  List<Category> get categoryList => _categoryList;
  List<String>? get categoryName => _categoryNames;
  List<BookInfo>? get recentBooks => _recentBooks;
  List<BookInfo>? get popularBooks => _popularBooks;
  List<AudioBookModel>? get audioBookModel => _audiobookmodel;
  List<SliderModel> get slider_images => _base64BookImages;
  List<SliderModel> _base64BookImages = [];
  // ---loader---
  bool isLoadingCategory = true;
  bool isLoadingBookInfo = true;
  bool isLoadingBookPreview = true;
  bool isLoadingAudioBookInfo = true;
  bool isLoadingpopular = true;

  // -----fetch all category form api--------
  Future<dynamic> fetchCategory(token) async {
    String message = '';
    isLoadingCategory = true;
    notifyListeners();
    try {
      var url = Uri.parse('${AppConstants.BASE_URL}${AppConstants.CATEGORY}');
      http.Response response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      List<Category> _categoryTempList = [];
      List<String> _categoryTempNameList = [];
      Map<String, dynamic> mapResponse =
          jsonDecode((utf8.decode(response.bodyBytes)));
      mapResponse['results'].forEach((dynamic datalist) {
        final Category _product =
            Category(id: datalist['id'], name: datalist['category_name']);
        _categoryTempList.add(_product);
        _categoryTempNameList.add(_product.name.toString());
      });
      _categoryTempNameList.add('Populor');
      _categoryTempNameList.add('Recent');
      _categoryList = _categoryTempList;
      _categoryNames = _categoryTempNameList;
      message = 'success';
      isLoadingCategory = false;
      notifyListeners();
    } catch (error) {
      message = 'failed';
      isLoadingCategory = false;
      notifyListeners();
    }
    return {'message': message};
  }

  // -----fetch books info from api--------
  Future<dynamic> fetcharecent(token) async {
    String message = '';
    isLoadingBookInfo = true;
    // notifyListeners();
    try {
      // var url = Uri.parse('${AppConstants.BASE_URL}/dashboard-content-recent');
      var url = Uri.parse(
          'http://boichitro.com.bd/api/v1/archive/dashboard-content-recent/');
      http.Response response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      List<BookInfo> _recentBookTempList = [];
      // List<BookInfo> _popularBookTempList = [];
      Map<String, dynamic> responseData = JsonDecoder().convert(response.body);
      // print("rrrrrrrrrrrrrrrrrrrrrrrrrrr");
      // // // print(responseData);
      // developer.log(responseData.toString());

      //----parse recent books-----
      responseData['recent'].forEach((dynamic data) {
        final BookInfo _recentBooks = BookInfo.fromJson(data);
        print('rating');
        print(_recentBooks.rating);
        if (_recentBooks.book_type != 'audiobook') {
          _recentBookTempList.add(_recentBooks);
        }
      });
      //----parse popular books-----
      // responseData['popular'].forEach((dynamic data) {
      //   final BookInfo _popularBooks = BookInfo.fromJson(data);
      //   print('rating');
      //   print(_popularBooks.rating);
      //   if (_popularBooks.book_type != 'audiobook') {
      //     _popularBookTempList.add(_popularBooks);
      //   }
      // });
      _recentBooks = _recentBookTempList;
      // _popularBooks = _popularBookTempList;
      message = 'success';
      isLoadingBookInfo = false;
      notifyListeners();
    } catch (error) {
      message = 'failed';
      isLoadingBookInfo = false;
      notifyListeners();
    }
    return {'message': message};
  }

  //------------fetch popular ------------
  // -----fetch books info from api--------
  Future<dynamic> fetchapopular(token) async {
    String message = '';
    isLoadingpopular = true;
    // notifyListeners();
    try {
      // var url = Uri.parse('${AppConstants.BASE_URL}/dashboard-content-recent');
      var url = Uri.parse(
          'http://boichitro.com.bd/api/v1/archive/dashboard-content-popular/');
      http.Response response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      List<BookInfo> _recentBookTempList = [];
      List<BookInfo> _popularBookTempList = [];
      Map<String, dynamic> responseData = JsonDecoder().convert(response.body);
      // print("ppppppppppppppppppppppppppppp");
      // // print(responseData);
      // developer.log(responseData.toString());

      //----parse recent books-----

      //----parse popular books-----
      responseData['popular'].forEach((dynamic data) {
        final BookInfo _popularBooks = BookInfo.fromJson(data);
        print('rating');
        print(_popularBooks.rating);
        if (_popularBooks.book_type != 'audiobook') {
          _popularBookTempList.add(_popularBooks);
        }
      });
      // _recentBooks = _recentBookTempList;
      _popularBooks = _popularBookTempList;
      message = 'success';
      isLoadingpopular = false;
      notifyListeners();
    } catch (error) {
      message = 'failed';
      isLoadingpopular = false;
      notifyListeners();
    }
    return {'message': message};
  }

  // -----fetch preview images form api--------
  Future<dynamic> fetchPreviewBooksImage(token) async {
    String message = '';
    isLoadingBookPreview = true;

    try {
      var url = Uri.parse(
          '${AppConstants.BASE_URL}${AppConstants.SLIDER_IMAGE_LIST}');
      http.Response response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });

      List<SliderModel> _base64BookImagesTemp = [];
      print('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
      print(response.body);
      Map<String, dynamic> mapResponse = JsonDecoder().convert(response.body);
      mapResponse['slider'].forEach((dynamic datalist) {
        final SliderModel _image = SliderModel.fromJson(datalist);
        if (_image.slider__image != null) {
          print(
              '--------------------------------1231gasgasgsgasgsagasgsagsgsgsgsgsgsgsgsgsgsg313----------------------');
          _base64BookImagesTemp.add(_image);
        }
      });
      _base64BookImages = _base64BookImagesTemp;
      message = 'success';
      isLoadingBookPreview = false;
      notifyListeners();
    } catch (error) {
      message = 'failed';
      isLoadingBookPreview = false;
      notifyListeners();
    }
    return {'message': message};
  }

  //---------------Audio_books ---------------
  Future<dynamic> fetchAudiobook(token) async {
    String message = '';
    isLoadingAudioBookInfo = true;
    notifyListeners();

    print('----------token----------');
    print(token);
    try {
      var url =
          Uri.parse('${AppConstants.BASE_URL}${AppConstants.AUDIO_BOOKS}');
      http.Response response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      List<AudioBookModel> _audiobookTmp = [];
      Map<String, dynamic> responseData =
          jsonDecode((utf8.decode(response.bodyBytes)));

      print(responseData);
      responseData['results'].forEach((dynamic data) {
        final AudioBookModel _audioBooks = AudioBookModel.fromJson(data);
        print(
            '----------------------------------asegasgasgsa-gas-gas-gas-gsa-gs-ags-gs-gs-gs-g-sg-sg-sg-sg-sag-s');

        print(_audioBooks.description);
        _audiobookTmp.add(_audioBooks);
      });
      _audiobookmodel = _audiobookTmp;
      isLoadingAudioBookInfo = false;
      notifyListeners();
    } catch (error) {
      //turn off loader
      message = 'failed';
      isLoadingAudioBookInfo = false;
      notifyListeners();
    }
    return {'message': message};
  }
}
