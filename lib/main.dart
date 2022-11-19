import 'dart:async';

import 'package:device_preview/device_preview.dart';
import 'package:dhanshirisapp/components/review_design.dart';
import 'package:dhanshirisapp/provider/auth.dart';
import 'package:dhanshirisapp/provider/book_read.dart';
import 'package:dhanshirisapp/provider/deshboard.dart';
import 'package:dhanshirisapp/provider/categories_product_list.dart';
import 'package:dhanshirisapp/provider/favourit_list.dart';
import 'package:dhanshirisapp/provider/highlight.dart';
import 'package:dhanshirisapp/provider/history.dart';
import 'package:dhanshirisapp/provider/order.dart';
import 'package:dhanshirisapp/provider/profiledata.dart';
import 'package:dhanshirisapp/provider/review.dart';
import 'package:dhanshirisapp/provider/singinmodel.dart';
import 'package:dhanshirisapp/provider/subcription.dart';
import 'package:dhanshirisapp/provider/theme_provider.dart';
import 'package:dhanshirisapp/route_generator.dart';
import 'package:dhanshirisapp/screen/Deshboard.dart/text_lighlighit.dart';
import 'package:dhanshirisapp/screen/about%20page/aboutpage.dart';
import 'package:dhanshirisapp/screen/book_read_page_details.dart';
import 'package:dhanshirisapp/screen/book_request/book_requested_screen.dart';
import 'package:dhanshirisapp/screen/book_screen/about_book.dart';
import 'package:dhanshirisapp/screen/first_loadingscreen.dart';
import 'package:dhanshirisapp/screen/about_app.dart';
import 'package:dhanshirisapp/screen/music_player/music_player.dart';
import 'package:dhanshirisapp/screen/text_audio_file.dart';
import 'package:dhanshirisapp/services/push_notification.dart';
import 'package:dhanshirisapp/widget/textfield_demo.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
//import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// StreamController<bool> isLightTheme = StreamController();

Future<void> backgroundHandler(RemoteMessage message) async {
  NotificationService.display(message);
  print(message.data.toString());
  print(message.notification!.title);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  NotificationService.initialize();
  FirebaseMessaging.instance.getInitialMessage();
  // FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  // FirebaseCrashlytics.instance.crash();
  //HttpOverrides.global = new MyHttpOverrides();
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => EasyLocalization(
        path: 'assets/translations',
        supportedLocales: [
          Locale('en'),
          Locale('bn'),
        ],
        fallbackLocale: Locale('en'),
        child: Boichitro(),
      ), // Wrap your app
    ),
  );
}

// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }

class Boichitro extends StatefulWidget {
  @override
  State<Boichitro> createState() => _BoichitroState();
}

class _BoichitroState extends State<Boichitro> {
  @override
  void initState() {
    print('i am initState');
    super.initState();

    FirebaseMessaging.onMessage.listen((message) {
      print('i am message');
      if (message.notification != null) {
        print(message.notification!.body);
        print(message.notification!.title);
      } else {
        print(message);
      }
      NotificationService.display(message);
      // FlutterRingtonePlayer.play(
      //   android: AndroidSounds.ringtone,
      //   ios: IosSounds.glass,
      //   // looping: true, // Android only - API >= 28
      //   volume: 1, // Android only - API >= 28
      //   asAlarm: false, // Android only - all APIs
      // );
    });
// on app breckgroud
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      NotificationService.display(message);
      // FlutterRingtonePlayer.play(
      //   android: AndroidSounds.ringtone,
      //   ios: IosSounds.glass,
      //   // looping: true, // Android only - API >= 28
      //   volume: 1, // Android only - API >= 28
      //   asAlarm: false, // Android only - all APIs
      // );
    });
// App Backgroud
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: SubcriptionModel()),
          ChangeNotifierProvider.value(value: HighlightProvider()),
          ChangeNotifierProvider.value(value: BookReadtModel()),
          ChangeNotifierProvider.value(value: AuthProvider()),
          ChangeNotifierProvider.value(value: CategoryProvider()),
          ChangeNotifierProvider.value(value: Orther()),
          ChangeNotifierProvider.value(value: FavouriteProviderModel()),
          ChangeNotifierProvider.value(value: CategoriesProductListModel()),
          ChangeNotifierProvider.value(value: ThemeProvider()),
          ChangeNotifierProvider.value(value: ReviewProvider()),
        ],
        child: Sizer(builder: (context, orientation, deviceType) {
          return Consumer<ThemeProvider>(
            child: SplashScreen(),
            //child: MusicPlayer(),
            // child: MainPage(
            //   title: '',
            // ),
            //child: SeletectedText(),
            // child: BookRequestingScreen(),
            //child: AboutApp(),
            // child: SplashScreen(),
            // child: TextFieldWidget(),'
            // child: TextAudioFile(),
            builder: (context, model, child) {
              return MaterialApp(
                // ------device preview test----
                // locale: DevicePreview.locale(context), // Add the locale here
                //   builder: DevicePreview.appBuilder,
                debugShowCheckedModeBanner: false,
                supportedLocales: context.supportedLocales,
                localizationsDelegates: context.localizationDelegates,
                locale: context.locale,
                themeMode: model.themeMode,
                theme: MyThemes.lightTheme,
                darkTheme: MyThemes.darkTheme,
                home: child,
                onGenerateRoute: RouteGenerator.generateRoute,
              );
            },
          );
        }));
  }
}
