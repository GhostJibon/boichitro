import 'dart:convert';
import 'package:dhanshirisapp/constants/app_constants.dart';
import 'package:dhanshirisapp/model/favouritmodel.dart';
import 'package:dhanshirisapp/services/secure_storage_service.dart';
import 'package:dhanshirisapp/utill/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FavouriteProviderModel with ChangeNotifier {
  List<FavouriteProduct> _favouritelist = [];
  List _cartBooks = [];
  List get cartBooks => _cartBooks;
  List<FavouriteProduct> get favouritelist => _favouritelist;
  bool is_loading = true;
  bool is_loading_addfovourite = true;
  int? _selectedproductindex;
  void selectProduct(int index) {
    _selectedproductindex = index;
    notifyListeners();
  }

  int get selectProductIndex {
    return _favouritelist.indexWhere((FavouriteProduct product) {
      return product.pk == _selectedproductindex;
    });
  }

  Future<Map<String, dynamic>> fatchfavouriteList() async {
    is_loading = true;
    bool hasError = true;
    String message = "Something went wrong ";
    var token = await SecureStorageService().readValue(key: AUTH_TOKEN_KEY);
    print(token);

    /// notifyListeners();
    try {
      var url =
          Uri.parse('${AppConstants.BASE_URL}${AppConstants.MY_WISHLISH}');
      http.Response response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      print('check------favouritelist');
      // print(response.body);
      List<FavouriteProduct> _dataList = [];
      //  Map<String, dynamic> mapResponse = JsonDecoder().convert(response.body);
      Map<String, dynamic> mapResponse =
          json.decode(utf8.decode(response.bodyBytes));
      var responseBody = jsonDecode(response.body);
      print(responseBody);
      print(mapResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        mapResponse['results'].forEach((dynamic map) {
          final FavouriteProduct _product = FavouriteProduct.fromJson(map);
          _dataList.add(_product);
        });

        _favouritelist = _dataList;

        for (int i = 0; i < _favouritelist.length; i++) {
          var cartB = _favouritelist[i].bookname;
          cartBooks.add(cartB);
        }

        hasError = false;
        message = " ok ";
        is_loading = false;
        notifyListeners();
      } else {
        hasError = true;
        message = "false";
        is_loading = false;
        notifyListeners();
      }
    } catch (e) {
      message = "Some think is wrong";
      is_loading = false;
      notifyListeners();
      print(e);
    }
    return {'success': !hasError, 'message': message};
  }

  Future<dynamic> toggleProductFavoriteStatus({
    int? id,
  }) async {
    is_loading_addfovourite = true;
    notifyListeners();
    bool hasError = true;
    String message = "Something is worng";
    var token = await SecureStorageService().readValue(key: AUTH_TOKEN_KEY);
    print(token);
    print(id);
    Map<String, dynamic> favoritedata = {
      'book': id.toString(),
    };
    //notifyListeners();
    try {
      var url =
          Uri.parse('${AppConstants.BASE_URL}${AppConstants.ADD_TO_WISHLISH}');
      http.Response response =
          await http.post(url, body: json.encode(favoritedata), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      print('-------apicall------');
      print(response.body);
      //   Map<String, dynamic> _fatchdata = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        hasError = false;
        message = " This book Add to the Wishlist";
      } else {
        message = 'This book is already in Wishlist';
      }
      is_loading_addfovourite = false;
      notifyListeners();
    } catch (e) {
      is_loading_addfovourite = false;
      message = "Check your Internet Connection !";
      notifyListeners();
      print(e);
    }
    return {'success': !hasError, 'message': message};
  }

  Future<dynamic> toggleProductFavoriteStatusdeleted({
    int? book_id,
  }) async {
    // final bool isCurrentlyFavorite = selectedProduct.isFavorite;
    // final bool newFavoriteStatus = !isCurrentlyFavorite;
    _favouritelist.removeAt(selectProductIndex);
    _selectedproductindex = null;
    print(book_id);
    String message = 'Something went wrong.';
    bool hasError = true;
    //notifyListeners();
    var token = await SecureStorageService().readValue(key: AUTH_TOKEN_KEY);
    try {
      Map<String, dynamic> favoritedata = {
        'book': book_id.toString(),
      };
      // var url = Uri.parse(
      //     'https://dapi.counslink.com/api/v1/profile/remove-from-wishlist/');
      var url = Uri.parse(
          '${AppConstants.BASE_URL}${AppConstants.REMOVE_FROM_WISHLIST}');

      http.Response response =
          await http.delete(url, body: json.encode(favoritedata), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      print(response.body);
      // Map<String, dynamic> _fatchdata = json.decode(response.body);
      if (response.statusCode == 201 || response.statusCode == 204) {
        hasError = false;
        message = "Book removed from wishlist";
      } else {
        message = "Try Again";
      }
      is_loading = false;
      notifyListeners();
    } catch (e) {
      print(e);
      message = "Please Check your Network Connections";
      is_loading = false;
      notifyListeners();
    }
    return {'success': !hasError, 'message': message};
  }
}
