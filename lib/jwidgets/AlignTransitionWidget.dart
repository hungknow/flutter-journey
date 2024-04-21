// https://api.flutter.dev/flutter/widgets/AlignTransition-class.html

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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
        color: Colors.white,
        child: AlignTransition(
            alignment: _animation,
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: FlutterLogo(size: 150.0),
            )));
  }
}
