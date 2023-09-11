import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final bool isItalic;
  final bool isBold;
  final bool isLongText;

  TextWidget({
    required this.text,
    required this.fontSize,
    this.isLongText = false,
    this.isItalic = false,
    this.isBold = true
  }) : assert(text.isNotEmpty == true),
       assert(!fontSize.isNegative == true);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: TextStyle(
        height: isLongText ? 2 : null,
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        fontSize: fontSize
      ),
    );
  }
}