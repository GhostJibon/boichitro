// import 'dart:convert';

// import 'package:flutter/material.dart';

// import 'package:dio/dio.dart' as dio;
// import 'package:http/http.dart' as http;

// class SingUpModel with ChangeNotifier {
//   String token =
//       "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjMxNzIzMDQzLCJqdGkiOiJlNDgyNDczNDMxYjI0YzRhOTM1NWEwZDc4ZmU5NWM5MyIsInVzZXJfaWQiOjI4fQ.PuvMJO920KRb5fuZJNf9og9g4ctaD9UBjcnHMSOzGr8";
//   Future<Map<String, dynamic>> authentication(
//     String name,
//     String phone,
//     String email,
//     String password,
//   ) async {
//     print('i am working ');
//     print(name);
//     print(phone);
//     print(email);
//     print(password);

//     final Map<String, dynamic> authdata = {
//       'name': name,
//       'email': email,
//       'phone': phone,
//       'password': password,
//     };

//     var url =
//         Uri.parse('https://dapi.counslink.com/api/v1/auth/complete-signup/');

//     http.Response response =
//         await http.post(url, body: json.encode(authdata), headers: {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $token',
//     });
//     final String res = response.body;
//     print(res);
//     Map<String, dynamic> mapResponse = JsonDecoder().convert(res);
//     print(mapResponse);
//     bool hasError = true;
//     String message = 'Something went wrong.';
//     if (mapResponse['status'] == true) {
//       hasError = false;
//     }

//     return {'success': !hasError, 'message': message};
//   }

//   Future<Map<String, dynamic>> setresetPaassword(
//     String phone_no,
//     String otp,
//     String password,
//   ) async {
//     print('i am working ');
//     print(password);
//     final Map<String, dynamic> authdata = {
//       'phone': phone_no,
//       'otp': otp,
//       'password': password,
//     };
//     var url =
//         Uri.parse('https://dapi.counslink.com/api/v1/auth/reset-password/');
//     http.Response response =
//         await http.post(url, body: json.encode(authdata), headers: {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $token',
//     });
//     final String res = response.body;
//     print(res);
//     Map<String, dynamic> mapResponse = JsonDecoder().convert(res);
//     print(mapResponse);
//     bool hasError = true;
//     String message = 'Something went wrong.';
//     if (mapResponse['status'] == true) {
//       hasError = false;
//     }
//     return {'success': !hasError, 'message': message};
//   }
// }
