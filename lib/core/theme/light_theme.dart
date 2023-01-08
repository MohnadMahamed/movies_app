import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/core/theme/app_colors.dart';

ThemeData lightTheme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primarySwatch: Colors.red,
  scaffoldBackgroundColor: AppColors.lighBackGroundColor,
  appBarTheme: const AppBarTheme(
      titleSpacing: 20,
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      elevation: 0.0,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      )),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      elevation: 20.0),
  textTheme: TextTheme(
    bodyText1: GoogleFonts.cairo(
        fontSize: 18.0, fontWeight: FontWeight.w700, color: Colors.black54),
    bodyText2: GoogleFonts.cairo(
        fontSize: 20.0, fontWeight: FontWeight.w700, color: Colors.black87),
    headline1: GoogleFonts.kanit(
        fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.black),
    headline3: GoogleFonts.kanit(
        fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.black),
  ),
);
