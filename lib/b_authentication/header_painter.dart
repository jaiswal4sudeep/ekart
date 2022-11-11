import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class HeaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.0007735174, size.height * 0.001984369);
    path_0.cubicTo(
        size.width * 0.0007733689,
        size.height * 0.01041676,
        size.width * 0.0007734153,
        size.height * 0.005952470,
        size.width * 0.0007734780,
        size.height * 0.01785723);
    path_0.lineTo(size.width * 0.0007734780, size.height * 0.9535714);
    path_0.lineTo(size.width * 0.02521276, size.height * 0.9698423);
    path_0.cubicTo(
        size.width * 0.05645800,
        size.height * 0.9908720,
        size.width * 0.08244408,
        size.height * 0.9992054,
        size.width * 0.1152360,
        size.height * 0.9992054);
    path_0.cubicTo(
        size.width * 0.1443155,
        size.height * 0.9992054,
        size.width * 0.1675176,
        size.height * 0.9936518,
        size.width * 0.1916476,
        size.height * 0.9797619);
    path_0.cubicTo(
        size.width * 0.2006188,
        size.height * 0.9750000,
        size.width * 0.2513527,
        size.height * 0.9369048,
        size.width * 0.3045638,
        size.height * 0.8956339);
    path_0.cubicTo(
        size.width * 0.3577726,
        size.height * 0.8543661,
        size.width * 0.4864664,
        size.height * 0.7551577,
        size.width * 0.5900998,
        size.height * 0.6746042);
    path_0.cubicTo(
        size.width * 0.9016241,
        size.height * 0.4337292,
        size.width * 0.9573086,
        size.height * 0.3904762,
        size.width * 0.9789629,
        size.height * 0.3734137);
    path_0.lineTo(size.width, size.height * 0.3571429);
    path_0.lineTo(size.width, size.height * 0.2063494);
    path_0.cubicTo(size.width, size.height * 0.05753988, size.width,
        size.height * 0.04910714, size.width, size.height * 0.03273810);
    path_0.cubicTo(size.width, size.height * 0.01934533, size.width,
        size.height * 0.01636914, size.width, size.height * 0.001984369);
    path_0.lineTo(size.width * 0.0007735174, size.height * 0.001984369);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.shader = ui.Gradient.linear(
        Offset(size.width * -4.872390, size.height * -8.035714),
        Offset(size.width * 0.7006961, size.height * 0.7857143), [
      const Color(0xff2E41CB).withOpacity(1),
      const Color(0xff587BE8).withOpacity(1)
    ], [
      0,
      1
    ]);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
