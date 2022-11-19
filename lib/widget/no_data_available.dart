import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NodataAvailableClass extends StatelessWidget {
  final title;
  final height;
  NodataAvailableClass(
    this.title,
    this.height,
  );
  build(BuildContext context) {
    return Container(
      height: height,
      width: 100.0.w,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                child: Text(title,
                    style: TextStyle(fontSize: 1.8.h, color: Colors.black45))),
            // Container(
            //   height: 10.0.h,
            //   width: 20.0.w,
            //   // child: Image(
            //   //   image: AssetImage('assets/history.png'),
            //   // )
            //   decoration: BoxDecoration(
            //       image: DecorationImage(
            //           image: AssetImage('assets/nodataavilable.png'))),
            // ),
          ],
        ),
      ),
    );
  }
}
