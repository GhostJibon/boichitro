import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../provider/categories_product_list.dart';
import '../../../widget/no_data_available.dart';
import '../../book_screen/book_cart.dart';

class GrideView extends StatefulWidget {
  const GrideView({
    Key? key,
    required ScrollController scrollController,
    required this.isProtraits,
  })  : _scrollController = scrollController,
        super(key: key);

  final ScrollController _scrollController;
  final bool isProtraits;

  @override
  State<GrideView> createState() => _GrideViewState();
}

class _GrideViewState extends State<GrideView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.isProtraits ? 70.0.h : 55.0.h,
      width: widget.isProtraits ? 100.0.w : double.infinity,
      margin: EdgeInsets.only(left: 02.0.h, right: 02.0.h),
      decoration: new BoxDecoration(
        image: new DecorationImage(
          fit: BoxFit.cover,
          colorFilter: new ColorFilter.mode(
              Colors.white.withOpacity(.9), BlendMode.dstOut),
          image: new AssetImage(
            'assets/backgroudImagedeshboard.png',
          ),
        ),
      ),
      child: Consumer<CategoriesProductListModel>(
        child: Center(child: CircularProgressIndicator()),
        builder: (context, model, child) {
          return model.isloading
              ? child as Widget
              : model.Product!.length == 0
                  ? NodataAvailableClass('No Book Available', 60.0.h)
                  : GridView.builder(
                      controller: widget._scrollController,
                      scrollDirection: Axis.vertical,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 01.0.w,
                        crossAxisSpacing: 01.0.w,
                        childAspectRatio: widget.isProtraits ? .75 : .95,
                      ),
                      itemCount: model.Product?.length,
                      itemBuilder: (BuildContext context, int index) {
                        final bookdetails = model.Product![index];
                        return BookCart(
                          bookdetails: bookdetails,
                        );
                      });
        },
      ),
    );
  }
}
