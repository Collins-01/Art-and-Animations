// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

const imageUrl =
    "https://images.unsplash.com/photo-1541647249291-71c1d98ce84f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1976&q=80";

final List<String> stories = [
  imageUrl,
];

class SocialStories extends StatefulWidget {
  const SocialStories({super.key});

  @override
  State<SocialStories> createState() => _SocialStoriesState();
}

class _SocialStoriesState extends State<SocialStories>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTapDown: (details) {
                print("OnTapDown: ${details.globalPosition}");
                if (_animationController.isAnimating) {
                  _animationController.stop();
                }
              },
              onTapUp: (details) {
                print("OnTapUp: ${details.globalPosition}");
                if (!_animationController.isAnimating) {
                  _animationController.forward();
                }
              },
              onTapCancel: () {
                print("OnTapCancel");
                if (!_animationController.isDismissed) {
                  _animationController.forward();
                }
              },
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          //User Details
          Positioned(
            top: MediaQuery.of(context).size.height * 0.08,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                children: [
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return CustomPaint(
                        size: Size(
                          MediaQuery.of(context).size.width,
                          0,
                        ),
                        painter: StoryIndicatorPainter(
                          defaultColor: Colors.grey,
                          indicatorColor: Colors.white,
                          progress: _animationController.value,
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.green,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Katarina Rostova",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        "6h",
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    )
        // Center(
        // child: AnimatedBuilder(
        //   animation: _animationController,
        //   builder: (context, child) {
        //     return CustomPaint(
        //       size: Size(MediaQuery.of(context).size.width, 100),
        //       painter: StoryIndicatorPainter(
        //         defaultColor: Colors.grey,
        //         indicatorColor: Colors.white,
        //         progress: _animationController.value,
        //       ),
        //     );
        //   },
        // ),
        // ),
        );
  }
}

class StoryIndicatorPainter extends CustomPainter {
  final double progress;
  final Color defaultColor;
  final Color indicatorColor;
  StoryIndicatorPainter({
    required this.progress,
    required this.indicatorColor,
    required this.defaultColor,
  });
  @override
  void paint(Canvas canvas, Size size) {
    const double strokeWidth = 4.0;
    final Paint paint = Paint()
      ..color = defaultColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    const Offset begin = Offset(0, 0);
    Offset end = Offset(size.width, 0);
    canvas.drawLine(begin, end, paint);
    final Paint indicatorPaint = Paint()
      ..color = indicatorColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    canvas.drawLine(begin, Offset(size.width * progress, 0), indicatorPaint);
  }

  @override
  bool shouldRepaint(covariant StoryIndicatorPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
