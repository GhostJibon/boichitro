import 'package:flutter/material.dart';

class SubcriptionType {
  int? id;
  String? title;
  String? sub_title;
  double? limit_in_month;
  double? cost;

  SubcriptionType({
    @required this.id,
    @required this.title,
    @required this.sub_title,
    @required this.limit_in_month,
    @required this.cost,
  });

  factory SubcriptionType.fromJson(Map<String, dynamic> map) {
    return SubcriptionType(
      id: map['id'],
      title: map['title'].toString(),
      sub_title: map['sub_title'].toString(),
      limit_in_month: double.parse(map['limit_in_month'].toString()),
      cost: double.parse(map['cost'].toString()),
    );
  }
}
