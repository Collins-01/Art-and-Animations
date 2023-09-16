// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math' show pi;

import 'package:flutter/material.dart';

class CircularIndicator extends StatefulWidget {
  const CircularIndicator({super.key});

  @override
  State<CircularIndicator> createState() => _CircularIndicatorState();
}

class _CircularIndicatorState extends State<CircularIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _isCompleted = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _controller.forward();
    _controller.addListener(() {
      if (_controller.isCompleted) {
        setState(() {
          _isCompleted = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Stack(
        children: [
          AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                print(_controller.value);
                return CustomPaint(
                  size: const Size(200, 200),
                  painter: MyPainter(
                    defaultColor: Colors.grey,
                    fillColor: Colors.green,
                    progress: _controller.value,
                  ),
                );
              }),
          Positioned.fill(
            child: Icon(
              Icons.check,
              color: _isCompleted ? Colors.green : Colors.grey,
              size: 68.0,
            ),
          )
        ],
      )),
    );
  }
}

class MyPainter extends CustomPainter {
  final double progress;
  final Color defaultColor;
  final Color fillColor;
  MyPainter({
    required this.progress,
    required this.defaultColor,
    required this.fillColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = size.width / 15.0; //* size of the stroke
    final circleCenter =
        Offset(size.width / 2, size.height / 2); //* the center of the circle
    final circleRadius = (size.width) /
        2; //* radius of the circle = diameter/2, and diameter = size.width ...

    final paint = Paint()
      ..color = defaultColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    /*
    2pi radians = full ciircle (360)
    */
    canvas.drawCircle(circleCenter, circleRadius, paint);
    final arcPaint = Paint()
      ..color = fillColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    //* The Arc will move from -90 to 40% of the entire circle
    canvas.drawArc(
      Rect.fromCircle(center: circleCenter, radius: circleRadius),
      (-pi / 2),
      (2 *
          pi *
          progress), //* sweep angle i.e where the arc should end. It's 40% of the circle here
      false,
      arcPaint,
    );
  }

  @override
  bool shouldRepaint(covariant MyPainter oldDelegate) {
    // throw UnimplementedError();
    return oldDelegate.progress != progress;
  }
}
