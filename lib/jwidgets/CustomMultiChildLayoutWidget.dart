import 'package:flutter/material.dart';

class CustomMultiChildLayoutWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomMultiChildLayout(
      delegate: _CascadeLayoutDelegate(),
    );
  }
}

class _CascadeLayoutDelegate extends MultiChildLayoutDelegate {
  @override
  void performLayout(Size size) {
    // TODO: implement performLayout
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    // TODO: implement shouldRelayout
    throw UnimplementedError();
  }
}
