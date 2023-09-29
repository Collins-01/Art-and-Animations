// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math' show sqrt2;

import 'package:flutter/material.dart';

const double kMinRadius = 32.0;
const double kMaxRadius = 128.0;
RectTween _createRectTween(Rect? begin, Rect? end) {
  return MaterialRectCenterArcTween(begin: begin, end: end);
}

class Photo extends StatelessWidget {
  const Photo({
    super.key,
    required this.photo,
    // required this.color,
    required this.onTap,
  });

  final String photo;
  // final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      // Slightly opaque color appears where the image has transparency.
      color: Theme.of(context).primaryColor.withOpacity(0.25),
      child: InkWell(
          onTap: onTap,
          child: Image.asset(
            photo,
            fit: BoxFit.cover,
          )),
    );
  }
}

class RadialExpansion extends StatelessWidget {
  const RadialExpansion({
    super.key,
    required this.maxRadius,
    this.child,
  }) : clipRectSize = 2.0 * (maxRadius / sqrt2);

  final double maxRadius;
  final double clipRectSize;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Center(
        child: SizedBox(
          width: clipRectSize,
          height: clipRectSize,
          child: ClipRect(
            child: child,
          ),
        ),
      ),
    );
  }
}

class RadialExpansionDemoPageA extends StatelessWidget {
  const RadialExpansionDemoPageA({super.key});

  static double kMinRadius = 32.0;
  static double kMaxRadius = 128.0;
  static Interval opacityCurve =
      const Interval(0.0, 0.75, curve: Curves.fastOutSlowIn);

  Widget _buildHero(
      BuildContext context, String imageName, String description) {
    return SizedBox(
      width: kMinRadius * 2.0,
      height: kMinRadius * 2.0,
      child: Hero(
        createRectTween: _createRectTween,
        tag: imageName,
        child: RadialExpansion(
          maxRadius: kMaxRadius,
          child: Photo(
            photo: imageName,
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder<void>(
                  transitionDuration: const Duration(milliseconds: 500),
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return AnimatedBuilder(
                      animation: animation,
                      builder: (context, child) {
                        return Opacity(
                          opacity: opacityCurve.transform(animation.value),
                          child: RadialExpansionDemoPageB(
                            description: description,
                            imageName: imageName,
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radial Transition Demo'),
      ),
      body: Container(
        padding: const EdgeInsets.all(32),
        alignment: FractionalOffset.bottomLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildHero(context, 'assets/images/wolf.jpeg', 'Wolf'),
            _buildHero(context, 'assets/images/workspace.jpeg', 'Workspace'),
            // _buildHero(context, 'images/beachball-alpha.png', 'Beach ball'),
          ],
        ),
      ),
    );
  }
}

class RadialExpansionDemoPageB extends StatelessWidget {
  final String imageName;
  final String description;
  const RadialExpansionDemoPageB({
    Key? key,
    required this.imageName,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).canvasColor,
        child: Center(
          child: Card(
            elevation: 8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: kMaxRadius * 2.0,
                  height: kMaxRadius * 2.0,
                  child: Hero(
                    createRectTween: _createRectTween,
                    tag: imageName,
                    child: RadialExpansion(
                      maxRadius: kMaxRadius,
                      child: Photo(
                        photo: imageName,
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textScaleFactor: 3,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
