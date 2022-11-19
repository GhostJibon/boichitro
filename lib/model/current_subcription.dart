import 'package:flutter/material.dart';

class CurrentSubcriptionClass {
  int? customar;
  String? total_cost;
  String? limit_in_month;
  String? start_date;
  String? end_date;
  String? days_remaining;
  double? percentage;

  CurrentSubcriptionClass(
      {@required this.customar,
      @required this.total_cost,
      @required this.limit_in_month,
      @required this.start_date,
      @required this.end_date,
      @required this.days_remaining,
      @required this.percentage});

  factory CurrentSubcriptionClass.fromjson(Map<String, dynamic> map) {
    return CurrentSubcriptionClass(
      customar: map['customer'] != null ? map['customer'] : 0,
      total_cost: map['total_cost'] != null ? map['total_cost'] : " ",
      limit_in_month:
          map['limit_in_month'] != null ? map['limit_in_month'] : " ",
      start_date: map['start_date'] != null ? map['start_date'] : " ",
      end_date: map['end_date'] != null ? map['end_date'].toString() : " ",
      days_remaining: map['days_remaining'] != null
          ? map['days_remaining'].toString()
          : " ",
      percentage: map['percentage'] != null ? map['percentage'] : 0.0,
    );
  }
}
