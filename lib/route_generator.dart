import 'package:dhanshirisapp/screen/audio/audio_book_details.dart';
import 'package:dhanshirisapp/screen/auth/login_screen.dart';
import 'package:dhanshirisapp/screen/setting/setting.dart';

import '/screen/History/history_page.dart';
import '/screen/book_request/book_requested_screen.dart';
import '/screen/user/user_profile.dart';
import '/screen/wishlist/my_wishlist.dart';
import '/screen/about%20page/aboutpage.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case AboutPage.routeName:
        return MaterialPageRoute(builder: (context) => AboutPage());
      case HistoryPage.routeName:
        return MaterialPageRoute(builder: (context) => HistoryPage());
      case FavouriteScreen.routeName:
        return MaterialPageRoute(builder: (context) => FavouriteScreen());
      case ProfileInfo.routeName:
        return MaterialPageRoute(builder: (context) => ProfileInfo());
      case BookRequestingScreen.routeName:
        return MaterialPageRoute(builder: (context) => BookRequestingScreen());
      case Setting.routeName:
        return MaterialPageRoute(builder: (context) => Setting());
      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (context) => LoginScreen());

      // case AudioBookDetails.routeName:
      //   {
      //     //final args = settings.arguments as ScreenArguments;
      //     return MaterialPageRoute(
      //         builder: ((context) => AudioBookDetails(
      //               bytesImage: args.,
      //               recentlist: args,
      //             )));
      //   }

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text("ERROR"),
            centerTitle: true,
          ),
          body: Center(
            child: Text("Page not found!"),
          ),
        );
      },
    );
  }
}
