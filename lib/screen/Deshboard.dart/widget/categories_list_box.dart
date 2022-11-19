import 'package:dhanshirisapp/provider/theme_provider.dart';
import 'package:dhanshirisapp/screen/book_categories_list/book_categorires_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class CategoriesListBox extends StatelessWidget {
  final String? name;
  CategoriesListBox({required this.name});
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BooksCategoriesList(
                      category: name,
                      sort_name: "book_name",
                      search: '',
                    )));
      },
      child: Container(
        height: 4.0.h,
        margin: EdgeInsets.only(
            top: 1.0.h, bottom: 1.0.h, left: 1.5.w, right: 2.0.w),
        padding: EdgeInsets.only(
          left: 3.0.w,
          right: 3.0.w,
        ),
        decoration: BoxDecoration(
            color: themeProvider.isDarkMode ? Colors.grey : Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                spreadRadius: 1,
                color: Colors.black12,
              )
            ]),
        child: Center(child: Text(name!)),
      ),
    );
  }
}
