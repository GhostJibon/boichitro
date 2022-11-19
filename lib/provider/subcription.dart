import 'dart:convert';

import 'package:dhanshirisapp/model/current_subcription.dart';
import 'package:dhanshirisapp/model/subcription_history.dart';
import 'package:dhanshirisapp/model/subcription_type.dart';
import 'package:dhanshirisapp/utill/app_constants.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SubcriptionModel with ChangeNotifier {
  CurrentSubcriptionClass? _currentsubcription;
  List<SubcriptionHistorys>? _subcriptionHistory = [];
  List<SubcriptionType>? _subcriptionType = [];
  CurrentSubcriptionClass? get CurrentSubcriptionData => _currentsubcription;
  List<SubcriptionType>? get Subcriptiontypedata => _subcriptionType;
  List<SubcriptionHistorys>? get subcriptionHistorys => _subcriptionHistory;
  bool isloadingmodelcurrent = true;
  bool isloadingmodel = true;
  bool isloadingsubcriptionhistory = true;

  Future<Map<String, dynamic>?> currentsubcriptionAPICALL(token) async {
    isloadingmodelcurrent = true;
    notifyListeners();
    try {
      // var url = Uri.parse(
      //     'https://dapi.counslink.com/api/v1/subscription/my-subscription/');
      var url =
          Uri.parse('${AppConstants.BASE_URL}${AppConstants.MY_SUBCRIPTION}');
      http.Response response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      Map<String, dynamic> mapResponse = JsonDecoder().convert(response.body);
      // final Map<String, dynamic> responseData =
      //     json.decode(utf8.decode(response.bodyBytes));
      print(mapResponse);
      //print(mapResponse['results'][0]);
      print('----------------profiledata --------------');
      // if (response.statusCode == 200 || response.statusCode == 201) {

      _currentsubcription =
          CurrentSubcriptionClass.fromjson(mapResponse['results'][0]);
      print(_currentsubcription!.total_cost.toString());
      //  }

      isloadingmodelcurrent = false;
      notifyListeners();
    } catch (e) {
      isloadingmodelcurrent = false;
      notifyListeners();
      print(e);
    }
  }

//------------ subcription history -------------------
  Future<Map<String, dynamic>?> subcriptionHistoryAPICALL(token) async {
    isloadingsubcriptionhistory = true;
    notifyListeners();
    try {
      // var url = Uri.parse(
      //     'https://dapi.counslink.com/api/v1/subscription/my-subscription-history/');
      var url = Uri.parse(
          '${AppConstants.BASE_URL}${AppConstants.MY_SUBCRIPTION_HISTORY}');
      http.Response response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });

      Map<String, dynamic> mapResponse = JsonDecoder().convert(response.body);
      // final Map<String, dynamic> responseData =
      //     json.decode(utf8.decode(response.bodyBytes));
      print(mapResponse['results'][0]);
      print('---------------- subcription history --------------');
      print(response.body);
      List<SubcriptionHistorys> _subcriptionhistorytemp = [];
      if (response.statusCode == 200 || response.statusCode == 201) {
        mapResponse['results'].forEach((dynamic data) {
          final SubcriptionHistorys _recentBooks =
              SubcriptionHistorys.fromJson(data);
          _subcriptionhistorytemp.add(_recentBooks);
        });
        // SubcriptionHistorys _subcription =
        //     SubcriptionHistorys.fromJson(mapResponse['results']);
        //SubcriptionHistorys.fromjson(mapResponse['results']);

        _subcriptionHistory = _subcriptionhistorytemp;
        isloadingsubcriptionhistory = false;
        notifyListeners();
      }
      isloadingsubcriptionhistory = false;
      notifyListeners();
    } catch (e) {
      isloadingsubcriptionhistory = false;
      notifyListeners();
      print(e);
    }
  }

//------------ subcription Type -------------------
  Future<Map<String, dynamic>?> subcriptionTYPEAPICALL(token) async {
    isloadingmodel = true;
    notifyListeners();
    List<SubcriptionType>? _subcriptiontypetem = [];
    try {
      // var url = Uri.parse(
      //     'https://dapi.counslink.com/api/v1/subscription/subscription-types/');
      var url = Uri.parse(
          '${AppConstants.BASE_URL}${AppConstants.SUBCRIPTION_TYPES}');
      http.Response response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      print(
          '-----------------------------------------------123-------------------------------------------------12323-----------------------------------------------------');
      Map<String, dynamic> mapResponse = JsonDecoder().convert(response.body);
      // final Map<String, dynamic> responseData =
      //     json.decode(utf8.decode(response.bodyBytes));
      print(mapResponse);
      print('----------------profiledata --------------');
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //----parse recent books-----
      // var result = mapResponse['results'];
      // print(result);
      // var x = (result as List).cast<String>();
      // print(x);
      // if (x.length == 0) {
      //   print('i am realy working');
      // } else {
      //   print(' i am not working');
      mapResponse['results'].forEach((dynamic data) {
        final SubcriptionType _subcrip = SubcriptionType.fromJson(data);
        print(_subcrip.id);
        print(_subcrip.cost);
        print(_subcrip.title);
        print(_subcrip.limit_in_month);
        print(_subcrip.sub_title);
        _subcriptiontypetem.add(_subcrip);
      });
      _subcriptionType = _subcriptiontypetem;
      isloadingmodel = false;
      // notifyListeners();
      // }
      notifyListeners();
      // }
    } catch (e) {
      isloadingmodel = false;
      notifyListeners();
      print(e);
    }
  }

  //------------ subcription Type -------------------
  Future<Map<String, dynamic>?> subcriptionCrate(token, user_id) async {
    isloadingmodel = true;
    notifyListeners();
    List<SubcriptionType>? _subcriptiontypetem = [];
    print(user_id);
    Map<String, dynamic> mapbody = {
      'subscription_type': user_id,
    };
    print('99999999999999999999');
    print(token);
    print(user_id);
    try {
      // var url = Uri.parse(
      //     'https://dapi.counslink.com/api/v1/subscription/create-subscription/');
      var url = Uri.parse(
          '${AppConstants.BASE_URL}${AppConstants.CREATE_SUBCRIPTION}');
      http.Response response =
          await http.post(url, body: json.encode(mapbody), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      });
      print(response.body);

      isloadingmodel = false;
      // notifyListeners();
      // }
      notifyListeners();
    } catch (e) {
      isloadingmodel = false;
      notifyListeners();
      print(e);
    }
  }
}
