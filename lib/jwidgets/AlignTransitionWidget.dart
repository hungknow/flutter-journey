// https://api.flutter.dev/flutter/widgets/AlignTransition-class.html
// https://api.flutter.dev/flutter/widgets/AnimatedAlign-class.html

import 'package:flutter/material.dart';

class AlignTransitionWidget extends StatefulWidget {
  @override
  _AlignTransitionWidgetState createState() => _AlignTransitionWidgetState();
}

class _AlignTransitionWidgetState extends State<AlignTransitionWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<AlignmentGeometry> _animation = Tween<AlignmentGeometry>(
    begin: Alignment.bottomLeft,
    end: Alignment.center,
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    ),
  );

  bool selected = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      // Use AlignTransaction
      // ColoredBox(
      //     color: Colors.white,
      AlignTransition(
          alignment: _animation,
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: FlutterLogo(size: 150.0),
          )),
      // Use AnimatedAlign
      GestureDetector(
        onTap: () {
          setState(() {
            selected = !selected;
          });
        },
        child: AnimatedAlign(
          alignment: selected ? Alignment.center : Alignment.topRight,
          duration: const Duration(seconds: 2),
          curve: Curves.fastOutSlowIn,
          child: const FlutterLogo(size: 150.0),
        ),
      )
    ]);
  }
}
