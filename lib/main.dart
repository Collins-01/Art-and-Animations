import 'package:art_and_animations/hero_animations/radial_hero_animation.dart';
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
      home: RadialExpansionDemoPageA(),
    );
  }
}

_peCacheImages(BuildContext context) {
  // precacheImage(const AssetImage("assets/images/golfoyle.jpg"), context);
  precacheImage(const AssetImage("assets/images/wolf.jpeg"), context);
  precacheImage(const AssetImage("assets/images/workspace.jpeg"), context);
}
