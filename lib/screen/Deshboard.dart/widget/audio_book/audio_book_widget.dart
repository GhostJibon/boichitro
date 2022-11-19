import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../provider/deshboard.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../../../widget/no_data_available.dart';
import '../../../../widget/shimmer.dart';
import '../../../audio/audio_card.dart';

class AudioBookWidget extends StatefulWidget {
  const AudioBookWidget({Key? key}) : super(key: key);

  @override
  State<AudioBookWidget> createState() => _AudioBookWidgetState();
}

class _AudioBookWidgetState extends State<AudioBookWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // --------------    Audio Book -------------------
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 05.0.w, top: 1.0.h),
          height: 5.0.h,
          child: Text(
            // "audiobook",
            LocaleKeys.audiobook.tr(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 2.0.h,
              //   color: Colors.black
            ),
          ),
        ),
        // --------------AUdio book List -----------

        Container(
          alignment: Alignment.topLeft,
          height: 27.0.h,
          margin: EdgeInsets.only(left: 01.0.w, bottom: 0.5.h),
          child: Consumer<CategoryProvider>(
            child: BookCartShimmer(),
            builder: (context, modal, child) {
              return modal.isLoadingAudioBookInfo
                  ? child as Widget
                  : modal.audioBookModel!.length == 0
                      ? NodataAvailableClass('No Audio Book Available', 25.0.h)
                      : ListView.builder(
                          shrinkWrap: false,
                          scrollDirection: Axis.horizontal,
                          itemCount: modal.audioBookModel!.length,
                          itemBuilder: (context, index) {
                            final audiobookdetails =
                                modal.audioBookModel![index];
                            return AudioBookCart(audiobookdetails);
                          });
            },
          ),
        ),
      ],
    );
  }
}
