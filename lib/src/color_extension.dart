import 'dart:ui';

extension ColorExtension on Color {
  String colorToHex() {
    return '#${(red << 16 | green << 8 | blue).toRadixString(16).padLeft(6, '0')}';
  }
}
