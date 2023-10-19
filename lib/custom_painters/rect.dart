import 'package:flutter/material.dart';

class RectClipper extends StatelessWidget {
  const RectClipper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomPaint(
          painter: DemoPainter(),
        ),
      ),
    );
  }
}

class DemoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 20.0;
    var center = Offset(size.width / 2, size.height / 2);
    var fromCenter = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: 100,
      height: 100,
    );
    var fromCircle = Rect.fromCircle(center: center, radius: 100);

    canvas.drawRect(
      fromCircle,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
