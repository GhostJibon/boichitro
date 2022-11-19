import 'package:flutter/material.dart';
class RecentItem {
  int? pk;
  String? short_name;
  String? rating;
  String? bookname;
  String? cover_image;
  String? description;
  String? edition;
  String? isbn;
  String? cover_note;
  String? author;
  String? publisher;

  RecentItem({
    @required this.pk,
    @required this.short_name,
    @required this.rating,
    @required this.bookname,
    @required this.cover_image,
    @required this.description,
    @required this.edition,
    @required this.cover_note,
    @required this.isbn,
    @required this.author,
    @required this.publisher,
  });

  // factory RecentItem.fromJson(Map map){
  //   return
  // }
}