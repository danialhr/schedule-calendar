import 'package:flutter/material.dart';

class Palette {
  static const Color ashGrey = Color(0xFF4A4A4A);
  static const Color blancoWhite = Color(0xFFF8F8F8);
  static const Color black = Colors.black;
  static const Color blackPanther = Color(0xFF0A0A0A);
  static const Color boscoGrey = Color(0xFF232323);
  static const Color lushGreen = Color(0xFF006C66);
  static const Color matGreen = Color(0xFF296152);
  static const Color matPastelGreen = Color(0xFFB8DFD7);
  static const Color matPastelPurple = Color(0xFFCAB8E3);
  static const Color matRed = Color(0xFFEF5A5A);
  static const Color matTurquoise = Color(0xFF76B7B8);
  static const Color muteGrey = Color(0xFFF5F5F5);
  static const Color mistyGrey = Color(0xFFBDBDBD);
  static const Color white = Colors.white;
}

final Color loadingBaseColor = Palette.ashGrey.withOpacity(0.1);
final Color loadingHighlightColor = Palette.ashGrey.withOpacity(0.2);
