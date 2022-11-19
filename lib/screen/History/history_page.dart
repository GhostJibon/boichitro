import 'package:dhanshirisapp/db/history_database.dart';
import 'package:dhanshirisapp/db/history_data.dart';
import 'package:dhanshirisapp/screen/History/widget/history_cart.dart';
import 'package:dhanshirisapp/screen/History/widget/history_details.dart';
import 'package:dhanshirisapp/screen/History/widget/note_card_widget.dart';
import 'package:dhanshirisapp/translations/locale_keys.g.dart';
import 'package:dhanshirisapp/widget/no_data_available.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../provider/auth.dart';
import '../../provider/theme_provider.dart';
import '../../res/colors.dart';

class HistoryPage extends StatefulWidget {
  static const routeName = "/history-screen";
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<HistoryPage> {
  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  @override
  void dispose() {
    // NotesDatabase.instance.close();
    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);
    this.notes = await NotesDatabase.instance.readAllNotes();
    print('-----notes-----');
    for (int i = 0; i < notes.length; i++) {
      print(notes[i].book_id);
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: AppColorFactory.appPrimaryColor,
      appBar: AppBar(
        backgroundColor: AppColorFactory.appPrimaryColor,
        elevation: 0,
        title: Text(
          LocaleKeys.history.tr(),
          // style: TextStyle(fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: themeProvider.isDarkMode
                    ? [
                        Colors.grey.shade900,
                        Color.fromARGB(255, 170, 147, 147),
                        // Color(0xffFFFFFF),
                      ]
                    : [
                        Color(0xffD3B6B6),
                        Color(0xffFFFFFF),
                      ],
                // [
                //   Color(0xffD3B6B6),
                //   Color(0xffFFFFFF),
                // ],
              ),
              //themeProvider.isDarkMode ? Colors.white : Colors.grey,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40))),
          height: 88.5.h,
          child: Center(
            child: isLoading
                ? CircularProgressIndicator()
                : notes.length == 0
                    ? NodataAvailableClass('No history available !', 88.0.h)
                    : buildNotes(),
          ),
          // Padding(
          //   padding: EdgeInsets.only(top: 25.00.h),
          //   child: Container(
          //     // height: 13.0.h,
          //     // width: 100.0.w,
          //     child: Image(
          //       image: AssetImage(
          //         'assets/sriti_shoudho2.png',
          //       ),
          //       fit: BoxFit.fitWidth,
          //     ),
          //   ),
          // ),
        ),
      ),
    );
  }

  Widget buildNotes() => StaggeredGridView.countBuilder(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(8),
        itemCount: notes.length,
        staggeredTileBuilder: (index) => StaggeredTile.fit(2),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final note = notes[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => historyDetailsPage(
                  pagenumber: note.pagenumber,
                  book_details: note.book_details,
                  book_name: note.title,
                  book_id: note.book_id,
                ),
              ));
              refreshNotes();
            },
            child: NoteCardWidget(note: note, index: index),
          );
        },
      );
}
