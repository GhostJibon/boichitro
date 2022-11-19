// import 'dart:ffi';

// import 'package:dhanshirisapp/constants/app_constants.dart';
// import 'package:dhanshirisapp/provider/subcription.dart';
// import 'package:dhanshirisapp/res/colors.dart';
// import 'package:dhanshirisapp/services/secure_storage_service.dart';
// import 'package:dhanshirisapp/translations/locale_keys.g.dart';
// import 'package:dhanshirisapp/widget/shimmer.dart';
// import 'package:dhanshirisapp/widget/subcription_history_list.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';
// import 'package:provider/provider.dart';
// import 'package:sizer/sizer.dart';
// import 'package:easy_localization/easy_localization.dart';

// class SubscriptionScreen extends StatefulWidget {
//   @override
//   _SubscriptionScreenState createState() => _SubscriptionScreenState();
// }

// class _SubscriptionScreenState extends State<SubscriptionScreen> {
//   void didChangeDependencies() async {
//     //------initial call-------
//     var token = await SecureStorageService().readValue(key: AUTH_TOKEN_KEY);
//     print(token);
//     SubcriptionModel subcriptionModel =
//         Provider.of<SubcriptionModel>(context, listen: false);
//     subcriptionModel.currentsubcriptionAPICALL(token);
//     subcriptionModel.subcriptionHistoryAPICALL(token);
//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColorFactory.appPrimaryColor,
//         title: Text(
//           LocaleKeys.current_subcription.tr(),
//           style: TextStyle(
//             fontSize: 2.5.h,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//         elevation: 0,
//       ),
//       // backgroundColor: AppColorFactory.colorWhite,
//       body: SingleChildScrollView(
//         child: Container(
//           height: 90.0.h,
//           width: 100.0.w,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Container(
//                 width: 100.0.h,
//                 height: 45.0.h,
//                 child: Consumer<SubcriptionModel>(
//                     child: CurrentSubcriptionShimmer(),
//                     builder: (context, model, child) {
//                       print('i check');
//                       print(model.isloadingmodel);
//                       return model.isloadingmodelcurrent
//                           ? child as Widget
//                           : Container(
//                               margin: EdgeInsets.symmetric(horizontal: 5),
//                               child: Container(
//                                 color: AppColorFactory.appPrimaryColor,
//                                 width: 100.0.h,
//                                 height: 45.0.h,
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     SizedBox(
//                                       height: 2.0.h,
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       // crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Container(
//                                           width: 50.0.w,
//                                           child: Center(
//                                             child: Text(
//                                               LocaleKeys.current_active_plan
//                                                   .tr(),
//                                               style: TextStyle(
//                                                   color: AppColorFactory
//                                                       .colorWhite,
//                                                   fontSize: 2.0.h),
//                                             ),
//                                           ),
//                                         ),
//                                         Container(
//                                           width: 30.0.w,
//                                           child: Center(
//                                             child: Text(
//                                               model.CurrentSubcriptionData!
//                                                   .total_cost
//                                                   .toString(),
//                                               style: TextStyle(
//                                                   color: AppColorFactory
//                                                       .colorWhite,
//                                                   fontSize: 2.5.h),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: 30,
//                                     ),
//                                     //-------------circularprograssbar ----------------
//                                     Container(
//                                       child: Center(
//                                         child: CircularPercentIndicator(
//                                           radius: 170.0,
//                                           animation: true,
//                                           animationDuration: 1200,
//                                           lineWidth: 20.0,
//                                           percent: double.parse(model
//                                                   .CurrentSubcriptionData!
//                                                   .percentage!
//                                                   .toStringAsFixed(1)) /
//                                               100,
//                                           center: Center(
//                                             child: Column(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               children: [
//                                                 Center(
//                                                   child: new Text(
//                                                     model
//                                                         .CurrentSubcriptionData!
//                                                         .days_remaining
//                                                         .toString(),
//                                                     style: new TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         color: Colors.white,
//                                                         fontSize: 3.5.h),
//                                                   ),
//                                                 ),
//                                                 Center(
//                                                   child: new Text(
//                                                     LocaleKeys.days_remaining
//                                                         .tr(),
//                                                     style: new TextStyle(
//                                                         //  fontWeight: FontWeight.bold,
//                                                         color: Colors.white,
//                                                         fontSize: 1.3.h),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           circularStrokeCap:
//                                               CircularStrokeCap.butt,
//                                           backgroundColor: Colors.white,
//                                           progressColor: Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 5.0.h,
//                                     ),
//                                     Container(
//                                       child: Center(
//                                         child: Text(
//                                           "${LocaleKeys.planstartedfrom.tr()}: ${model.CurrentSubcriptionData!.start_date!.replaceRange(10, model.CurrentSubcriptionData!.start_date!.length, '')}",
//                                           maxLines: 1,
//                                           style: TextStyle(
//                                               color: AppColorFactory.colorWhite,
//                                               fontSize: 2.0.h),
//                                         ),
//                                       ),
//                                     ),
//                                     Container(
//                                       child: Center(
//                                         child: Text(
//                                           "${LocaleKeys.valid_till.tr()}:${model.CurrentSubcriptionData!.end_date!.replaceRange(10, model.CurrentSubcriptionData!.end_date!.length, '')}",
//                                           maxLines: 1,
//                                           style: TextStyle(
//                                               color: AppColorFactory.colorWhite,
//                                               fontSize: 2.0.h),
//                                         ),
//                                       ),
//                                     ),
//                                     Container(
//                                       child: Center(
//                                         child: Text(
//                                           "_________________________",
//                                           style: TextStyle(
//                                               color: Colors.grey, fontSize: 12),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               padding: EdgeInsets.symmetric(horizontal: 20.0),
//                               decoration: BoxDecoration(
//                                 color: AppColorFactory.appPrimaryColor,
//                                 borderRadius: BorderRadius.all(
//                                   Radius.circular(15),
//                                 ),
//                               ),
//                             );
//                     }),
//               ),

//               SizedBox(
//                 height: 1.0.h,
//               ),
//               //------------history Part ----------------
//               Container(
//                 height: 43.0.h,
//                 margin: EdgeInsets.only(left: 3.0.w, right: 3.0.w),
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(15),
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                           color: AppColorFactory.appPrimaryColor,
//                           spreadRadius: 2,
//                           blurRadius: 3,
//                           offset: Offset(0, 2))
//                     ]),
//                 child: Column(
//                   children: [
//                     Container(
//                       height: 4.0.h,
//                       child: Center(
//                         child: Text(
//                           LocaleKeys.subcription_history.tr(),
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 2.2.h,
//                             color: AppColorFactory.appPrimaryColor,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 1.0.h,
//                     ),
//                     Container(
//                         height: 35.0.h,
//                         child: Consumer<SubcriptionModel>(
//                           child: Center(
//                             child: CircularProgressIndicator(
//                               color: Colors.red,
//                             ),
//                           ),
//                           builder: (context, model, child) {
//                             return model.isloadingsubcriptionhistory
//                                 ? child as Widget
//                                 : ListView.builder(
//                                     scrollDirection: Axis.vertical,
//                                     itemCount:
//                                         model.subcriptionHistorys!.length,
//                                     itemBuilder: (context, index) {
//                                       var data =
//                                           model.subcriptionHistorys![index];
//                                       return SubcriptionHistoryList(data: data);
//                                     });
//                           },
//                         ))
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
