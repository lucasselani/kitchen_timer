import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class Themes {
  static ThemeData appTheme(BuildContext context) => ThemeData(
        primarySwatch: AppColors.primaryColor,
        accentColor: AppColors.accentColor,
        backgroundColor: AppColors.primaryColor,
        textSelectionColor: AppColors.primaryColor,
        brightness: Brightness.light,
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
      );
}
