import 'package:dhanshirisapp/screen/book_categories_list/book_categorires_list.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SelectionCatagorisBox extends StatelessWidget {
  final String? name;
  SelectionCatagorisBox({required this.name});

  @override
  Widget build(BuildContext context) {
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
        width: 22.5.w,
        height: 12.0.h,
        child: Column(
          children: [
            Container(
                //   margin: EdgeInsets.all(.70.h),
                height: 8.0.h,
                width: 19.0.w,
                decoration: BoxDecoration(),
                child: CircleAvatar(
                  radius: 1.6.h,
                  backgroundImage: AssetImage('assets/download.jpeg'),
                  // child: Image.asset(
                  //   'assets/flowerthree.png',
                  //   fit: BoxFit.fill,
                  // ),
                )),
            SizedBox(height: .7.h),
            Container(
                height: 3.3.h,
                width: 19.0.w,
                child: Center(
                    child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(name.toString(),
                      style: TextStyle(
                          fontSize: 1.70.h,
                          //color: Colors.black,
                          fontWeight: FontWeight.bold),
                      //  style: TextStle(fontSize: fontSize),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis),
                ))),
            SizedBox(width: 3.5.w),
          ],
        ),
      ),
    );
  }
}
