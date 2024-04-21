import 'package:flutter/material.dart';

// https://api.flutter.dev/flutter/widgets/AnimatedCrossFade-class.html

class AnimatedCrossFadeWidget extends StatefulWidget {
  const AnimatedCrossFadeWidget({super.key});

  @override
  State<StatefulWidget> createState() => AnimatedCrossFadeWidgetState();
}

class AnimatedCrossFadeWidgetState extends State<AnimatedCrossFadeWidget> {
  bool _first = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            _first = !_first;
          });
        },
        child: AnimatedCrossFade(
          duration: const Duration(seconds: 1),
          crossFadeState:
              _first ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          firstChild: Container(
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.blue[200]),
            height: 200,
            width: 200,
            child: const Center(child: Text("First child")),
          ),
          secondChild: Container(
            height: 100,
            width: 100,
            color: Colors.green[200],
            child: const Center(child: Text("First child")),
          ),
          layoutBuilder: (topChild, topChildKey, bottomChild, bottomChildKey) {
            return Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Positioned(
                  key: bottomChildKey,
                  top: 0,
                  child: bottomChild,
                ),
                Positioned(
                  key: topChildKey,
                  child: topChild,
                ),
              ],
            );
          },
        ));
  }
}
