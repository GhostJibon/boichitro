import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

class Debouncer {
  Duration delay;
  Timer? _timer;
  VoidCallback? _callback;

  Debouncer({this.delay = const Duration(milliseconds: 100)});

  debounce(VoidCallback? callback) {
    _callback = callback;

    this.cancel();
    _timer = new Timer(delay, this.flush);
  }

  void cancel() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  flush() {
    this._callback!();
    this.cancel();
  }
}
