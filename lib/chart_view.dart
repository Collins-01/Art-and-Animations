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
    return const Scaffold();
  }
}

class ChartCustomPainter extends CustomPainter {
  final List<double> data;
  final double minY;
  final double maxY;
  final double percentage;
  final Color lineColor;
  ChartCustomPainter({
    required this.data,
    required this.minY,
    required this.maxY,
    required this.percentage,
    required this.lineColor,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final yAxis = maxY - minY;

    for (var i = 0; i < data.length; i++) {
      final xPosition = size.width / data.length * (i + 1);
      final yPosition = (1 - (data[i] - minY) / yAxis) * size.height;
      if (i == 0) {
      } else {
        // canvas.drawLine(xPosition, p2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant ChartCustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
