import 'package:dhanshirisapp/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeThemeButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return Switch.adaptive(
        value: themeProvider.isDarkMode,
        onChanged: (value) {
          themeProvider.toggleTheme(value);
          // final snackBar = ScaffoldMessenger.of(context,);
          // snackBar.showSnackBar(SnackBar(
          //   content: Text("Theme Changed"),
          //   action: SnackBarAction(
          //       label: "DISMISS", onPressed: snackBar.hideCurrentSnackBar),
          // ));
        },
      );
    });
  }
}

// import 'package:dhanshirisapp/provider/theme_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class ThemeDropdownButton extends StatefulWidget {
//   @override
//   _ThemeDropdownButtonState createState() => _ThemeDropdownButtonState();
// }

// class _ThemeDropdownButtonState extends State<ThemeDropdownButton> {
//   @override
//   Widget build(BuildContext context) {
//     var themeObj = Provider.of<ThemeProvider>(context, listen: true);
//     bool themeFlag = themeObj.isDarkTheme;
//     String selectedItem = themeFlag ? 'Dark' : 'Light';
//     return DropdownButton<String>(
//         value: selectedItem,
//         underline: Container(),
//         items: [
//           DropdownMenuItem(
//             child: Text(
//               'Dark',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             value: 'Dark',
//           ),
//           DropdownMenuItem(
//             child: Text(
//               'Light',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             value: 'Light',
//           )
//         ],
//         onChanged: (value) {
//           setState(() {
//             if (value == 'Dark' && selectedItem == 'Light' ||
//                 value == 'Light' && selectedItem == 'Dark') {
//               themeObj.toggleTheme();
//             }
//             selectedItem = value.toString();
//           });
//         });
//   }
// }