import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screen_wake/flutter_screen_wake.dart';

class Brightness extends StatefulWidget {
  Brightness({Key? key}) : super(key: key);

  @override
  State<Brightness> createState() => _BrightnessState();
}

class _BrightnessState extends State<Brightness> {
  double brightness = 0.0;
  bool toggle = false;

  void inintState() {
    super.initState();
    initPlatformBrightnesss();
  }

  Future<void> initPlatformBrightnesss() async {
    double bright;
    try {
      bright = await FlutterScreenWake.brightness;
    } on PlatformException {
      bright = 1.0;
    }
    if (!mounted) return;
    setState(() {
      brightness = bright;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(13),
      child: Center(
        child: Row(
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 10),
                child: AnimatedCrossFade(
                  firstChild: Icon(
                    Icons.brightness_7,
                    size: 22,
                  ),
                  secondChild: Icon(
                    Icons.brightness_3,
                    size: 22,
                  ),
                  crossFadeState: toggle
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: Duration(seconds: 1),
                )),
            Expanded(
                child: Slider(
                    value: brightness,
                    onChanged: (value) {
                      setState(() {
                        brightness = value;
                      });
                      FlutterScreenWake.setBrightness(brightness);
                      if (brightness == 0) {
                        toggle = true;
                      } else {
                        toggle = false;
                      }
                    }))
          ],
        ),
      ),
    );
  }
}
