import 'package:flutter/material.dart';

// Center about from https://github.com/matthew-carroll/fluttery/blob/master/lib/src/layout_core.dart
class CenterAbout extends StatelessWidget {
  final Offset position;
  final Widget child;

  CenterAbout({
    key,
    this.position,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Positioned(
      left: position.dx,
      top: position.dy,
      child: new FractionalTranslation(
        translation: const Offset(-0.5, -0.5),
        child: child,
      ),
    );
  }
}
