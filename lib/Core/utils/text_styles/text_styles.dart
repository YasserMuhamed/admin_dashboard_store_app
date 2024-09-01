import 'package:flutter/material.dart';

class MyTextStyles {
  static TextStyle get title {
    return const TextStyle(
      fontSize: 34,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle get titleSmall {
    return const TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle get subtitle {
    return const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle get subtitleSmall {
    return const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle get subtitleTOOSmall {
    return const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle get body {
    return const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
    );
  }

  static TextStyle get bodySmall {
    return const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
    );
  }
}
