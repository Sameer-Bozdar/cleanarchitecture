import 'package:flutter/material.dart';

class Gap extends StatelessWidget {
  final String axis;
  final double height;
  final double width;
  const Gap({
    Key? key,
    required this.axis,
    this.height = 0.0,
    this.width = 0.00,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return axis == 'x'
        ? SizedBox(
            width: width,
          )
        : SizedBox(
            height: height,
          );
  }
}
