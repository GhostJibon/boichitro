import 'package:dhanshirisapp/db/history_data.dart';
import 'package:dhanshirisapp/db/history_database.dart';
import 'package:dhanshirisapp/provider/book_read.dart';
import 'package:dhanshirisapp/provider/order.dart';
import 'package:dhanshirisapp/widget/debouncer.dart';
import 'package:dhanshirisapp/widget/page_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainPage extends StatefulWidget {
  BookReadtModel bookpagemodel;
  String? book_details;
  int? book_id;
  String? book_name;
  Orther orther;
  MainPage(
      {required this.bookpagemodel,
      required this.book_name,
      required this.orther,
      required this.book_details,
      this.book_id});
  @override
  _BookReadScreenState createState() => _BookReadScreenState();
}

class _BookReadScreenState extends State<MainPage> with WidgetsBindingObserver {
  late final PageManager _pageManager;
  late List<Note> notes;
  Note? notedata;
  @override
  void initState() {
    print(widget.book_details);
    super.initState();
  }

  Future addNote() async {
    final note = Note(
      book_id: widget.book_id,
      title: widget.book_name!,
      pagenumber: pagenumber,
      book_details: widget.book_details!,
      createdTime: DateTime.now(),
    );
    await NotesDatabase.instance.create(note);
  }

  void addOrUpdateNote() async {
    // final isValid = _formKey.currentState!.validate();
    notes = await NotesDatabase.instance.readAllNotes();
    print('-----notes-----');
    for (int i = 0; i < notes.length; i++) {
      if (notes[i].book_id == widget.book_id!) {
        notedata = notes[i];
      } else {
        notedata = null;
      }
      print(notes[i].book_id);
    }

    final isUpdating = notedata != null;
    if (isUpdating) {
      await updateNote();
    } else {
      await addNote();
      // await updateNote();
    }
    print('i am working both');
    //  Navigator.of(context).pop();
  }

  Future updateNote() async {
    final note = notedata!.copy(
      book_id: widget.book_id,
      pagenumber: pagenumber,
      title: widget.book_name,
      createdTime: DateTime.now(),
      book_details: widget.book_details!,
    );

    await NotesDatabase.instance.update(note);
  }

//select modeicon veriable
  bool mode = false;
  bool ischeck_white = false;
  bool ischeck_read = false;
  bool ischeck_black = false;
  bool audiomode = false;
  // ---- Fontfamily ----------
  bool _fontmode = false;
  List _font = [
    'Bensenhandwriti',
    'Muktinarrow',
    'Adorsholipi',
    'ShohidJobbar',
  ];
  String _fontfamilys = "Adorsholipi";
  double _currentSliderValue = 14.5;
//----- page count ------
  bool pagecheck = false;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  PageController _pageController = PageController();
  double _scaleFactor = 1.0;
  double _baseScaleFactor = 1.0;

  int pagenumber = 1;
  final Debouncer onSearchDebouncer = new Debouncer(
    delay: new Duration(milliseconds: 500),
  );
  PageController _controller =
      PageController(viewportFraction: 1, keepPage: true);
  bool ischeck = false;
  // @override
  // void dispose() {
  //   SystemChrome.setPreferredOrientations([
  //     DeviceOrientation.portraitUp,
  //   ]);
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          padding: EdgeInsets.all(32),
          child: OrientationBuilder(
            builder: (context, orientation) =>
                orientation == Orientation.portrait
                    ? buildPortrait()
                    : buildLandscape(),
          ),
        ),
      );

  Widget buildPortrait() => ListView(
        children: [
          buildImage(),
          const SizedBox(height: 16),
          buildText(),
        ],
      );
  Widget buildLandscape() => Row(
        children: [
          buildImage(),
          const SizedBox(width: 16),
          Expanded(child: SingleChildScrollView(child: buildText())),
        ],
      );

  Widget buildImage() => Image.network(
      'https://images.unsplash.com/photo-1585129819171-80b02d4c85b0?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80');

  Widget buildText() => Column(
        children: [
          Text(
            'Hair Styling',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '''The oldest known depiction of hair styling is hair braiding which dates back about 30,000 years. In history, women's hair was often elaborately and carefully dressed in special ways. From the time of the Roman Empire[citation needed] until the Middle Ages, most women grew their hair as long as it would naturally grow. Between the late 15th century and the 16th century, a very high hairline on the forehead was considered attractive. Around the same time period, European men often wore their hair cropped no longer than shoulder-length. In the early 17th century, male hairstyles grew longer, with waves or curls being considered desirable.''',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ],
      );
}
