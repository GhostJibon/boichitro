import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    print('----check dark mode ----');
    print(isOn);
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    //  print(isOn);
    //  SharedPreferences prefs = await SharedPreferences.getInstance();
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.black,
    colorScheme: ColorScheme.dark(),
    iconTheme: IconThemeData(color: Colors.purple.shade200, opacity: 0.8),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    colorScheme: ColorScheme.light(),
    iconTheme: IconThemeData(color: Colors.red, opacity: 0.8),
  );
}

// import 'package:dhanshirisapp/model/theamdata.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ThemeProvider with ChangeNotifier {
//   final String key = 'theme';
//   bool _darkTheme = false;
//   SharedPreferences? pref;

//   ThemeProvider() {
//     _loadData();
//   }

//   Future initialPref() async {
//     if (pref == null) {
//       pref = await SharedPreferences.getInstance();
//     }
//   }

//   bool get isDarkTheme => _darkTheme;
//   ThemeData get getTheme {
//     return _darkTheme ? darkTheme : lightTheme;
//   }

//   toggleTheme() {
//     _darkTheme = !_darkTheme;
//     pref!.setBool(key, _darkTheme);
//     notifyListeners();
//   }

//   _loadData() async {
//     await initialPref();
//     _darkTheme = pref!.getBool(key) ?? false;
//     notifyListeners();
//   }
// }
