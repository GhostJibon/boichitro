import 'dart:convert';

import 'package:http/http.dart';

class ReviewList {
  int? id;
  String? subject;
  String? name;
  String? comment;
  String? rating;
  ReviewList(
      {required this.id,
      required this.subject,
      required this.name,
      required this.comment,
      required this.rating});
  factory ReviewList.fromJson(Map<String, dynamic> map) {
    return ReviewList(
      id: map['id'],
      name: map['name'],
      comment: map['comment'],
      subject: map['subject'],
      rating: map['rating'],
    );
  }
}
