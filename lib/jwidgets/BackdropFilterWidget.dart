import 'dart:ui';

import 'package:flutter/material.dart';

// https://api.flutter.dev/flutter/widgets/BackdropFilter-class.html

class BackdropFilterWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BackdropFilterWidgetState();
}

class _BackdropFilterWidgetState extends State<BackdropFilterWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: <Widget>[
      Text('0' * 10000),
      Center(
          // <-- clips to the 200x200 [Container] below
          child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5.0,
            sigmaY: 5.0,
          ),
          child: Container(
            alignment: Alignment.center,
            width: 200.0,
            height: 200.0,
            child: const Text('Hello World'),
          ),
        ),
      ))
    ]);
  }
}
