import 'package:dhanshirisapp/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AboutApp extends StatelessWidget {
//  const AboutApp({Key? key}) : super(key: key);
  Matrix4 matrix = Matrix4.identity();
  Matrix4 zerada = Matrix4.identity();
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffc60e13),
        title: const Text('About Boichitro'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100.0.w,
              margin: EdgeInsets.only(left: 5.0.w, right: 5.0.w, top: 5.0.h),
              child: InteractiveViewer(
                //panEnabled: false, // Set it to false to prevent panning.
                //boundaryMargin: EdgeInsets.all(10),

                scaleEnabled: true,
                minScale: 1.0,
                maxScale: 2,
                child: Text(
                  'বইচিত্র জাতীয় পর্যায়ের বাংলাদেশী বুক আর্কাইভ অ্যাপ। ডিজিটাল লাইব্রেরী ফরম্যাটে এই আর্কাইভটি তৈরি করা হয়েছে। এই আর্কাইভে থাকছে মুক্তিযুদ্ধ বিষয়ক বই, উপন্যাস, কবিতা, প্রবন্ধ, শিশু সাহিত্য, সাহিত্য সমালোচনা এবং অন্যান্য বিভিন্ন বিষয় ভিত্তিক বই। কেবল টেক্সট ফরম্যাটে নয়, এই আর্কাইভে থাকছে অডিও-বুক। সেই সাথে সাহিত্য বিষয়ে যে সকল চলচ্চিত্র তৈরি হয়েছে সেই সকল চলচ্চিত্র এই আর্কাইভে সন্নিবেশিত থাকছে। থাকছে সাহিত্য বিষয়ক আলোচনা এবং ব্লগিং।বইচিত্র-এ প্রতিটি প্রকাশনা বিষয়ে এবং লেখক সম্পর্কে নোট থাকছে। পাঠক খুব সহজেই প্রকাশনা বিষয়ে জেনে নিতে পারবেন এই আর্কাইভ থেকে।এছাড়া বইচিত্র-এ অন্যান্য বই ভিত্তিক অ্যাপ, ওয়েবসাইট, জাতীয় ও আন্তর্জাতিক প্রকাশনা প্রতিষ্ঠানের লিঙ্ক থাকছে। পাঠকবৃন্দ বইচিত্র মোবাইল অ্যাপটি প্রকাশনা বিষয়ক একটি কেন্দ্রীয় ডিজিটাল হাব হিসেবে স্বাচ্ছন্দ্যে ব্যবহার করতে পারবেন। ',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 1.6.h,
                  ),
                ),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                height: 10.0.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    SizedBox(
                      child: Icon(Icons.location_on),
                    ),
                    SizedBox(
                      width: 65,
                      child: Text(
                        'Address :',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        'House#472, Road#8, Baridhara DOHS, Dhaka-1206, Bangladesh.',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    SizedBox(
                      child: Icon(Icons.email),
                    ),
                    SizedBox(
                      width: 65,
                      child: Text(
                        'Email :',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('boichitro21@gmail.com')
                  ],
                ),
              ),
            ),
            const Divider(),
            SizedBox(
              height: 20.0.h,
              width: 70.0.w,
              child: themeProvider.isDarkMode
                  ? Image.asset('assets/Dhanshiri-Digital-white.png')
                  : Image.asset(
                      'assets/Dhanshiri-Digital.png',
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
