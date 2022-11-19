import 'package:flutter/material.dart';

class BookInfo {
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
  String? book_type;
  String? book_image_url;
  String? banner_image;
  bool? is_paid;

  BookInfo({
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
    required this.banner_image,
    required this.is_paid,
    required this.book_image_url,
    required this.book_type,
  });

  factory BookInfo.fromJson(Map<String, dynamic> map) {
    return BookInfo(
        pk: map['pk'],
        short_name: map['fields']['short_name'],
        bookname: map['fields']['book_name'],
        cover_image: map['fields']['cover_image'],
        banner_image: map['fields']['banner_image'],
        rating: map['fields']['rating'].toString(),
        description: map['fields']['description'],
        edition: map['fields']['edition'],
        isbn: map['fields']['isbn'],
        author: map['fields']['author'],
        publisher: map['fields']['publisher'],
        cover_note: map['fields']['cover_note'],
        book_type: map['fields']['book_type'],
        is_paid:
            map['fields']['is_paid'] == null ? false : map['fields']['is_paid'],
        book_image_url: map['fields']['book_image_url']);
  }
}
