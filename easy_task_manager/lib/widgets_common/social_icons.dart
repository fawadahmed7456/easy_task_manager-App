import 'package:flutter/material.dart';

import '../consts/colors.dart';

Widget socialIcons(icon) {
  return Column(
    children: [
      CircleAvatar(
        backgroundColor: whiteColor,
        radius: 20,
        child: Image.asset(
          icon,
          width: 25,
          height: 25,
        ),
      )
    ],
  );
}
