// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ChartView extends StatefulWidget {
  const ChartView({super.key});

  @override
  State<ChartView> createState() => _ChartViewState();
}

class _ChartViewState extends State<ChartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomPaint(
          painter: ChartCustomPainter(),
        ),
      ),
    );
  }
}

class ChartCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    var path = Path();
    var height = size.height / 2;
    var width = size.width / 2;
    // path.moveTo(0, height);
    // path.lineTo(width, 300);

    // canvas.drawPath(path, paint);

    final dataPoints = [
      const Offset(0, 50),
      const Offset(50, 100),
      const Offset(100, 75),
      const Offset(150, 120),
    ];

    for (int i = 0; i < dataPoints.length - 1; i++) {
      canvas.drawLine(dataPoints[i], dataPoints[i + 1], paint);
    }
  }

  @override
  bool shouldRepaint(covariant ChartCustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
