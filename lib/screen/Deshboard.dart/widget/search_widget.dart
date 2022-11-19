import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:dhanshirisapp/provider/theme_provider.dart';

import '../../../translations/locale_keys.g.dart';
import '../../book_categories_list/book_categorires_list.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget(
      {Key? key, required this.isPortrait, required this.scaffoldKey})
      : super(key: key);
  final bool isPortrait;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  //final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String? search;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Positioned(
      left: 5.0.w,
      right: 5.0.w,
      top: 10.0.h,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            color:
                themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 3,
                  spreadRadius: 4,
                  offset: Offset.zero)
            ]),
        height: 6.0.h,
        child: Form(
          key: _formKey,
          child: Row(
            children: [
              Container(
                width: 10.0.w,
                child: IconButton(
                  icon: Icon(Icons.table_rows_sharp),
                  onPressed: () {
                    widget.scaffoldKey.currentState?.openDrawer();
                  },
                ),
              ),
              SizedBox(
                width: 10.0.w,
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: widget.isPortrait ? 50.0.w : 150.0.w,
                child: TextField(
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: LocaleKeys.search.tr(),
                  ),
                  onChanged: (value) {
                    search = value;
                  },
                ),
              ),
              Container(
                child: Center(
                  child: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BooksCategoriesList(
                                    category: 'Recent',
                                    search: search,
                                    sort_name: "name_sort",
                                  )));
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
