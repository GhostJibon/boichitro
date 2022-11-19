import 'package:dhanshirisapp/constants/app_constants.dart';
import 'package:dhanshirisapp/db/history_database.dart';
import 'package:dhanshirisapp/db/history_data.dart';
import 'package:dhanshirisapp/provider/book_read.dart';
import 'package:dhanshirisapp/provider/highlight.dart';
import 'package:dhanshirisapp/provider/order.dart';
import 'package:dhanshirisapp/screen/book_read_page/book_read_page.dart';
import 'package:dhanshirisapp/screen/book_read_page_details.dart';
import 'package:dhanshirisapp/screen/book_read_screen.dart';
import 'package:dhanshirisapp/services/secure_storage_service.dart';
import 'package:dhanshirisapp/widget/drower_customer/add_drower_customer.dart';
import 'package:dhanshirisapp/widget/no_data_available.dart';
import 'package:dhanshirisapp/widget/splash_screen/appdrawerbook.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class BookApiCall extends StatefulWidget {
  final int? book_id;
  final String? book_name;
  //final bool is_pdf;
  BookApiCall({
    required this.book_id,
    required this.book_name,
    //required this.is_pdf
  });
  @override
  _BookApiCallState createState() => _BookApiCallState();
}

class _BookApiCallState extends State<BookApiCall> {
  late List<Note> notes;
  Note? notesdata;
  String? book_details;
  @override
  void didChangeDependencies() async {
    // notes = await NotesDatabase.instance.readAllNotes();
    // print('-----notes-----');
    // for (int i = 0; i < notes.length; i++) {
    //   if (notes[i].book_id == widget.book_id!) {
    //     notesdata = notes[i];
    //   } else {
    //     notesdata = null;
    //   }
    //   print(notes[i].book_id);
    // }
    //------initial call-------
    var token = await SecureStorageService().readValue(key: AUTH_TOKEN_KEY);
    print(token);
    BookReadtModel bookReadtModel =
        Provider.of<BookReadtModel>(context, listen: false);
    HighlightProvider highlightProvider =
        Provider.of<HighlightProvider>(context, listen: false);
    highlightProvider.clean();
    print('----------------book_id--------------');
    print(widget.book_id);
    Map<String, dynamic>? data =
        await bookReadtModel.bookreadapicall(token, widget.book_id!);
    book_details = data!['book_details'];
    // Map<String, dynamic>? audiobook =
    //     await bookReadtModel.audioBookapicall(token, widget.book_id);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Orther order = Provider.of<Orther>(context);
    // bool is_pdf = true;
    return Scaffold(
      body:
          // widget. is_pdf
          //     ? Text("data")
          //     :
          Container(
              child: Consumer<BookReadtModel>(
                  child: Center(child: CircularProgressIndicator()),
                  builder: (context, model, child) {
                    return model.isloadingmodel
                        ? child as Widget
                        : model.BookPage!.length == 0
                            ? NodataAvailableClass('Book is Empty !', 80.0.h)
                            : BookReadPage(
                                book_details: book_details,
                                book_id: widget.book_id,
                                book_name: widget.book_name,
                                bookpagemodel: model,
                                orther: order,
                              );
                  })),
    );
  }
}
