import 'package:flutter/material.dart';

class BackGroundPainter extends CustomPainter {
  BackGroundPainter(this.context, {Key? key});
  final BuildContext context;

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();

    path.moveTo(0, size.height * 0.2);

    path.quadraticBezierTo(size.width * 0.135, size.height * 0.178,
        size.width * 0.281, size.height * 0.0889);
    path.quadraticBezierTo(
        size.width * 0.4, size.height * 0.0113, size.width * 0.8, 0);
    path.lineTo(0, 0);
    path.lineTo(0, size.width * 0.8);
    path.close();
    paint.color = Theme.of(context).primaryColor;
    canvas.drawPath(path, paint);

    // path = Path();
    // path.moveTo(0, size.height * 0.4);

    // path.quadraticBezierTo(size.width*0.4, size.height * 0.5, size.width*0.6, size.height*0.25);

    // path.quadraticBezierTo(size.width*0.7, size.height*0.15, size.width, size.height*0.1);

    // path.lineTo(0, 0);
    // paint.color = Colors.black87;
    // canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
