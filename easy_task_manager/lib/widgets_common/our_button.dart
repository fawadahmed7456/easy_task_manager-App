import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget ourButton(onPress, color, textColor, String title) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
      onPressed: onPress,
      child: title.text.color(textColor).size(18).bold.make());
}
