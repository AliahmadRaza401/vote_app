import 'package:flutter/material.dart';


Widget text(
    {required String text,
    required double size,
    Color? color,
    boldText = "",
    TextOverflow? overflow,
    fontFamily = "",
    maxLines = 9}) {
  return Text(
    text,
    overflow: overflow,
    style: TextStyle(
        color: color ?? Colors.black,
        fontSize: size,
        fontWeight: boldText == "" ? FontWeight.normal : boldText,
        fontFamily: fontFamily == "" ? 'PlusJakartaSans-Regular' : fontFamily,
        decoration: TextDecoration.none),
    maxLines: maxLines,
  );
}