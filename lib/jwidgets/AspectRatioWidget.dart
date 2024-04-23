// https://api.flutter.dev/flutter/widgets/AspectRatio-class.html

import 'package:flutter/material.dart';

class AspectRatioWidget extends StatelessWidget {
  const AspectRatioWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blue[100],
        alignment: Alignment.center,
        width: double.infinity,
        height: 100.0,
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            // height and width not used because AspectRatio overrides them
            height: 50,
            width: 50,
            color: Colors.green[200],
          ),
        ));
  }
}
