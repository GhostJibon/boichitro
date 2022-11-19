import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../provider/deshboard.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../../../widget/no_data_available.dart';
import '../../../../widget/shimmer.dart';
import '../../../book_categories_list/book_categorires_list.dart';
import '../../../book_screen/book_cart.dart';
import '../titlename_withbutton.dart';

class PopularBookWidget extends StatefulWidget {
  const PopularBookWidget({Key? key}) : super(key: key);

  @override
  State<PopularBookWidget> createState() => _PopularBookWidgetState();
}

class _PopularBookWidgetState extends State<PopularBookWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleNameWithButton(
          title: LocaleKeys.mostpopular.tr(),
          ontap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BooksCategoriesList(
                          category: 'Populor',
                          search: '',
                          sort_name: "বইয়ের নাম",
                        )));
          },
        ),

        //Listview Builder
        Container(
          alignment: Alignment.topLeft,
          height: 27.0.h,
          margin: EdgeInsets.only(left: 01.0.w, bottom: 0.5.h),
          child: Consumer<CategoryProvider>(
            child: BookCartShimmer(),
            builder: (context, modal, child) {
              return modal.isLoadingpopular
                  ? child as Widget
                  : modal.popularBooks!.length == 0
                      ? NodataAvailableClass('No Book Available', 25.0.h)
                      : ListView.builder(
                          shrinkWrap: false,
                          scrollDirection: Axis.horizontal,
                          itemCount: modal.popularBooks!.length,
                          itemBuilder: (context, index) {
                            final bookdetails = modal.popularBooks![index];
                            return BookCart(
                              bookdetails: bookdetails,
                            );
                          });
            },
          ),
        ),
      ],
    );
  }
}
