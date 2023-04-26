import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gp/core/Colors/colors.dart';

class AppTextStyles {
  static final TextStyle title = GoogleFonts.notoSans(
    color: MyColors.white,
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle titleBold = GoogleFonts.notoSans(
    color: MyColors.white,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle heading = GoogleFonts.notoSans(
    color: Colors.black,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle heading40 = GoogleFonts.notoSans(
    color: Colors.black,
    fontSize: 40,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle heading15 = GoogleFonts.notoSans(
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle body = GoogleFonts.notoSans(
    color: Color(0xFF6E6680),
    fontSize: 13,
    fontWeight: FontWeight.normal,
  );

  static final TextStyle bodyBold = GoogleFonts.notoSans(
    color: Colors.grey,
    fontSize: 13,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle bodylightGrey = GoogleFonts.notoSans(
    color: MyColors.color3,
    fontSize: 13,
    fontWeight: FontWeight.normal,
  );
  static final TextStyle bodyDarkGreen = GoogleFonts.notoSans(
    color: MyColors.color1,
    fontSize: 13,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle bodyDarkRed = GoogleFonts.notoSans(
    color: MyColors.color4,
    fontSize: 13,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle body20 = GoogleFonts.notoSans(
    color: Color(0xFF6E6680),
    fontSize: 20,
    fontWeight: FontWeight.normal,
  );
  static final TextStyle bodyLightGrey20 = GoogleFonts.notoSans(
    color: Color(0xFFA6A1B2),
    fontSize: 20,
    fontWeight: FontWeight.normal,
  );

  static final TextStyle bodyWhite20 = GoogleFonts.notoSans(
    color: MyColors.white,
    fontSize: 20,
    fontWeight: FontWeight.normal,
  );
  static final TextStyle body11 = GoogleFonts.notoSans(
    color: Color(0xFF6E6680),
    fontSize: 11,
    fontWeight: FontWeight.normal,
  );
}
