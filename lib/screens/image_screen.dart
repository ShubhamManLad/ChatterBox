import 'dart:convert';

import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {
  String img;
  ImageScreen({super.key, required this.img});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Image.memory(base64Decode(img)));
  }
}
