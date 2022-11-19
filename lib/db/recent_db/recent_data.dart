// final String tableNotes = 'notes';

// class RecentFields {
//   static final List<String> values = [
//     /// Add all fields
//     book_id,  short_name,rating,bookname,cover_image,description,edition,isbn,
//   ];
// //  static final String id = 'id';
//   static final String book_id = 'book_id';
//   static final String short_name = 'short_name';
//   static final String rating = 'rating';
//   static final String bookname = 'bookname';
//   static final String cover_image = 'cover_image';
//   static final String description = 'description';
//   static final String edition = 'edition';
//   static final String isbn = 'isbn';
//   static final String cover_note = 'cover_note';
//   static final String author = 'author';
//   static final String publisher = 'publisher';
// }

// class Recent {
//   //final int? id;

//   ///int? pk;
// final  String? book_id;
//  final String? short_name;
//  final String? rating;
//  final String? bookname;
//  final String? cover_image;
//  final String? description;
//  final String? edition;
//  final String? isbn;
//  final String? cover_note;
//  final String? author;
//  final String? publisher;
//   final DateTime createdTime;

//   const Recent({
//     // this.id,
//     this.book_id,
//     required this.short_name,
//     required this.rating,
//     required this.bookname,
//     required this.cover_image,
//     required this.description,
//     required this.edition,
//     required this.isbn,
//     required this.cover_note,
//     required this.author,
//     required this.publisher,
//     required this.createdTime,
//   });

//   Recent copy({
//     // int? id,
   
//  String? book_id,
//   String? short_name;
//   String? rating;
//   String? bookname;
//   String? cover_image;
//   String? description;
//  final String? edition;
//  final String? isbn;
//  final String? cover_note;
//  final String? author;
//  final String? publisher;
//   final DateTime createdTime;
  
//   }) =>
//       Recent(
//         //  id: id ?? this.id,
//         book_id: book_id ?? this.book_id,
//         pagenumber: pagenumber ?? this.pagenumber,
//         title: title ?? this.title,
//         createdTime: createdTime ?? this.createdTime,
//         book_details: book_details ?? this.book_details,
//       );

//   static Recent fromJson(Map<String, Object?> json) => Recent(
//         // id: json[NoteFields.id] as int?,
//         book_id: json[RecentFields.book_id] as int?,
    

//         createdTime: DateTime.parse(json[RecentFields.time] as String),
   
//       );

//   Map<String, Object?> toJson() => {
//         // NoteFields.id: id,

//         RecentFields.book_id: book_id,
//         RecentFields.title: title,
//         RecentFields.pagenumber: pagenumber,
//         RecentFields.time: createdTime.toIso8601String(),
//         RecentFields.book_details: book_details,
//       };
// }
