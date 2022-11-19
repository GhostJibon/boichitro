import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:sizer/sizer.dart';

class TextAudioFile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Column(
      children: [
        Container(
            height: 20.0.h,
            child: WebView(
              initialUrl:
                  "https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/1210938040%3Fsecret_token%3Ds-Tc4etU1H2sV&color=%23ff5500&auto_play=true&hide_related=false&show_comments=true&show_user=true&show_reposts=false&show_teaser=true",
              javascriptMode: JavascriptMode.unrestricted,
            )),
      ],
    ));

    //      Container(
    //   child: Center(
    //       child: WebView(
    //     initialUrl:
    //         '<iframe width="100%" height="166" scrolling="no" frameborder="no" allow="autoplay" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/1210938040%3Fsecret_token%3Ds-Tc4etU1H2sV&color=%23ff5500&auto_play=true&hide_related=false&show_comments=true&show_user=true&show_reposts=false&show_teaser=true"></iframe><div style="font-size: 10px; color: #cccccc;line-break: anywhere;word-break: normal;overflow: hidden;white-space: nowrap;text-overflow: ellipsis; font-family: Interstate,Lucida Grande,Lucida Sans Unicode,Lucida Sans,Garuda,Verdana,Tahoma,sans-serif;font-weight: 100;"><a href="https://soundcloud.com/boichitro" title="BoiChitro - বই চিত্র" target="_blank" style="color: #cccccc; text-decoration: none;">BoiChitro - বই চিত্র</a> · <a href="https://soundcloud.com/boichitro/amr-chotto-shona-rasel/s-Tc4etU1H2sV" title="Amader Chotto  Rasel Shona" target="_blank" style="color: #cccccc; text-decoration: none;">Amader Chotto  Rasel Shona</a></div>',
    //     // initialUrl:
    //     //     "https://soundcloud.com/boichitro/amr-chotto-shona-rasel/s-Tc4etU1H2sV?si=c9c7d7ddd1a24a3796c197a3b04c47bf&utm_source=clipboard&utm_medium=text&utm_campaign=social_sharing",
    //     javascriptMode: JavascriptMode.unrestricted,
    //     onWebViewCreated: (WebViewController webViewController) {},
    //     onPageStarted: (String url) {
    //       print('Page started loading: $url');
    //     },
    //     onPageFinished: (String url) {
    //       print('Page finished loading: $url');
    //     },
    //     gestureNavigationEnabled: true,
    //   )),
    // ));
  }
}
