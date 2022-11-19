// import 'dart:convert';
// import 'package:dhanshirisapp/constants/app_constants.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import '../services/secure_storage_service.dart';

// class SingInModel with ChangeNotifier {
//   bool isloadingsign = false;
//   bool isloadingAuth = false;
//   String token =
//       "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoyNDk1Nzk0NTg0LCJqdGkiOiJjZjVkMGUzZjg2YTU0NGM3ODczZmExNjUxYzMwOWE1MyIsInVzZXJfaWQiOjI4fQ.TlMcVGiu7W_ObmR5kY-lReV4rFa2IJd3uHZI8lCXRBY";

//   Future<Map<String, dynamic>> authentication(
//     String phone_no,
//     String app_key,
//   ) async {
//     bool hasError = true;
//     String type = '';
//     String message = 'Something went wrong.';
//     try {
//       isloadingsign = true;
//       notifyListeners();
//       debugPrint("Sign in model is called");
//       final Map<String, dynamic> authdata = {
//         'phone': phone_no,
//         'app_key': app_key
//       };
//       print(json.encode(authdata) + '\nPhone no: ');
//       print(phone_no);
//       var url =
//           Uri.parse('https://dapi.counslink.com/api/v1/auth/send-signup-otp/');
//       http.Response response =
//           await http.post(url, body: json.encode(authdata), headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $token',
//       });
//       final String res = response.body;
//       print(res);
//       // print(response.body);
//       // final Map<String, dynamic> responseData = json.decode(response.body);
//       Map<String, dynamic> mapResponse = JsonDecoder().convert(res);
//       print('-------');
//       print(mapResponse);
//       if (mapResponse['status'] == true &&
//           mapResponse['is_existing_user'] == false) {
//         hasError = false;
//       } else {
//         if (mapResponse['status'] == false) {
//           if (mapResponse['is_existing_user'] == true) {
//             message = "already register";
//           }
//         } else {
//           message = "Not Working perfectly ";
//           //message = 'mapResponse';
//           print('...........');
//           print(message);
//         }
//         //  hasError = false;
//       }
//       isloadingsign = false;
//       notifyListeners();
//     } catch (e) {
//       isloadingsign = false;
//       notifyListeners();
//       print(e);
//     }
//     return {'success': !hasError, 'message': message, 'type': type};
//   }

//   Future<Map<String, dynamic>> authenticationOTP(
//     String phone_no,
//     String otp,
//     String url,
//   ) async {
//     bool hasError = true;
//     String message = 'Something went wrong.';
//     String type = " ";
//     try {
//       isloadingAuth = true;
//       notifyListeners();
//       print(phone_no);
//       print(otp);
//       final Map<String, dynamic> authdata = {
//         'phone': phone_no,
//         'otp': otp,
//       };
//       var urls = Uri.parse(url);
//       http.Response response =
//           await http.post(urls, body: json.encode(authdata), headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $token',
//       });
//       final String res = response.body;
//       print("Response " + response.body);
//       // final Map<String, dynamic> responseData = json.decode(response.body);
//       Map<String, dynamic> mapResponse = JsonDecoder().convert(res);
//       print('-----=============current token--');
//       print(mapResponse);

//       if (mapResponse['status'] == true) {
//         print('i am right');
//         print(type);
//         message = "OTP matched, kindly proceed to save password";
//         hasError = false;
//       } else if (mapResponse['status'] == true &&
//           mapResponse['detail'] ==
//               "OTP matched, please move forward to reset password") {
//         message = "OTP matched, please move forward to reset password";
//         // hasError = false;
//         //  hasError = false;
//       } else {
//         message = "OTP invalied,please try again ! ";
//       }

//       isloadingAuth = false;
//       notifyListeners();
//     } catch (e) {
//       message = "Please check your Internat ! ";
//       isloadingAuth = false;
//       notifyListeners();
//     }

//     return {'success': !hasError, 'message': message, 'type': type};
//   }

//   Future<Map<String, dynamic>> authenticationPassword(
//     String phone_no,
//     String password,
//   ) async {
//     print(phone_no);
//     print(password);
//     final Map<String, dynamic> authdata = {
//       'phone': phone_no,
//       'password': password,
//     };
//     var url = Uri.parse('https://dapi.counslink.com/api/v1/auth/login/');
//     http.Response response =
//         await http.post(url, body: json.encode(authdata), headers: {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $token',
//     });
//     final String res = response.body;
//     print('i am calling -------------------------');
//     print("HTTP RESPONSE: " + response.body);

//     // final Map<String, dynamic> responseData = json.decode(response.body);
//     Map<String, dynamic> mapResponse = JsonDecoder().convert(res);
//     print('------ token print ======================-');
//     print(mapResponse['token']);
//     //SharedPreferences prefs = await SharedPreferences.getInstance();
//     // await prefs.setString(AUTH_TOKEN_KEY, mapResponse['token']);
//     await SecureStorageService()
//         .writeValue(key: AUTH_TOKEN_KEY, value: mapResponse['token']);
//     print(mapResponse);

//     bool hasError = true;
//     String message = 'Something went wrong.';
//     String type = " ";

//     if (mapResponse['token'] != null) {
//       print('i am right');
//       print(type);
//       hasError = false;
//     } else {
//       print('wrong data');
//       if (mapResponse['register'] != null) {
//         message = "Password is incorrect ! Please try again";
//       } else {
//         print('i am worng');
//         message = " Something is wrong";
//         // message = 'mapResponse';
//         print('...........');
//         print(message);
//       }
//       //  hasError = false;
//     }
//     return {'success': !hasError, 'message': message, 'type': type};
//   }
// }
