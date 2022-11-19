class BookRequestModel {
  String? additional_note;
  String? request_body;
  String? request_title;
  String? status;

  BookRequestModel({
    required this.request_title,
    required this.request_body,
    required this.additional_note,
    required this.status,
  });

  factory BookRequestModel.fromJson(Map<String, dynamic> map) {
    return BookRequestModel(
        request_body: map['request_body'],
        request_title: map['request_title'],
        additional_note: map['additional_note'],
        status: map['book_request_status'] == null
            ? ' '
            : map['book_request_status']);
  }
}
