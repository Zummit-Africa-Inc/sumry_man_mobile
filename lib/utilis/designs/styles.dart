import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'colors.dart';

final sPrimaryTextStyle = GoogleFonts.poppins(
  textStyle: const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 31,
    color: Colors.white,
  ),
);

final sHintTextStyle = GoogleFonts.poppins(
  textStyle: const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: kTextColor,
  ),
);


final sSignUpTextStyle = GoogleFonts.poppins(
  textStyle: const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 26,
    color: kPrimaryColor,
  ),
);

final sButtonTextStyle = GoogleFonts.inter(
  textStyle: const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: kPrimaryColor,
  ),
);
