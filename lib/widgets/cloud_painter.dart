import 'package:flutter/material.dart';

class CloudPainter extends CustomPainter {
  final Color cloudColor;

  CloudPainter({this.cloudColor = Colors.white});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = cloudColor
      ..style = PaintingStyle.fill;

    final Path path = Path();

    final double scaleX = size.width / 200;
    final double scaleY = size.height / 100;

    path.moveTo(10 * scaleX, 50 * scaleY);

    path.quadraticBezierTo(0 * scaleX, 30 * scaleY, 20 * scaleX, 20 * scaleY);
    path.quadraticBezierTo(40 * scaleX, 5 * scaleY, 60 * scaleX, 20 * scaleY);

    path.quadraticBezierTo(70 * scaleX, 0 * scaleY, 90 * scaleX, 10 * scaleY);
    path.quadraticBezierTo(110 * scaleX, 0 * scaleY, 130 * scaleX, 10 * scaleY);

    path.quadraticBezierTo(150 * scaleX, 0 * scaleY, 170 * scaleX, 20 * scaleY);
    path.quadraticBezierTo(190 * scaleX, 30 * scaleY, 200 * scaleX, 50 * scaleY);

    path.quadraticBezierTo(180 * scaleX, 70 * scaleY, 160 * scaleX, 80 * scaleY);
    path.quadraticBezierTo(140 * scaleX, 90 * scaleY, 120 * scaleX, 85 * scaleY);
    path.quadraticBezierTo(100 * scaleX, 95 * scaleY, 80 * scaleX, 80 * scaleY);
    path.quadraticBezierTo(60 * scaleX, 90 * scaleY, 40 * scaleX, 70 * scaleY);
    path.quadraticBezierTo(20 * scaleX, 80 * scaleY, 10 * scaleX, 50 * scaleY);

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}