import 'package:dhanshirisapp/provider/auth.dart';
import 'package:dhanshirisapp/provider/favourit_list.dart';
import 'package:dhanshirisapp/provider/singinmodel.dart';
import 'package:dhanshirisapp/screen/book_screen/book_cart.dart';
import 'package:dhanshirisapp/screen/wishlist/wish_book_cart.dart';
import 'package:dhanshirisapp/translations/locale_keys.g.dart';
import 'package:dhanshirisapp/widget/no_data_available.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../provider/theme_provider.dart';
import '../../res/colors.dart';

class FavouriteScreen extends StatefulWidget {
  static const routeName = '/favourite-screen';
  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void didChangeDependencies() async {
    //------initial call-------

    FavouriteProviderModel favouritmodel =
        Provider.of<FavouriteProviderModel>(context, listen: false);
    Map<String, dynamic> authentication =
        await favouritmodel.fatchfavouriteList();

    if (authentication['success']) {
      print('cuccess');
      print('ok');
    } else {
      showDialog(
          // barrierColor: Color(0xFFdab13c),
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Color(0xFFefe7dc),
              title: Text(
                '',
              ),
              content: Text(
                authentication['message'],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
    super.didChangeDependencies();
  }

  build(BuildContext context) {
    AuthProvider singinmodel =
        Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: AppColorFactory.appPrimaryColor,
      appBar: AppBar(
        backgroundColor: AppColorFactory.appPrimaryColor,
        elevation: 0,
        title: Text(
          LocaleKeys.mywishlist.tr(),
        ),
      ),
      //  AppBar(
      //   backgroundColor: Color(0xffb8242a),
      //   title: Align(
      //     alignment: Alignment.topLeft,
      //     child: Text(LocaleKeys.mywishlist.tr(),
      //         textAlign: TextAlign.left,
      //         style: TextStyle(fontWeight: FontWeight.bold)),
      //   ),
      // ),
      body: Container(
        child: OrientationBuilder(builder: (context, orientation) {
          if (MediaQuery.of(context).orientation == Orientation.portrait) {
            print('i am protrait');
            return buildProtraits();
          } else {
            print('i am landscape');
            return buildLandscapes();
          }
        }),
      ),
    );
  }

  Widget buildProtraits() {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return SingleChildScrollView(
        child: Column(
      children: [
        // ScreenBodyTopWidget(),
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: themeProvider.isDarkMode
                    ? [
                        Colors.grey.shade900,
                        Color.fromARGB(255, 170, 147, 147),
                        // Color(0xffFFFFFF),
                      ]
                    : [
                        Color(0xffD3B6B6),
                        Color(0xffFFFFFF),
                      ],
                // [
                //   Color(0xffD3B6B6),
                //   Color(0xffFFFFFF),
                // ],
              ),
              //themeProvider.isDarkMode ? Colors.white : Colors.grey,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40))),
          //  height: 100.5.h,
          child: Column(
            children: [
              SizedBox(
                height: 4.0.h,
              ),
              Container(
                alignment: Alignment.topLeft,
                height: 83.9.h,
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
                margin:
                    EdgeInsets.only(left: 01.0.w, bottom: 0.5.h, right: 01.0.w),
                child: Consumer<FavouriteProviderModel>(
                  child: Center(child: CircularProgressIndicator()),
                  builder: (context, modal, child) {
                    return modal.is_loading
                        ? child as Widget
                        : modal.favouritelist.length != 0
                            ? GridView.builder(
                                scrollDirection: Axis.vertical,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 02.0.w,
                                  crossAxisSpacing: 02.0.w,
                                  childAspectRatio: .75,
                                ),
                                itemCount: modal.favouritelist.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var data = modal.favouritelist[index];
                                  return WishBookCart(bookdetails: data);
                                })
                            : NodataAvailableClass(
                                'Wishlist not created yet', 55.0.h);
                  },
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.only(top: 00.00.h),
              //   child: Container(
              //     height: 13.0.h,
              //     width: 100.0.w,
              //     child: Image(
              //       image: AssetImage(
              //         'assets/sriti_shoudho2.png',
              //       ),
              //       fit: BoxFit.fitWidth,
              //     ),
              //   ),
              // ),
            ],
          ),
        )
      ],
    ));
  }

  Widget buildLandscapes() {
    return SingleChildScrollView(
        child: Column(
      children: [
        SizedBox(height: 2.0.h),
        Container(
            alignment: Alignment.topLeft,
            height: 50.0.h,
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
            margin: EdgeInsets.only(left: 01.0.w, bottom: 0.5.h, right: 01.0.w),
            child: Consumer<FavouriteProviderModel>(
              child: Center(child: CircularProgressIndicator()),
              builder: (context, modal, child) {
                return modal.is_loading
                    ? child as Widget
                    : modal.favouritelist.length != 0
                        ? GridView.builder(
                            scrollDirection: Axis.horizontal,
                            //physics: ,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 04.0.w,
                              crossAxisSpacing: 04.0.w,
                              childAspectRatio: .95,
                            ),
                            itemCount: modal.favouritelist.length,
                            itemBuilder: (BuildContext context, int index) {
                              var data = modal.favouritelist[index];
                              return WishBookCart(bookdetails: data);
                            })
                        : NodataAvailableClass(
                            'Wishlist not created yet', 80.0.h);
              },
            )),
      ],
    ));
  }
}
