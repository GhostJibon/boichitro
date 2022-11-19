import 'dart:convert';

import 'package:dhanshirisapp/utill/app_constants.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductList {
  int? pk;
  String? short_name;
  String? rating;
  String? bookname;
  String? cover_image;
  String? description;
  String? edition;
  String? isbn;
  String? cover_note;
  String? author;
  String? publisher;
  String? book_type;
  bool? is_paid;

  ProductList({
    @required this.pk,
    @required this.short_name,
    @required this.rating,
    @required this.bookname,
    @required this.cover_image,
    @required this.description,
    @required this.edition,
    @required this.cover_note,
    @required this.isbn,
    @required this.author,
    @required this.publisher,
    required this.book_type,
    required this.is_paid,
  });
}

class CategoriesProductListModel with ChangeNotifier {
  List<ProductList>? _ProductList = [];

  List<ProductList>? get Product {
    return _ProductList;
  }

  Future<dynamic>? clearproductlist() {
    _ProductList = [];
    // notifyListeners();
    next = ' ';
    isloading = true;
    notifyListeners();
  }

  bool isloading = true;
  String? next;

  Future<Map<String, dynamic>> deshboardcontians(
      token, offset, category, sort_order, search) async {
    print(' --------- search by short ---------');
    print(token);
    print(category);
    print(sort_order);
    print(search);
    print(offset);
    String? categorys;

    isloading = true;
    // if (next != 'null') {
    try {
      _ProductList = [];
      print(search);
      String? search_by_short;
      if (sort_order == 'বইয়ের নাম') {
        search_by_short = "book_name";
      } else if (sort_order == "রেটিং") {
        search_by_short = "rating";
      }

      if (category == "Recent") {
        print('recest----');
        categorys = "recent";
      } else if (category == "Populor") {
        categorys = "populor";
      } else {
        categorys = category;
      }

      print(search_by_short);
      print('000000000');
      print(categorys);
      print(category);
      // Uri url = Uri.parse(
      //     'https://dapi.counslink.com/api/v1/archive/search-book/?category=$category&sort_order=$search_by_short&search=$search&limit=10&offset=$offset');

      Uri url = Uri.parse(
          '${AppConstants.BASE_URL}${AppConstants.SEARCH_BOOK}?category=$categorys&sort_order=$search_by_short&q_string=$search&limit=50&offset=$offset');
      http.Response response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token $token',
        },
      );
      final String res = response.body;
      List<ProductList> _dataList = [];
      print("decode fatchdata");
      //   print(response.body);\
      Map<String, dynamic> mapResponse =
          json.decode(utf8.decode(response.bodyBytes));
      // Map<String, dynamic> mapResponse = JsonDecoder().convert(response.body);
      print(mapResponse);
      next = mapResponse['next'];
      if (next == null) {
        next = 'null';
        notifyListeners();
      }

      // List<dynamic> _fatchdata = json.decode(response.body);
      mapResponse['results'].forEach((dynamic datalist) {
        final ProductList _product = ProductList(
            pk: datalist['pk'],
            short_name: datalist['short_name'],
            bookname: datalist['book_name'],
            cover_image: datalist['cover_image'],
            rating: datalist['rating'].toString(),
            description: datalist['description'],
            edition: datalist['edition'],
            isbn: datalist['isbn'],
            cover_note: datalist['cover_note'],
            is_paid: datalist['is_paid'],
            author: datalist['author_name'].toString(),
            publisher: datalist['publisher'].toString(),
            book_type: datalist['book_type'].toString());

        print(_product.cover_image);

        if (_product.book_type != 'audiobook') {
          print('-----------------------pk------------------');
          print(_product.pk);
          _dataList.add(_product);
        }
      });
      print(_dataList.length);
      isloading = false;
      notifyListeners();
      _ProductList = _dataList;
    } catch (e) {
      isloading = false;
      print(e);
    }
    // }
    return {'message': 'message'};
  }
}
