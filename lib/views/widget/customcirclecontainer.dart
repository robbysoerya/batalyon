import 'package:flutter/material.dart';

class CustomCircleContainer extends StatelessWidget {
  const CustomCircleContainer({
    Key key,
    @required this.height,
    @required this.width,
    @required this.color,
    this.showShadow,
    this.child,
    this.controller,
  }) : super(key: key);

  final double height;
  final double width;
  final Color color;
  final Widget child;
  final bool showShadow;
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: controller != null
            ? color.withOpacity(1 - controller.value)
            : color,
        shape: BoxShape.circle,
        boxShadow: (showShadow ?? false)
            ? [
                BoxShadow(
                  color: Colors.grey[500],
                  blurRadius: 2,
                  spreadRadius: 4,
                )
              ]
            : [],
      ),
      child: child,
    );
  }
}
