import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/core/theme/app_colors.dart';

ThemeData darkTheme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  scaffoldBackgroundColor: AppColors.darkBackGroundColor,
  primarySwatch: Colors.red,
  appBarTheme: AppBarTheme(
      titleSpacing: 20,
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: AppColors.darkBackGroundColor,
      elevation: 0.0,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.darkBackGroundColor,
        statusBarIconBrightness: Brightness.light,
      )),
  textTheme: TextTheme(
    bodyText1: GoogleFonts.cairo(
        fontSize: 18.0, fontWeight: FontWeight.w700, color: Colors.white70),
    bodyText2: GoogleFonts.cairo(
        fontSize: 20.0, fontWeight: FontWeight.w700, color: Colors.white),
    headline1: GoogleFonts.kanit(
        fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.white),
    headline3: GoogleFonts.kanit(
        fontSize: 40.0, fontWeight: FontWeight.bold, color: Colors.white),
  ),
);
