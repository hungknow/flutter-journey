import 'package:flutter/material.dart';

// https://api.flutter.dev/flutter/widgets/AnimatedModalBarrier-class.html
// https://www.youtube.com/watch?v=JCtgHg9vCwY

class AnimatedBarrierModalWidget extends StatefulWidget {
  const AnimatedBarrierModalWidget({super.key});

  @override
  State<StatefulWidget> createState() => _AnimatedBarrierModalWidgetState();
}

class _AnimatedBarrierModalWidgetState extends State<AnimatedBarrierModalWidget>
    with SingleTickerProviderStateMixin {
  bool _isModalOpen = false;

  // Set this value to true when you want to use AnimationBarrierModal
  bool _useAnimationBarrier = true;

  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;
  int animationSeconds = 2;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: animationSeconds),
      vsync: this,
    );

    ColorTween _colorTween = ColorTween(
      begin: Colors.orangeAccent.withOpacity(0.5),
      end: Colors.blueGrey.withOpacity(0.5),
    );
    _colorAnimation = _colorTween.animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          width: 250,
          height: 150,
          child: Stack(
            children: [
              Center(
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isModalOpen = true;
                        });
                        _animationController.reset();
                        _animationController.forward();
                        Future.delayed(Duration(seconds: animationSeconds), () {
                          setState(() {
                            _isModalOpen = false;
                          });
                        });
                      },
                      child: const Text('Click Me!'))),
              // Display the modal barrier above the button, so user cannot click the button
              if (!_useAnimationBarrier && _isModalOpen)
                ModalBarrier(
                  color: Colors.green.withOpacity(0.5),
                  dismissible: false,
                  barrierSemanticsDismissible: false,
                )
              else if (_useAnimationBarrier && _isModalOpen)
                AnimatedModalBarrier(
                  color: _colorAnimation,
                  dismissible: false,
                )
            ],
          )),
    );
  }
}
