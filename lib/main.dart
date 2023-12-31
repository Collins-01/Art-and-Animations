import 'package:art_and_animations/chart_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    _peCacheImages(context);
    return const MaterialApp(
      home: ChartView(),
    );
  }
}

_peCacheImages(BuildContext context) {
  precacheImage(const AssetImage("assets/images/golfoyle.JPG"), context);
  precacheImage(const AssetImage("assets/images/wolf.jpeg"), context);
  precacheImage(const AssetImage("assets/images/workspace.jpeg"), context);
}
