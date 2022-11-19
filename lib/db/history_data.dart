final String tableNotes = 'notes';

class NoteFields {
  static final List<String> values = [
    /// Add all fields
    book_id, pagenumber, title, time,
    book_details,
  ];
//  static final String id = 'id';
  static final String book_id = 'book_id';
  static final String pagenumber = 'pagenumber';
  static final String title = 'title';
  static final String time = 'time';
  static final String book_details = 'book_details';
}

class Note {
  //final int? id;
  final int? book_id;
  final int pagenumber;
  final String title;

  final DateTime createdTime;
  final String book_details;

  const Note({
    // this.id,
    this.book_id,
    required this.pagenumber,
    required this.title,
    required this.createdTime,
    required this.book_details,
  });

  Note copy({
    // int? id,
    int? book_id,
    int? pagenumber,
    String? title,
    DateTime? createdTime,
    String? book_details,
  }) =>
      Note(
        //  id: id ?? this.id,
        book_id: book_id ?? this.book_id,
        pagenumber: pagenumber ?? this.pagenumber,
        title: title ?? this.title,
        createdTime: createdTime ?? this.createdTime,
        book_details: book_details ?? this.book_details,
      );

  static Note fromJson(Map<String, Object?> json) => Note(
        // id: json[NoteFields.id] as int?,
        book_id: json[NoteFields.book_id] as int?,
        pagenumber: json[NoteFields.pagenumber] as int,
        title: json[NoteFields.title] as String,

        createdTime: DateTime.parse(json[NoteFields.time] as String),
        book_details: json[NoteFields.book_details] as String,
      );

  Map<String, Object?> toJson() => {
        // NoteFields.id: id,

        NoteFields.book_id: book_id,
        NoteFields.title: title,
        NoteFields.pagenumber: pagenumber,
        NoteFields.time: createdTime.toIso8601String(),
        NoteFields.book_details: book_details,
      };
}
