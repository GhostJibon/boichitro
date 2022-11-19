import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../provider/theme_provider.dart';
import '../../res/colors.dart';
import '../../translations/locale_keys.g.dart';

class AboutPage extends StatelessWidget {
  static const routeName = '/about-screen';
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    // TODO: implement build
    return Scaffold(
      backgroundColor: AppColorFactory.appPrimaryColor,
      appBar: AppBar(
        backgroundColor: AppColorFactory.appPrimaryColor,
        elevation: 0,
        title: Text(
          LocaleKeys.about.tr(),
          // style: TextStyle(fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          child: Container(
            height: 88.3.h,
            width: 100.0.w,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/aboutpage.png'), fit: BoxFit.fill),
            ),
            child: Column(children: [
              SizedBox(
                height: 4.0.h,
              ),
              Container(
                height: 28.0.h,
                padding: EdgeInsets.only(left: 7.0.w, right: 7.0.w),
                child: SingleChildScrollView(
                  child: Text(
                    " বইচিত্র জাতীয় পর্যায়ের বাংলাদেশী বুক আর্কাইভ অ্যাপ। ডিজিটাল লাইব্রেরী ফরম্যাটে এই আর্কাইভটি তৈরি করা হয়েছে। এই আর্কাইভে থাকছে মুক্তিযুদ্ধ বিষয়ক বই, উপন্যাস, কবিতা, প্রবন্ধ, শিশু সাহিত্য, সাহিত্য সমালোচনা এবং অন্যান্য বিভিন্ন বিষয় ভিত্তিক বই। কেবল টেক্সট ফরম্যাটে নয়, এই আর্কাইভে থাকছে অডিও-বুক। সেই সাথে সাহিত্য বিষয়ে যে সকল চলচ্চিত্র তৈরি হয়েছে সেই সকল চলচ্চিত্র এই আর্কাইভে সন্নিবেশিত থাকছে। থাকছে সাহিত্য বিষয়ক আলোচনা এবং ব্লগিং।বইচিত্র-এ প্রতিটি প্রকাশনা বিষয়ে এবং লেখক সম্পর্কে নোট থাকছে। পাঠক খুব সহজেই প্রকাশনা বিষয়ে জেনে নিতে পারবেন এই আর্কাইভ থেকে।এছাড়া বইচিত্র-এ অন্যান্য বই ভিত্তিক অ্যাপ, ওয়েবসাইট, জাতীয় ও আন্তর্জাতিক প্রকাশনা প্রতিষ্ঠানের লিঙ্ক থাকছে। পাঠকবৃন্দ বইচিত্র মোবাইল অ্যাপটি প্রকাশনা বিষয়ক একটি কেন্দ্রীয় ডিজিটাল হাব হিসেবে স্বাচ্ছন্দ্যে ব্যবহার করতে পারবেন। ",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 1.5.h,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0.h,
                width: 40.0.w,
                child: themeProvider.isDarkMode
                    ? Image.asset('assets/Dhanshiri-Digital.png')
                    // Image.asset('assets/Dhanshiri-Digital-white.png')
                    : Image.asset('assets/Dhanshiri-Digital.png'),
              ),
              SizedBox(
                height: 38.0.h,
              ),
              Container(
                height: 2.20.h,
                alignment: Alignment.center,
                child: Center(
                  child: Text(
                    'Address : House#472, Road#8, Baridhara DOHS,Dhaka-1206,Bangladesh.',
                    style: TextStyle(
                      fontSize: 1.3.h,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Container(
                height: 2.20.h,
                alignment: Alignment.center,
                child: Center(
                  child: Text(
                    'Email : boichitro21@gmail.com',
                    style: TextStyle(
                      fontSize: 1.3.h,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
