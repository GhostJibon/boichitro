// import 'dart:convert';
// import 'package:dhanshirisapp/constants/app_constants.dart';
// import 'package:dhanshirisapp/model/profile_info.dart';
// import 'package:dhanshirisapp/screen/user_profile.dart';
// import 'package:dhanshirisapp/services/secure_storage_service.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class ProfileModel with ChangeNotifier {
//   UserInfo? _userInfo;
//   UserInfo? get userInfodata {
//     return _userInfo;
//   }

//   bool isloadingprofileupdate = false;

//   Future<Map<String, dynamic>> authenticationProfiledata(String token) async {
//     bool successStatus = false;
//     String type = '';
//     String message = 'Something went wrong.';
//     http.Response response;
//     try {
//       var url = Uri.parse(
//           'http://www.dapi.counslink.com/api/v1/profile/customer-profile/');
//       response = await http.get(url, headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': 'Token $token'
//       });
//       final Map<String, dynamic> responseData =
//           json.decode(utf8.decode(response.bodyBytes));
//       print(response.body);
//       print('----------------profiledata --------------');
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         _userInfo = UserInfo.fromjson(responseData);
//         successStatus = true;
//       }
//       //  return {'success': !hasError, 'message': message, 'type': type};
//     } catch (e) {
//       message = e.toString();
//       successStatus = false;
//     }
//     return {'success': successStatus, 'message': message};
//   }

//   // to get userProfile
//   Future<UserInfo> getProfileDetails() async {
//     http.Response response;
//     var token = await SecureStorageService().readValue(key: AUTH_TOKEN_KEY);

//     var url = Uri.parse(
//         'http://www.dapi.counslink.com/api/v1/profile/customer-profile/');
//     response = await http.get(url, headers: {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization': 'Token $token'
//     });
//     print(response.body);
//     final Map<String, dynamic> responseData =
//         json.decode(utf8.decode(response.bodyBytes));
//     return UserInfo.fromjson(responseData);
//   }

//   Future<Map<String, dynamic>> profileUpdate(
//     String email,
//     String gender,
//     String full_name,
//   ) async {
//     bool hasError = true;
//     String message = 'Something went wrong.';
//     String type = " ";
//     isloadingprofileupdate = true;
//     notifyListeners();
//     try {
//       final Map<String, dynamic> authdata = {
//         'email': email,
//         "gender": gender,
//         "full_name": full_name,
//       };
//       var token = await SecureStorageService().readValue(key: AUTH_TOKEN_KEY);
//       print(token);
//       var url = Uri.parse(
//           'https://dapi.counslink.com/api/v1/profile/customer-profile/update/');
//       http.Response response =
//           await http.put(url, body: json.encode(authdata), headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': 'Token $token',
//       });
//       final String res = response.body;
//       print(response.body);
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> mapResponse =
//             json.decode(utf8.decode(response.bodyBytes));
// //     print('-------');
//         // print(mapResponse);
//         _userInfo = UserInfo.fromjson(mapResponse);
//         print('-------');
//         print(mapResponse);
//         isloadingprofileupdate = false;
//         notifyListeners();
//         if (_userInfo!.phone.isNotEmpty) {
//           hasError = false;
//         }
//       }
//     } catch (e) {
//       isloadingprofileupdate = false;
//       notifyListeners();
//     }

//     // final Map<String, dynamic> responseData = json.decode(response.body);
//     //  Map<String, dynamic> mapResponse = JsonDecoder().convert(res);
//     return {'success': !hasError, 'message': message, 'type': type};
//   }
// }
