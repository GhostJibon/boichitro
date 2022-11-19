import 'dart:async';
import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dhanshirisapp/constants/app_constants.dart';
import 'package:dhanshirisapp/provider/deshboard.dart';
import 'package:dhanshirisapp/provider/categories_product_list.dart';
import 'package:dhanshirisapp/screen/book_screen/book_cart.dart';
import 'package:dhanshirisapp/services/secure_storage_service.dart';
import 'package:dhanshirisapp/translations/locale_keys.g.dart';
import 'package:dhanshirisapp/widget/drower_customer/add_drower_customer.dart';
import 'package:dhanshirisapp/widget/no_data_available.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'widget/gridview_widget.dart';

class BooksCategoriesList extends StatefulWidget {
  final String? category;
  final String? sort_name;
  final String? search;
  BooksCategoriesList({
    required this.category,
    required this.search,
    required this.sort_name,
  });
  @override
  _BooksListState createState() => _BooksListState();
}

List<String> _list = [];
List<String> _sortlist = ['বইয়ের নাম', 'রেটিং'];

class _BooksListState extends State<BooksCategoriesList> {
  List<ProductList>? _ProductList = [];

  List<ProductList>? get Product {
    return _ProductList;
  }

  bool isStrechedDropDown = false;
  int? groupValue;
  String title = 'Select ';
  String? next;
  int offset = 0;
  String? category;
  String? search = '';
  String? sort_order = 'বইয়ের নাম';
  Future<List<ProductList>?> _refreshapicalls(BuildContext context) async {
    // print('i am data');
    var token = await SecureStorageService().readValue(key: AUTH_TOKEN_KEY);
    CategoriesProductListModel categoriesProductListModel =
        Provider.of<CategoriesProductListModel>(context, listen: false);
    await categoriesProductListModel.clearproductlist();
    await categoriesProductListModel.deshboardcontians(
        token.toString(), offset, category, sort_order, search);
  }

  ScrollController _scrollController = ScrollController();
  int length = 0;
  String? dropdownValue;
  @override
  void initState() {
    category = widget.category;
    search = widget.search;
    dropdownValue = widget.category;
    super.initState();
    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    //   apicall(context);
    // });
    // _scrollController.addListener(() {
    //   if (_scrollController.position.pixels >=
    //       _scrollController.position.maxScrollExtent) {
    //     offset = offset + 1;
    //     apicall(context);
    //   }
    // });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Future apicall(BuildContext context) async {
    await _refreshapicalls(context);
  }

  void didChangeDependencies() async {
    //------initial call-------

    _refreshapicalls(context);
    super.didChangeDependencies();
  }

  bool isProtraits = false;
  @override
  Widget build(BuildContext context) {
    CategoriesProductListModel model =
        Provider.of<CategoriesProductListModel>(context, listen: false);
    CategoryProvider categories_name =
        Provider.of<CategoryProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffb8242a),
        elevation: 0,
      ),
      drawer: AppDrawerCustomer(),
      body: Container(
        child: OrientationBuilder(builder: (context, orientation) {
          if (MediaQuery.of(context).orientation == Orientation.portrait) {
            print('i am protrait');
            isProtraits = true;
            return buildProtraits(model, categories_name);
          } else {
            print('i am landscape');
            return buildLandscapes(model, categories_name);
          }
        }),
      ),
    );
  }

  Widget buildProtraits(model, categories_name) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Color(0xffb8242a),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black45,
                      blurRadius: 1,
                      spreadRadius: 2,
                      offset: Offset.zero)
                ],
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            height: 7.0.h,
            width: 100.0.w,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 5.0.h,
                  margin: EdgeInsets.only(
                    left: 10.0.w,
                    right: 10.0.w,
                  ),
                  width: 100.0.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: TextFormField(
                      maxLines: 1,
                      onChanged: (value) async {
                        offset = 0;
                        search = value;
                      },
                      initialValue: widget.search,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () async {
                              setState(() {
                                model.clearproductlist();
                                apicall(context);
                              });
                            },
                            icon: Icon(Icons.search),
                            color: Color(0xffb8242a),
                          ),
                          border: InputBorder.none,
                          hintText: LocaleKeys.search.tr(),
                          contentPadding: EdgeInsets.only(
                            top: 1.0.h,
                            bottom: 1.0.h,
                            left: 3.0.w,
                            right: 3.0.w,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
          //-------------- category box ---------
          Container(
            height: 4.5.h,
            width: 100.0.w,
            margin: EdgeInsets.only(left: 8.0.w, right: 8.0.w, top: 4.0.h),
            child: Row(
              children: [
                Container(
                  height: 5.0.h,
                  width: 38.0.w,
                  padding: EdgeInsets.only(left: 2.0.h, right: 2.0.h),
                  decoration: BoxDecoration(
                      color: Color(0xffb8242a),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset.zero,
                            blurRadius: 1,
                            spreadRadius: 1)
                      ]),
                  child: DropdownButton<String>(
                    itemHeight: 6.0.h,
                    isExpanded: true,
                    // hint: AutoSizeText(
                    //   'Categories',
                    //   maxLines: 1,
                    //   overflow: TextOverflow.ellipsis,
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //   ),
                    // ),
                    dropdownColor: Color(0xffb8242a),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_drop_down_sharp,
                        color: Colors.white),
                    iconSize: 20,
                    elevation: 0,
                    underline: Container(
                      height: 0,
                      color: Color(0xFFdab13c),
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        dropdownValue = newValue;
                        category = dropdownValue;
                        offset = 0;
                        //model.clearproductlist();
                        apicall(context);
                      });
                    },
                    items: categories_name.categoryName!
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: AutoSizeText(
                          value,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                SizedBox(
                  width: 8.0.w,
                ),
                // -------------Shortby List -----------------
                Container(
                  height: 5.0.h,
                  width: 38.0.w,
                  padding: EdgeInsets.only(left: 2.0.h, right: 2.0.h),
                  decoration: BoxDecoration(
                      color: Color(0xffb8242a),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset.zero,
                            blurRadius: 1,
                            spreadRadius: 1)
                      ]),
                  child: DropdownButton<String>(
                    itemHeight: 6.0.h,
                    isExpanded: true,
                    // hint: AutoSizeText(
                    //   'Sort',
                    //   maxLines: 1,
                    //   overflow: TextOverflow.ellipsis,
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //   ),
                    // ),
                    dropdownColor: Color(0xffb8242a),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    value: sort_order,
                    icon: const Icon(Icons.arrow_drop_down_sharp,
                        color: Colors.white),
                    iconSize: 20,
                    elevation: 0,
                    underline: Container(
                      height: 0,
                      color: Color(0xFFdab13c),
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        sort_order = newValue;
                        offset = 0;
                        model.clearproductlist();
                        apicall(context);
                      });
                    },
                    items:
                        _sortlist.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: AutoSizeText(
                          value,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                ////////
              ],
            ),
          ),

          SizedBox(height: 2.9.h),
          //-------------pagignation api data fatche ----
          GrideView(
            scrollController: _scrollController,
            isProtraits: isProtraits,
          )
          /////////
        ],
      ),
    );
  }
  //---------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------------

  Widget buildLandscapes(model, categories_name) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Color(0xffb8242a),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black45,
                      blurRadius: 1,
                      spreadRadius: 2,
                      offset: Offset.zero)
                ],
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            height: 7.0.h,
            width: 100.0.w,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 5.0.h,
                  margin: EdgeInsets.only(
                    left: 10.0.w,
                    right: 10.0.w,
                  ),
                  width: 100.0.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: TextFormField(
                      maxLines: 1,
                      onChanged: (value) async {
                        offset = 0;
                        search = value;
                      },
                      initialValue: widget.search,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () async {
                              setState(() {
                                model.clearproductlist();
                                apicall(context);
                              });
                            },
                            icon: Icon(Icons.search),
                            color: Color(0xffb8242a),
                          ),
                          border: InputBorder.none,
                          hintText: LocaleKeys.search.tr(),
                          contentPadding: EdgeInsets.only(
                            top: 1.0.h,
                            bottom: 1.0.h,
                            left: 3.0.w,
                            right: 3.0.w,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
          //-------------- category box ---------
          // Container(
          //   height: 20.5.h,
          //   //  width: 100.0.w,
          //   margin: EdgeInsets.only(left: 8.0.w, right: 8.0.w, top: 4.0.h),
          //   child: Row(
          //     children: [
          //       Container(
          //         height: 5.0.h,
          //         width: 50.0.w,
          //         padding: EdgeInsets.only(left: 2.0.h, right: 2.0.h),
          //         decoration: BoxDecoration(
          //             color: Color(0xffb8242a),
          //             borderRadius: BorderRadius.all(Radius.circular(5)),
          //             boxShadow: [
          //               BoxShadow(
          //                   color: Colors.black12,
          //                   offset: Offset.zero,
          //                   blurRadius: 1,
          //                   spreadRadius: 1)
          //             ]),
          //         child: DropdownButton<String>(
          //           itemHeight: 20,
          //           isExpanded: true,

          //           // hint: AutoSizeText(
          //           //   'Categories',
          //           //   maxLines: 1,
          //           //   overflow: TextOverflow.ellipsis,
          //           //   style: TextStyle(
          //           //     color: Colors.white,
          //           //   ),
          //           // ),
          //           dropdownColor: Color(0xffb8242a),
          //           style: TextStyle(
          //               color: Colors.white, fontWeight: FontWeight.bold),
          //           value: dropdownValue,
          //           icon: const Icon(Icons.arrow_drop_down_sharp,
          //               color: Colors.white),
          //           iconSize: 20,
          //           elevation: 0,
          //           underline: Container(
          //             height: 0,
          //             color: Color(0xFFdab13c),
          //           ),
          //           onChanged: (newValue) {
          //             setState(() {
          //               dropdownValue = newValue;
          //               category = dropdownValue;
          //               offset = 0;
          //               //model.clearproductlist();
          //               apicall(context);
          //             });
          //           },
          //           items: categories_name.categoryName!
          //               .map<DropdownMenuItem<String>>((String value) {
          //             return DropdownMenuItem<String>(
          //               value: value,
          //               child: AutoSizeText(
          //                 value,
          //                 overflow: TextOverflow.ellipsis,
          //                 style: TextStyle(
          //                   color: Colors.white,
          //                 ),
          //               ),
          //             );
          //           }).toList(),
          //         ),
          //       ),

          //       SizedBox(
          //         width: 8.0.w,
          //       ),
          // -------------Shortby List -----------------
          // Container(
          //   height: 5.0.h,
          //   width: 50.0.w,
          //   padding: EdgeInsets.only(left: 2.0.h, right: 2.0.h),
          //   decoration: BoxDecoration(
          //       color: Color(0xffb8242a),
          //       borderRadius: BorderRadius.all(Radius.circular(5)),
          //       boxShadow: [
          //         BoxShadow(
          //             color: Colors.black12,
          //             offset: Offset.zero,
          //             blurRadius: 1,
          //             spreadRadius: 1)
          //       ]),
          //   child: DropdownButton<String>(
          //     itemHeight: 6.0.h,
          //     isExpanded: true,
          //     // hint: AutoSizeText(
          //     //   'Sort',
          //     //   maxLines: 1,
          //     //   overflow: TextOverflow.ellipsis,
          //     //   style: TextStyle(
          //     //     color: Colors.white,
          //     //   ),
          //     // ),
          //     dropdownColor: Color(0xffb8242a),
          //     style: TextStyle(
          //         color: Colors.white, fontWeight: FontWeight.bold),
          //     value: sort_order,
          //     icon: const Icon(Icons.arrow_drop_down_sharp,
          //         color: Colors.white),
          //     iconSize: 20,
          //     elevation: 0,
          //     underline: Container(
          //       height: 0,
          //       color: Color(0xFFdab13c),
          //     ),
          //     onChanged: (newValue) {
          //       setState(() {
          //         sort_order = newValue;
          //         offset = 0;
          //         model.clearproductlist();
          //         apicall(context);
          //       });
          //     },
          //     items:
          //         _sortlist.map<DropdownMenuItem<String>>((String value) {
          //       return DropdownMenuItem<String>(
          //         value: value,
          //         child: AutoSizeText(
          //           value,
          //           overflow: TextOverflow.ellipsis,
          //           style: TextStyle(
          //             color: Colors.white,
          //           ),
          //         ),
          //       );
          //     }).toList(),
          //   ),
          // ),
          //     ],
          //   ),
          // ),

          SizedBox(height: 2.9.h),
          //-------------pagignation api data fatche ----
          GrideView(
              scrollController: _scrollController, isProtraits: isProtraits)
          //////////
        ],
      ),
    );
  }
}
