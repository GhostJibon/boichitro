import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../provider/deshboard.dart';
import '../../../translations/locale_keys.g.dart';
import '../../../widget/no_data_available.dart';
import '../../../widget/shimmer.dart';
import 'categories_list_box.dart';

class BookCategories extends StatefulWidget {
  const BookCategories({Key? key, required this.isPortrait}) : super(key: key);
  final bool isPortrait;

  @override
  State<BookCategories> createState() => _BookCategoriesState();
}

class _BookCategoriesState extends State<BookCategories> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Categories
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 05.0.w, top: 1.0.h),
          height: 5.0.h,
          child: Text(
            // "Categories",
            LocaleKeys.categories.tr(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 2.0.h,
              //   color: Colors.black
            ),
          ),
        ),
        // if (widget.isPortrait)
        Container(
          height: 6.0.h,
          width: widget.isPortrait ? 90.0.w : double.infinity,
          margin: EdgeInsets.only(left: 05.0.w, right: 05.0.w),
          child: Consumer<CategoryProvider>(
            child: Center(child: CategoryShimmer()),
            builder: (context, modal, child) {
              return modal.isLoadingCategory
                  ? child as Widget
                  : modal.categoryList.length == 0
                      ? NodataAvailableClass('No Categories Available', 22.0.h)
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: modal.categoryList.length,
                          itemBuilder: (context, index) {
                            // final data = modal.Categorylist![index];
                            return modal.categoryList.length != 0
                                ? CategoriesListBox(
                                    name: modal.categoryList[index].name)

                                // SelectionCatagorisBox(
                                //     name: modal
                                //         .categoryList[index].name)
                                : Text('No order in queue');
                          });
            },
          ),
        )
        // else
        //   Container(
        //     height: 6.0.h,
        //     // width: 90.0.w,
        //     margin: EdgeInsets.only(left: 05.0.w, right: 05.0.w),
        //     child: Consumer<CategoryProvider>(
        //       child: Center(child: CategoryShimmer()),
        //       builder: (context, modal, child) {
        //         return modal.isLoadingCategory
        //             ? child as Widget
        //             : modal.categoryList.length == 0
        //                 ? NodataAvailableClass(
        //                     'No Categories Available', 22.0.h)
        //                 : ListView.builder(
        //                     scrollDirection: Axis.horizontal,
        //                     itemCount: modal.categoryList.length,
        //                     itemBuilder: (context, index) {
        //                       // final data = modal.Categorylist![index];
        //                       return modal.categoryList.length != 0
        //                           ? CategoriesListBox(
        //                               name: modal.categoryList[index].name)

        //                           // SelectionCatagorisBox(
        //                           //     name: modal
        //                           //         .categoryList[index].name)
        //                           : Text('No order in queue');
        //                     });
        //       },
        //     ),
        //   ),
        //////
      ],
    );
  }
}
