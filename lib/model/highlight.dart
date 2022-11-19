import 'package:flutter/material.dart';

class HighLight {
  int? page_number;
  int? start;
  int? end;

  HighLight(
      {required this.page_number, required this.start, required this.end, req});

  factory HighLight.fromJson(Map<String, dynamic> map) {
    return HighLight(
        page_number: map['page_number'], start: map['start'], end: map['end']);
  }
}
