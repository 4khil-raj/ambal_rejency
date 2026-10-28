import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  // Heading font family: Cormorant Garamond (Editorial luxury serif)
  static TextStyle serif({
    double fontSize = 24,
    FontWeight fontWeight = FontWeight.normal,
    Color color = AppColors.textCharcoal,
    double letterSpacing = 0.5,
    double? height,
    FontStyle fontStyle = FontStyle.normal,
  }) {
    return GoogleFonts.cormorantGaramond(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      fontStyle: fontStyle,
    );
  }

  // Sans font family: Plus Jakarta Sans (Clean, modern geometric sans)
  static TextStyle sans({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
    Color color = AppColors.textCharcoal,
    double letterSpacing = 0.2,
    double? height,
  }) {
    return GoogleFonts.plusJakartaSans(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  // Editorial display styles
  static TextStyle heroTitle({Color color = Colors.white, double scale = 1.0}) => serif(
    fontSize: 54 * scale,
    fontWeight: FontWeight.w600,
    color: color,
    letterSpacing: 1.2,
    height: 1.15,
  );

  static TextStyle sectionTitle({Color color = AppColors.textCharcoal, double scale = 1.0}) => serif(
    fontSize: 40 * scale,
    fontWeight: FontWeight.w600,
    color: color,
    letterSpacing: 0.8,
    height: 1.2,
  );

  static TextStyle sectionSubtitle({Color color = AppColors.goldDark}) => sans(
    fontSize: 12.5,
    fontWeight: FontWeight.w600,
    color: color,
    letterSpacing: 3.5,
  );

  static TextStyle cardTitle({Color color = AppColors.textCharcoal, double scale = 1.0}) => serif(
    fontSize: 26 * scale,
    fontWeight: FontWeight.w600,
    color: color,
    letterSpacing: 0.5,
    height: 1.25,
  );

  static TextStyle body({Color color = AppColors.textMuted, double fontSize = 15, double height = 1.65}) => sans(
    fontSize: fontSize,
    fontWeight: FontWeight.w400,
    color: color,
    letterSpacing: 0.2,
    height: height,
  );

  static TextStyle button({Color color = Colors.white, double fontSize = 13.5}) => sans(
    fontSize: fontSize,
    fontWeight: FontWeight.w600,
    color: color,
    letterSpacing: 1.6,
  );
}

