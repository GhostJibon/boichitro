import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart'; // may be for the w and h

class TopBar extends StatelessWidget{
  var context;
  var titleText;
  var fontSize;
  var fontWeight;

  // constructor
  TopBar({
    this.context,
    this.titleText,
    this.fontSize,
    this.fontWeight
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      width: 55.0.w,
      child: Text(
        titleText == null ? 'বইচিত্র' : titleText , // TODO: has to make this a reusable widget
        style: TextStyle(
            fontWeight: fontWeight == null ? FontWeight.bold : fontWeight,
            fontSize: fontSize == null ? 2.5 : fontSize),
      ),
    );
  }

}