import 'package:chatterbox/constants/colors.dart';
import 'package:flutter/material.dart';

final ButtonStyle flatButtonStyle = ElevatedButton.styleFrom(
  onPrimary: Colors.black87,
  backgroundColor: Color(0xFFF4CE14),
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(15)),
  ),
);

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  onPrimary: Colors.black87,
  backgroundColor: Color(0xFFF4CE14),
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(15)),
  ),
);

final ButtonStyle roundButtonStyle = OutlinedButton.styleFrom(
  //0xFFFBFbFB
  backgroundColor: Colors.black,
  side: BorderSide(color: primaryColor, width: 1),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(50)),
  ),
  //textStyle: GoogleFonts.poppins(textStyle:const TextStyle(fontSize: 16, color: primaryColor,  fontWeight: FontWeight.w500)),
);

