import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shinchoku/features/tasks_lists/utils/appbar_constants.dart';

class AppbarWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    final double angle = (AppbarConstants.appbarMaxHeight - size.height) / 3.2;

    ///  draw rounded corner at the start
    path.lineTo(0, size.height - angle);
    path.quadraticBezierTo(0, size.height, angle, size.height);

    /// stop drawing the curve when the current height is less than
    /// (max - curve [30]) then the control point will be at the current height
    final double breakPoint = min(
        AppbarConstants.appbarMaxHeight - AppbarConstants.appbarCurve,
        size.height);
    final centerControlPoint = Offset(size.width / 2, breakPoint);

    path.quadraticBezierTo(
      centerControlPoint.dx,
      centerControlPoint.dy,
      size.width - angle,
      size.height,
    );
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - angle);
    path.lineTo(size.width, 0.0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return oldClipper != this;
  }
}
