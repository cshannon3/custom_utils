// Random color from https://github.com/matthew-carroll/fluttery/blob/master/lib/framing.dart
/// Tools for framing out user interfaces quickly.
import 'dart:math';
import 'dart:ui';

import 'package:flutter/widgets.dart';

class RandomColor {
  static final Random _random = new Random();

  /// Returns a random color.
  static Color next() {
    return new Color(0xFF000000 + _random.nextInt(0x00FFFFFF));
  }
}
