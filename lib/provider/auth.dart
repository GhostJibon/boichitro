import 'dart:convert';
import 'package:dhanshirisapp/constants/app_constants.dart';
import 'package:dhanshirisapp/model/profile_info.dart';
import 'package:dhanshirisapp/screen/user/user_profile.dart';
import 'package:dhanshirisapp/services/secure_storage_service.dart';
import 'package:dhanshirisapp/utill/app_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dhanshirisapp/model/profile_info.dart';

class AuthProvider with ChangeNotifier {
  UserInfos? _userInfo;
  UserInfos? get userInfodata {
    return _userInfo;
  }

  bool isloadingprofileupdate = false;
  bool isloadingsign = false;
  bool isloadingsocailmediasign = false;
  bool isloadingAuth = false;
  String? token;

  Future<Map<String, dynamic>> authentication(
    String phone_no,
    String app_key,
  ) async {
    bool hasError = true;
    String type = '';
    String message = 'Something went wrong.';
    try {
      isloadingsign = true;
      notifyListeners();
      debugPrint("Sign in model is called");
      final Map<String, dynamic> authdata = {
        'phone': phone_no,
        'app_key': app_key
      };
      print(json.encode(authdata) + '\nPhone no: ');
      print(phone_no);
      var url = Uri.parse('${AppConstants.BASE_URL}${AppConstants.SIGNUP_OTP}');
      http.Response response =
          await http.post(url, body: json.encode(authdata), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
      });
      final String res = response.body;
      print(res);
      // print(response.body);
      // final Map<String, dynamic> responseData = json.decode(response.body);
      Map<String, dynamic> mapResponse = JsonDecoder().convert(res);
      print('-------');
      print(mapResponse);
      if (mapResponse['status'] == true &&
          mapResponse['is_existing_user'] == false) {
        hasError = false;
      } else {
        if (mapResponse['status'] == false) {
          if (mapResponse['is_existing_user'] == true) {
            message = "already register";
          }
        } else {
          message = "Not Working perfectly ";
          //message = 'mapResponse';
          print('...........');
          print(message);
        }
        //  hasError = false;
      }
      isloadingsign = false;
      notifyListeners();
    } catch (e) {
      isloadingsign = false;
      notifyListeners();
      print(e);
    }
    return {'success': !hasError, 'message': message, 'type': type};
  }

  //-------------------------------------------------------
  //------------------------------------- Social Media --------
  //---------------------

  Future<Map<String, dynamic>> authenticationSocialMedia(
    String first_name,
    String email,
  ) async {
    bool hasError = true;
    String type = '';
    String message = 'Something went wrong.';
    print('-------------------socialmedia login-----------');
    print(first_name);
    print(email);
    try {
      isloadingsocailmediasign = true;
      notifyListeners();
      debugPrint("Sign in model is called");
      final Map<String, dynamic> authdata = {
        'first_name': first_name,
        'email': email,
      };
      var url = Uri.parse(
          '${AppConstants.BASE_URL}${AppConstants.SOCIALMEDIA_LOGIN}');
      http.Response response =
          await http.post(url, body: json.encode(authdata), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
      });
      final String res = response.body;
      print('----------------response data ----------------');
      print(res);
      // print(response.body);
      // final Map<String, dynamic> responseData = json.decode(response.body);
      Map<String, dynamic> mapResponse = JsonDecoder().convert(res);
      print(mapResponse);
      print('----------------profiledata --------------');
      if (response.statusCode == 200 || response.statusCode == 201) {
        _userInfo = UserInfos.fromjson(mapResponse);
        print(_userInfo!.email);
        print(_userInfo!.full_name);
        print(_userInfo!.gender);
        print(_userInfo!.phone);
      }
      await SecureStorageService()
          .writeValue(key: AUTH_TOKEN_KEY, value: mapResponse['token']);
      hasError = false;
      isloadingsocailmediasign = false;
      notifyListeners();
    } catch (e) {
      message = "Network Issue, Try Again ";
      isloadingsocailmediasign = false;
      notifyListeners();
      print(e);
    }
    return {
      'success': !hasError,
      'message': message,
    };
  }

  refreshtoken() async {
    final Map<String, dynamic> authdata = {
      'phone': "api_user",
      'password': "boichitro@2022",
    };

    var urls =
        Uri.parse('https://boichitro.com.bd/api/v1/auth/api-token-auth/');
    http.Response response =
        await http.post(urls, body: json.encode(authdata), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    print(
        '--------------------------refresh token ------------------------------');
    print(response.body);
    Map<String, dynamic> mapResponse = JsonDecoder().convert(response.body);
    print(
        '--------------------------refresh token ------------------------------');
    print(mapResponse);
    token = mapResponse['access'];
    print(token);
  }

  Future<Map<String, dynamic>> authenticationOTP(
    String phone_no,
    String otp,
    String url,
  ) async {
    bool hasError = true;
    String message = 'Something went wrong.';
    String type = " ";
    try {
      isloadingAuth = true;
      notifyListeners();
      print(phone_no);
      print(otp);
      final Map<String, dynamic> authdata = {
        'phone': phone_no,
        'otp': otp,
      };

      var urls = Uri.parse(url);
      http.Response response =
          await http.post(urls, body: json.encode(authdata), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      final String res = response.body;
      print("Response " + response.body);
      // final Map<String, dynamic> responseData = json.decode(response.body);
      Map<String, dynamic> mapResponse = JsonDecoder().convert(res);
      print('-----=============current token--');
      print(mapResponse);

      if (mapResponse['status'] == true) {
        print('i am right');
        print(type);
        message = "OTP matched, kindly proceed to save password";
        hasError = false;
      } else if (mapResponse['status'] == true &&
          mapResponse['detail'] ==
              "OTP matched, please move forward to reset password") {
        message = "OTP matched, please move forward to reset password";
        // hasError = false;
        //  hasError = false;
      } else {
        message = "OTP invalied,please try again ! ";
      }

      isloadingAuth = false;
      notifyListeners();
    } catch (e) {
      message = "Please check your Internat ! ";
      isloadingAuth = false;
      notifyListeners();
    }

    return {'success': !hasError, 'message': message, 'type': type};
  }

  Future<Map<String, dynamic>> authenticationPassword(
    String phone_no,
    String password,
  ) async {
    print(phone_no);
    print(password);
    final Map<String, dynamic> authdata = {
      'phone': phone_no,
      'password': password,
    };
    var url = Uri.parse('${AppConstants.BASE_URL}${AppConstants.AUTH_LOGIN}');
    http.Response response =
        await http.post(url, body: json.encode(authdata), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    final String res = response.body;
    print('i am calling -------------------------');
    print("HTTP RESPONSE: " + response.body);

    // final Map<String, dynamic> responseData = json.decode(response.body);
    Map<String, dynamic> mapResponse = JsonDecoder().convert(res);
    print('------ token print ======================-');
    print(mapResponse['token']);
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setString(AUTH_TOKEN_KEY, mapResponse['token']);
    await SecureStorageService()
        .writeValue(key: AUTH_TOKEN_KEY, value: mapResponse['token']);
    print(mapResponse);
    http.Response responses;
    try {
      var url =
          Uri.parse('${AppConstants.BASE_URL}${AppConstants.CUSTOMER_PROFILE}');
      responses = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token ${mapResponse['token']}'
      });
      final Map<String, dynamic> responseData =
          json.decode(utf8.decode(responses.bodyBytes));
      print(responses.body);
      print('----------------profiledata --------------');
      if (responses.statusCode == 200 || responses.statusCode == 201) {
        _userInfo = UserInfos.fromjson(responseData);
      }
      //  return {'success': !hasError, 'message': message, 'type': type};
    } catch (e) {}

    bool hasError = true;
    String message = 'Something went wrong.';
    String type = " ";

    if (mapResponse['token'] != null) {
      print('i am right');
      print(type);
      hasError = false;
    } else {
      print('wrong data');
      if (mapResponse['register'] != null) {
        message = "Password is incorrect ! Please try again";
      } else {
        print('i am worng');
        message = " Something is wrong";
        // message = 'mapResponse';
        print('...........');
        print(message);
      }
      //  hasError = false;
    }
    return {'success': !hasError, 'message': message, 'type': type};
  }

  Future<Map<String, dynamic>> authenticationProfiledata(String token) async {
    bool successStatus = false;
    String type = '';
    String message = 'Something went wrong.';
    try {
      print('------customerProfile--------');
      var url =
          Uri.parse('${AppConstants.BASE_URL}${AppConstants.CUSTOMER_PROFILE}');
      http.Response response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token'
      });
      print(response.body);
      final Map<String, dynamic> responseData =
          json.decode(utf8.decode(response.bodyBytes));
      print(response.body);
      print('----------------profiledata --------------');
      if (response.statusCode == 200 || response.statusCode == 201) {
        _userInfo = UserInfos.fromjson(responseData);
        successStatus = true;
      } else {
        message = "Loginscreen";
      }
      //  return {'success': !hasError, 'message': message, 'type': type};
    } catch (e) {
      message = 'No Internet';
      notifyListeners();
      successStatus = false;
    }
    return {'success': successStatus, 'message': message};
  }

  // to get userProfile
  Future<UserInfos> getProfileDetails() async {
    http.Response response;
    var token = await SecureStorageService().readValue(key: AUTH_TOKEN_KEY);

    var url =
        Uri.parse('${AppConstants.BASE_URL}${AppConstants.CUSTOMER_PROFILE}');
    response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token'
    });
    print(response.body);
    final Map<String, dynamic> responseData =
        json.decode(utf8.decode(response.bodyBytes));
    return UserInfos.fromjson(responseData);
  }

  Future<Map<String, dynamic>> profileUpdate(
    String email,
    String gender,
    String full_name,
    String phone,
  ) async {
    bool hasError = true;
    String message = 'Something went wrong.';
    String type = " ";
    isloadingprofileupdate = true;
    notifyListeners();
    try {
      final Map<String, dynamic> authdata = {
        'email': email,
        'phone': phone,
        "gender": gender,
        "full_name": full_name,
      };
      var token = await SecureStorageService().readValue(key: AUTH_TOKEN_KEY);
      print(token);
      // var url = Uri.parse(
      //     'https://dapi.counslink.com/api/v1/profile/customer-profile/update/');

      var url = Uri.parse(
          '${AppConstants.BASE_URL}${AppConstants.CUSTOMER_PROFILE_UPDATE}');
      http.Response response =
          await http.put(url, body: json.encode(authdata), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      final String res = response.body;
      print(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> mapResponse =
            json.decode(utf8.decode(response.bodyBytes));
//     print('-------');
        // print(mapResponse);
        _userInfo = UserInfos.fromjson(mapResponse);
        print('-------');
        print(mapResponse);
        isloadingprofileupdate = false;
        notifyListeners();
        if (_userInfo!.phone.isNotEmpty) {
          hasError = false;
        }
      }
    } catch (e) {
      isloadingprofileupdate = false;
      notifyListeners();
    }
    // final Map<String, dynamic> responseData = json.decode(response.body);
    //  Map<String, dynamic> mapResponse = JsonDecoder().convert(res);
    return {'success': !hasError, 'message': message, 'type': type};
  }

  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future<Map<String, dynamic>> googleLogin() async {
    String? email;
    String? name;
    String? image;
    Map<String, dynamic> mapvalue = {'email': '', 'name': '', 'image': ''};
    try {
      print('i am calling');
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        //return;
      } else {
        _user = googleUser;
        final googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        print(_user);
        print(_user!.email);
        print(_user!.displayName);
        print(_user!.photoUrl);
        name = _user!.displayName;
        email = _user!.email;
        image = _user!.photoUrl;
        mapvalue = {'email': email, 'name': name, 'image': image};
        //  print(credential);
        await FirebaseAuth.instance.signInWithCredential(credential);
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
    return {'message': mapvalue};
  }
}
