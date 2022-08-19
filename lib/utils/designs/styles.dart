import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

final sPrimaryTextStyle = GoogleFonts.poppins(
  textStyle: const TextStyle(
      fontWeight: FontWeight.w500, fontSize: 31, color: Colors.white),
);

final sOnBoarding2BigText = GoogleFonts.poppins(
  textStyle: const TextStyle(
      fontWeight: FontWeight.w600, fontSize: 31, color: kPrimaryColor),
);

final sOnBoarding2SmallText = GoogleFonts.poppins(
    textStyle: const TextStyle(
        fontWeight: FontWeight.w400, fontSize: 16, color: kTextColor));

final sButtonTextStyle = GoogleFonts.inter(
  textStyle: const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: kPrimaryColor,
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
