import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final VoidCallback? onTabbed;
  final Text? myStyle;
  final Color? myColor;

  final double? width;
  final double? height;

  MainButton(
      {required this.onTabbed,
      required this.myStyle,
      required this.myColor,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTabbed,
      child: Container(
        child: Center(
          child: myStyle,
        ),
        margin: EdgeInsets.only(top: 10.0),
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: myColor,
        ),
      ),
    );
  }
}
