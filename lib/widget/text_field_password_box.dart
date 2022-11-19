import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

class CustomTextFieldPasswordBox extends StatelessWidget {
  final String hindtext;
  final Function(String)? onSaved;
  final String? Function(String?)? validator;
  final Function()? sufOnPress;
  final bool passwordVisible;

  CustomTextFieldPasswordBox({
    required this.hindtext,
    required this.onSaved,
    required this.validator,
    required this.sufOnPress,
    required this.passwordVisible,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 10.0.w, right: 10.0.w),
        height: 5.5.h,
        width: 80.0.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          border: Border.all(color: Color(0xffb8242a), width: 0.2.h),
        ),
        // alignment: Alignment.center,
        child: TextFormField(
          //autofocus: true,
          // textAlign: TextAlign.center,
          maxLines: 1,

          onChanged: onSaved,
          validator: validator,
          // keyboardType: TextInputType.number,
          // inputFormatters: <TextInputFormatter>[
          //   FilteringTextInputFormatter.digitsOnly
          // ],
          // obscureText: !passwordVisible,
          obscureText: true,
          style: TextStyle(color: Color(0xffb8242a), fontSize: 2.0.h),

          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 5.0.w, right: 4.0.w),
            // suffixIcon: IconButton(
            //   alignment: Alignment.center,
            //   icon: Icon(
            //     passwordVisible ? Icons.visibility : Icons.visibility_off,
            //   ),
            //   onPressed: sufOnPress,
            // ),
            hintText: hindtext,
            enabled: true,
            border: InputBorder.none,

            // contentPadding: const EdgeInsets.only(left: 20.0, right: 10.0),
            // focusedBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(15.0),
            //   borderSide: BorderSide(
            //     color: Color(0xFFdab13c),
            //   ),
            // ),
            // border: OutlineInputBorder(
            //   gapPadding: 10,
            //   borderRadius: const BorderRadius.all(
            //     const Radius.circular(15.0),
            //   ),
            // ),
            // enabledBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(15.0),
            //   borderSide: BorderSide(
            //     color: Color(0xFFdab13c),
            //     width: 2.0,
            //   ),
            // ),
          ),
        ));
  }
}
