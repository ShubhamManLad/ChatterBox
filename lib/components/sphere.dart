import 'package:chatterbox/constants/colors.dart';
import 'package:flutter/material.dart';

class Sphere extends StatelessWidget {
  double h;
  double w;
  Sphere({super.key,  required this.h, required this.w});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: h,
      width: w,
      // Below is the code for Linear Gradient.
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        gradient: LinearGradient(
          colors: [Colors.white30, primaryColor],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
    );
  }
}
