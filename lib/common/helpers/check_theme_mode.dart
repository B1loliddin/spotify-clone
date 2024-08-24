import 'package:flutter/material.dart';

extension CheckThemeMode on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}
