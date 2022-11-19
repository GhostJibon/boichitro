import 'package:dhanshirisapp/model/subcription_type.dart';
import 'package:dhanshirisapp/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

class SubcriptionCart extends StatelessWidget {
  final Color? color;
  SubcriptionType? data;
  int? checkindex;
  Function()? ontap;
  int? index;
  SubcriptionCart(
      {required this.color,
      required this.checkindex,
      required this.data,
      required this.index,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    double? permonths =
        ((data!.cost!) / (data!.limit_in_month!)).roundToDouble();
    int permonth = (permonths * 1).round();
    int month = ((data!.limit_in_month!) * 1).round();
    int totalcost = ((data!.cost!) * 1).round();
    print(totalcost);
    // TODO: implement build
    return GestureDetector(
      onTap: ontap,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 1.50.h, right: 1.5.w),
            height: 15.00.h,
            width: 29.0.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    width: 3,
                    color:
                        index == checkindex ? Color(0xffc60e13) : Colors.grey)),
            child: Column(
              children: [
                SizedBox(
                  height: 1.50.h,
                ),
                Container(
                  height: 4.0.h,
                  child: Center(
                    child: Text(
                      month.toString(),
                      style: TextStyle(
                          fontSize: 2.6.h,
                          fontWeight: FontWeight.bold,
                          color: index == checkindex
                              ? Color(0xffc60e13)
                              : Colors.grey),
                    ),
                  ),
                ),
                Container(
                  height: 2.50.h,
                  child: Center(
                    child: Text(
                      LocaleKeys.month.tr(),
                      style: TextStyle(
                          fontSize: 1.50.h,
                          fontWeight: FontWeight.bold,
                          color: index == checkindex
                              ? Color(0xffc60e13)
                              : Colors.grey),
                    ),
                  ),
                ),
                Container(
                  height: 2.5.h,
                  child: Center(
                    child: Text(
                      '${LocaleKeys.bdt.tr()} ${permonth.toString()}/mo ',
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 1.50.h,
                        fontWeight: FontWeight.bold,
                        color: index == checkindex
                            ? Color(0xffc60e13)
                            : Colors.grey,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(),
                  decoration: BoxDecoration(
                      color: index == checkindex
                          ? Color(0xffc60e13)
                          : Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(6),
                          bottomRight: Radius.circular(6))),
                  height: 3.750.h,
                  child: Center(
                    child: Text(
                      '${LocaleKeys.bdt.tr()} ${totalcost.toString()}',
                      style: TextStyle(
                          fontSize: 1.80.h,
                          fontWeight: FontWeight.bold,
                          color:
                              index == checkindex ? Colors.white : Colors.grey),
                    ),
                  ),
                )
              ],
            ),
          ),
          index == checkindex
              ? Positioned(
                  left: 4.5.w,
                  right: 4.5.w,
                  top: 0.0.h,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xffb8242a),
                        borderRadius: BorderRadius.circular(5)),
                    //width: 18.0.w,
                    height: 3.0.h,
                    child: Center(
                      child: Text(
                        data!.sub_title.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 1.7.h),
                      ),
                    ),
                  ))
              : Positioned(child: Container()),
        ],
      ),
    );
  }
}
