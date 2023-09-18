// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

final List<String> stories = [
  "assets/images/workspace.jpeg",
  "assets/images/golfoyle.JPG",
  "assets/images/wolf.jpeg"
];

class SocialStories extends StatefulWidget {
  const SocialStories({super.key});

  @override
  State<SocialStories> createState() => _SocialStoriesState();
}

class _SocialStoriesState extends State<SocialStories>
    with TickerProviderStateMixin {
  late List<AnimationController> _animationControllers = [];
  @override
  void initState() {
    assert((stories.isNotEmpty));
    _animationControllers = [
      ...List.generate(
        stories.length,
        (index) => AnimationController(
          vsync: this,
          duration: const Duration(seconds: 5),
        ),
      )
    ];
    _animationControllers[0].forward();
    // _animationControllers[0].addListener(() {
    //   _handleNext();
    // });
    for (var i = 0; i < _animationControllers.length; i++) {
      _animationControllers[i].addListener(() {
        final currentController = _animationControllers[i];
        bool hasNext = (i + 1) < stories.length;
        if (currentController.isCompleted && hasNext) {
          setState(() {
            _currentAnimatingIndex++;
          });
          _animationControllers[_currentAnimatingIndex].forward();
        }
      });
    }

    super.initState();
  }

  int _currentAnimatingIndex = 0;

  _handleNext() {
    // * CHECK IF THE CURRENT CONTROLLER IS THE LAST ON THE ARRAY
    if (_animationControllers[_currentAnimatingIndex].isCompleted) {
      setState(() {
        _currentAnimatingIndex++;
      });
      _animationControllers[_currentAnimatingIndex].forward();
    }
  }

  @override
  void dispose() {
    for (var element in _animationControllers) {
      element.dispose();
    }
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
                onTapDown: (details) => _onTapDown(details),
                onTapUp: (details) => _onTapUpDetails(details),
                onTapCancel: () => _onTapCancelDetails(),
                child: IndexedStack(
                  sizing: StackFit.expand,
                  index: _currentAnimatingIndex,
                  children: [
                    ...List.generate(
                      stories.length,
                      (index) => Image.asset(
                        stories[index],
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
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
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ...List.generate(
                          stories.length,
                          (index) => Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              child: AnimatedBuilder(
                                animation: _animationControllers[index],
                                builder: (context, child) {
                                  return CustomPaint(
                                    size: Size(
                                      MediaQuery.of(context).size.width,
                                      0,
                                    ),
                                    painter: StoryIndicatorPainter(
                                      defaultColor: Colors.grey,
                                      indicatorColor: Colors.white,
                                      progress:
                                          _animationControllers[index].value,
                                      length: stories.length,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        )
                      ],
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
      ),
    );
  }

  _onTapCancelDetails() {
    print("OnTapCancel");
    if (!_animationControllers[_currentAnimatingIndex].isDismissed) {
      _animationControllers[_currentAnimatingIndex].forward();
    }
  }

  _onTapDown(TapDownDetails details) {
    print("OnTapDown: ${details.globalPosition}");
    final width = MediaQuery.of(context).size.width;
    final dx = details.localPosition.dx;
    // * CHECK DIRECTION [LEFT OR RIGHT]
    // * LEFT
    if (dx >= 0 && dx <= (width / 2)) {
      if (_currentAnimatingIndex == 0) return;
      _animationControllers[_currentAnimatingIndex].reset();
      setState(() {
        _currentAnimatingIndex--;
      });
      _animationControllers[_currentAnimatingIndex].forward();
    }
    // * RIGHT
    if (dx >= (width / 2) && dx <= width) {
      // * Check if there is a next story to show from this list
      bool hasNext = (_currentAnimatingIndex + 1) < stories.length;
      if (hasNext) {
        // * Stop the current animation
        _animationControllers[_currentAnimatingIndex].reset();
        setState(() {
          _currentAnimatingIndex++;
        });
        print("Increased animating index...$_currentAnimatingIndex");
        _animationControllers[_currentAnimatingIndex].forward();
      } else {
        return;
      }
    }
    // if (_animationControllers[_currentAnimatingIndex].isAnimating) {
    //   _animationControllers[_currentAnimatingIndex].stop();
    // }
  }

  _onTapUpDetails(TapUpDetails details) {
    print("OnTapUp: ${details.globalPosition}");
    if (!_animationControllers[_currentAnimatingIndex].isAnimating) {
      _animationControllers[_currentAnimatingIndex].forward();
    }
  }
}

class StoryIndicatorPainter extends CustomPainter {
  final double progress;
  final Color defaultColor;
  final Color indicatorColor;
  final int length;
  StoryIndicatorPainter({
    required this.progress,
    required this.indicatorColor,
    required this.defaultColor,
    required this.length,
  });
  @override
  void paint(Canvas canvas, Size size) {
    const double strokeWidth = 4.0;
    final availableWidth = (size.width);
    final Paint paint = Paint()
      ..color = defaultColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    const Offset begin = Offset(0, 0);
    Offset end = Offset(availableWidth, 0);
    canvas.drawLine(begin, end, paint);
    final Paint indicatorPaint = Paint()
      ..color = indicatorColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
        begin, Offset(availableWidth * progress, 0), indicatorPaint);
  }

  @override
  bool shouldRepaint(covariant StoryIndicatorPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class CustomPageTransition extends PageRouteBuilder {
  final Widget page;

  CustomPageTransition({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0); // Start off-screen to the right
            const end = Offset(0.0, 0.0); // End at the center of the screen
            const curve = Curves.easeInOut;

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
}
