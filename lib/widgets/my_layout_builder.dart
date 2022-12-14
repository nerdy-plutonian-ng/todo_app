import 'package:flutter/material.dart';

class MyLayoutBuilder extends StatelessWidget {
  const MyLayoutBuilder(
      {Key? key, required this.mobileLayout, required this.tabletLayout})
      : super(key: key);

  final Widget mobileLayout;
  final Widget tabletLayout;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, boxConstraints) {
      final isMobile =
          boxConstraints.maxHeight / boxConstraints.maxWidth >= 1.7;
      return isMobile ? mobileLayout : tabletLayout;
    });
    ;
  }
}
