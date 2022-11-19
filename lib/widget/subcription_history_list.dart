import 'package:dhanshirisapp/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SubcriptionHistoryList extends StatelessWidget {
  var data;
  SubcriptionHistoryList({required this.data});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(left: 05.0.w, right: 05.0.w, bottom: 1.0.h),
      decoration: BoxDecoration(
          color: AppColorFactory.appPrimaryColor,
          borderRadius: BorderRadius.circular(10)),
      height: 8.0.h,
      child: Column(
        children: [
          Expanded(
              child: Row(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    '${data.limit_in_month} Months for ${data.total_cost.toString()} BDT',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 2.0.h,
                    ),
                  ),
                ),
              ),
            ],
          )),
          Expanded(
              child: Row(
            children: [
              Expanded(
                  child: Center(
                child: Text(
                  'Started:  ${data!.start_date!.replaceRange(10, data!.start_date!.length, '')}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 1.5.h,
                  ),
                ),
              )),
              Expanded(
                child: Center(
                  child: Text(
                    'Expired: ${data!.end_date!.replaceRange(10, data!.end_date!.length, '')}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 1.5.h,
                    ),
                  ),
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}
