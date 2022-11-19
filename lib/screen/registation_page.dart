// import 'package:dhanshirisapp/provider/singupmodel.dart';
// import 'package:dhanshirisapp/screen/Dashboard.dart';
// import 'package:dhanshirisapp/screen/button_navigation_bar.dart';
// import 'package:dhanshirisapp/widget/custom_textFormField.dart';
// import 'package:dhanshirisapp/widget/custom_textFormTitle.dart';
// import 'package:dhanshirisapp/widget/text_field_password_box.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sizer/sizer.dart';

// class RegistationScreen extends StatefulWidget {
//   final String phone;
//   RegistationScreen(this.phone);
//   @override
//   _RegistationScreen createState() => _RegistationScreen();
// }

// class _RegistationScreen extends State<RegistationScreen> {
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   String phone = ' ';
//   bool ischeck = false;
//   bool is_futurebuilders = false;
//   bool checkBoxValue = false;
//   GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

//   final Map<String, dynamic> _registationform = {
//     'name': null,
//     'phone': null,
//     'email': null,
//     'password': null,
//     'password_confirmation': null,
//   };
//   _submitForm(BuildContext context, Function Authentication) async {
//     final Map<String, dynamic> authentication = await Authentication(
//       _registationform['name'],
//       widget.phone,
//       _registationform['email'],
//       _registationform['password'],
//     );
//     if (authentication['success']) {
//       ///   Navigator.pop(context, true);

//       Navigator.push(
//           context, MaterialPageRoute(builder: (context) => Example()));
//     } else {
//       showDialog(
//           // barrierColor: Color(0xFFdab13c),
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               backgroundColor: Color(0xFFefe7dc),
//               title: Text(
//                 'An error Occurred',
//               ),
//               content: Text(
//                 authentication['message'],
//               ),
//               actions: <Widget>[
//                 FlatButton(
//                   child: Text('Ok'),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 )
//               ],
//             );
//           });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // SingUpModel singUpModel = Provider.of<SingUpModel>(context);
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           height: 100.0.h,
//           width: 100.0.w,
//           child: Form(
//             key: formKey,
//             child: Stack(
//               children: [
//                 Container(
//                     // height: 100.0.h,
//                     height: 87.0.h,
//                     width: 100.0.w,
//                     // left: 0.0.w,
//                     // bottom: 0.0.h,
//                     child: Image(
//                       image: AssetImage('assets/background_image01.png'),
//                       fit: BoxFit.fill,
//                     )),
//                 Positioned(
//                   top: 05.0.h,
//                   //height: 6.0.h,
//                   child: Form(
//                     key: _globalKey,
//                     child: Column(
//                       children: [
//                         //CustomTextFormTitle contain Name
//                         CustomTextFormTitle(titlename: "Name"),
//                         // CustomTextFormField contain
//                         CustomTextFormField(
//                           onChanged: (String value) {
//                             _registationform['name'] = value;
//                             phone = value;
//                           },
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return "Please Enter Your Name";
//                             } else {
//                               return null;
//                             }
//                           },
//                         ),
//                         SizedBox(
//                           height: 1.0.h,
//                         ),
//                         //CustomTextFormTitle contain Name
//                         CustomTextFormTitle(titlename: "Email"),
//                         // CustomTextFormField contain
//                         CustomTextFormField(
//                           onChanged: (String value) {
//                             _registationform['email'] = value;
//                             phone = value;
//                           },
//                           validator: (value) {
//                             if (value!.isEmpty ||
//                                 !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
//                                     .hasMatch(value)) {
//                               return 'Please enter a valid email';
//                             } else {
//                               return null;
//                             }
//                           },
//                         ),
//                         SizedBox(
//                           height: 1.0.h,
//                         ),
//                         //CustomTextFormTitle contain Name
//                         // CustomTextFormTitle(titlename: "Phone Number"),
//                         // // CustomTextFormField contain
//                         // CustomTextFormField(
//                         //   onChanged: (String value) {
//                         //     phone = value;
//                         //   },
//                         // ),
//                         SizedBox(
//                           height: 1.0.h,
//                         ),
//                         //CustomTextFormTitle contain Name
//                         CustomTextFormTitle(titlename: "Password"),
//                         // CustomTextFormField contain
//                         CustomTextFieldPasswordBox(
//                           hindtext: "********",
//                           onSaved: (String value) {
//                             _registationform['password_confirmation'] = value;
//                           },
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return "Please Enter New Password";
//                             } else if (value.length < 8) {
//                               return "Password must be atleast 8 characters long";
//                             } else {
//                               return null;
//                             }
//                           },
//                           passwordVisible: ischeck,
//                           sufOnPress: () {
//                             setState(() {
//                               ischeck = true;
//                             });
//                           },
//                         ),
//                         SizedBox(
//                           height: 1.0.h,
//                         ),
//                         //CustomTextFormTitle contain Name
//                         CustomTextFormTitle(titlename: "Confirm Password"),
//                         // CustomTextFormField contain
//                         CustomTextFieldPasswordBox(
//                           hindtext: "********",
//                           onSaved: (String value) {
//                             _registationform['password'] = value;
//                           },
//                           validator: (value) {
//                             print('password');
//                             print(_registationform['password_confirmation']);
//                             if (value!.isEmpty) {
//                               return "Please Re-Enter New Password";
//                             } else if (value.length < 8) {
//                               return "Password must be atleast 8 characters long";
//                             } else if (value !=
//                                 _registationform['password_confirmation']) {
//                               return "Password must be same as above";
//                             } else {
//                               return null;
//                             }
//                           },
//                           passwordVisible: ischeck,
//                           sufOnPress: () {
//                             setState(() {
//                               ischeck = true;
//                             });
//                           },
//                         ),
//                         SizedBox(height: 2.0.h),
//                         Consumer<SingUpModel>(builder: (context, model, child) {
//                           return Container(
//                               width: 80.0.w,
//                               height: 5.0.h,
//                               margin: EdgeInsets.only(
//                                 left: 10.0.w,
//                                 right: 10.0.w,
//                               ),
//                               child: RaisedButton(
//                                   color: Color(0xffb8242a),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(40.0),
//                                   ),
//                                   onPressed: () {
//                                     if (!_globalKey.currentState!.validate()) {
//                                       return;
//                                     }
//                                     _globalKey.currentState!.save();

//                                     setState(() {
//                                       is_futurebuilders = true;
//                                     });
//                                   },
//                                   child: Center(
//                                     child: Text(
//                                       "Register",
//                                       style: TextStyle(
//                                         fontFamily: 'PublicaPlay',
//                                         fontSize: 2.0.h,
//                                         fontStyle: FontStyle.normal,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   )));
//                         }),
//                         SizedBox(
//                           height: 1.5.h,
//                         ),
//                         is_futurebuilders == true
//                             ? Container(
//                                 margin: EdgeInsets.only(top: 50.0.h),
//                                 height: 10.0.h,
//                                 child: FutureBuilder(
//                                     future: _submitForm(
//                                         context, singUpModel.authentication),
//                                     builder: (context, AsyncSnapshot snapshot) {
//                                       print('---------hasdata----------');
//                                       print(snapshot.hasData);
//                                       is_futurebuilders = false;
//                                       return snapshot.connectionState ==
//                                               ConnectionState.waiting
//                                           ? Center(
//                                               child: CircularProgressIndicator(
//                                                   backgroundColor:
//                                                       Colors.white),
//                                             )
//                                           : (snapshot.hasData)
//                                               ? Container(
//                                                   child: Center(
//                                                   child: Text(''),
//                                                 ))
//                                               : (!snapshot.hasData)
//                                                   ? Center(
//                                                       child: Text(''),
//                                                     )
//                                                   : Center(
//                                                       child:
//                                                           CircularProgressIndicator(),
//                                                     );

//                                       //   return Center(child: CircularProgressIndicator());
//                                     }),
//                               )
//                             : Container(),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
