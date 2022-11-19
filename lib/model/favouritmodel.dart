import 'package:flutter/material.dart';

class FavouriteProduct {
  int? pk;
  int? book_id;
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
  String? book_image_url;
  bool? is_paid;
  FavouriteProduct({
    @required this.pk,
    @required this.short_name,
    @required this.book_id,
    @required this.rating,
    @required this.bookname,
    @required this.cover_image,
    @required this.description,
    @required this.edition,
    @required this.cover_note,
    @required this.isbn,
    @required this.author,
    @required this.publisher,
    required this.book_image_url,
    required this.is_paid,
  });

  factory FavouriteProduct.fromJson(Map<String, dynamic> map) {
    return FavouriteProduct(
        pk: map['id'],
        short_name: map['book']['short_name'],
        book_image_url: map['book']['book_image_url'],
        book_id: map['book']['pk'],
        bookname: map['book']['book_name'],
        cover_image: map['book']['cover_image'],
        rating: map['book']['rating'],
        description: map['book']['description'],
        edition: map['book']['edition'],
        isbn: map['book']['isbn'],
        is_paid: map['book']['is_paid'],
        author: map['book']['author_name'].toString(),
        publisher: map['book']['publisher_name'].toString(),
        cover_note: map['book']['cover_note']);
  }
}
