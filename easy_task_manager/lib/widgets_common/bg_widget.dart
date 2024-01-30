import 'package:flutter/material.dart';

import '/consts/images.dart';

Widget bgwidget(Widget? child) {
  return Container(
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              imgBackgroundnew,
            ),
            fit: BoxFit.fill,
            opacity: 0.8)),
    child: child,
  );
}
