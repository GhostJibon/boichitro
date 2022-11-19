// import 'package:dhanshirisapp/components/dark_mode_toggler.dart';
// import 'package:dhanshirisapp/components/language_select.dart';
// import 'package:dhanshirisapp/constants/brightness.dart';
// import 'package:dhanshirisapp/provider/theme_provider.dart';
// import 'package:dhanshirisapp/res/colors.dart';
// import 'package:dhanshirisapp/translations/locale_keys.g.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:easy_localization/easy_localization.dart';

// class Setting extends StatelessWidget {
//   int _currentPage = 0;
//   final PageController _pageController = PageController(initialPage: 0);
//   GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
//     return Scaffold(
//       appBar: AppBar(
//           backgroundColor: AppColorFactory.appPrimaryColor,
//           title: Text(
//             LocaleKeys.settings.tr(),
//           )),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SettingOfDropDownItem(),
//             SettingOfDarkModeToggler(),
//             Brightness()
//           ],
//         ),
//       ),
//     );
//   }
// }
