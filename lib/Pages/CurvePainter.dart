import 'package:flutter/material.dart';

class CurvePainter extends CustomPainter {
  Color colorOne = Colors.amberAccent;

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();

    path.lineTo(size.width,  size.height *0.75);
    path.quadraticBezierTo(size.width, 0, size.width, size.height);
    // path.quadraticBezierTo(size.width*0.30, size.height*0.90, size.width*0.40, size.height*0.75);

    path.close();

    paint.color = colorOne;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}