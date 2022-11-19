// import 'dart:convert';

// import 'package:dhanshirisapp/model/history_data.dart';
// import 'package:dio/dio.dart' as dio;
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class HistoryProvider with ChangeNotifier {
// // ignore: non_constant_identifier_names
//   Map<String, HistoryData> items = {};
//   int get itemsCount {
//     return items.length;
//   }
//   void addhistory(
//       {String? book_name, int? book_id, int? pagenumbers, String? time}) {
//     // print(cat_id);
//     // print(vendor_id);
//     // print(invoice_no);
//     print('--------Stape first ----------');
//     print(book_name);
//     print(book_id);
//     print(pagenumbers);
//     print(time);
//     if (items.containsKey(book_id.toString())) {
//       items.update(book_id.toString(), (value) {
//         print('---stap two ----');
//         print('--------update---------');
//         return HistoryData(
//           book_id: value.book_id,
//           book_name: value.book_name,
//           pagenumber: pagenumbers,
//           time: value.time,
//         );
//       });
//       print('--------update9999---------');
//       var data = items.values.toList();
//       print(data[0].pagenumber);
//       notifyListeners();
//     } else {
//       items.putIfAbsent(book_id.toString(), () {
//         print('-----stape three -----');
//         print('-------first_time---------');
//         return HistoryData(
//           book_id: book_id,
//           book_name: book_name,
//           pagenumber: pagenumbers,
//           time: time,
//         );
//       });
//     }
//     notifyListeners();
//   }

//   void incrementCartiteam(
//       {String? book_name, int? book_id, int? pagenumber, String? time}) async {
//     try {
//       items.update(book_id.toString(), (value) {
//         print('update completed');
//         print(pagenumber);
//         return HistoryData(
//           book_id: value.book_id,
//           book_name: value.book_name,
//           pagenumber: value.pagenumber,
//           time: value.time,
//         );
//       });
//       notifyListeners();
//       //------count total amount ----
//     } catch (e) {}
//     notifyListeners();
//   }
// }
