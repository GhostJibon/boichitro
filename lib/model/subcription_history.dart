import 'package:flutter/material.dart';

class SubcriptionHistorys {
  String? limit_in_month;
  String? total_cost;
  String? start_date;
  String? end_date;

  SubcriptionHistorys(
      {@required this.limit_in_month,
      @required this.total_cost,
      @required this.start_date,
      @required this.end_date});

  factory SubcriptionHistorys.fromJson(Map<String, dynamic> map) {
    return SubcriptionHistorys(
        limit_in_month: map['limit_in_month'],
        total_cost: map['total_cost'],
        start_date: map['start_date'],
        end_date: map['end_date']);
  }
}
