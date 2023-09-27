import 'package:flutter/material.dart';

class PageA extends StatelessWidget {
  const PageA({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 200,
              decoration: const BoxDecoration(
                color: Colors.green,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () => Navigator.of(context).push(
                _createRoute(),
              ),
              child: const Text("Page A"),
            )
          ],
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const PageB(),
      transitionDuration: const Duration(milliseconds: 800),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0); //beging from the bottom of the page
        const end = Offset.zero; // ends at the top of the page
        var curve = Curves.easeIn;
        var curveTween = CurveTween(curve: curve);
        final tween = Tween(begin: begin, end: end).chain(curveTween);
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}

class PageB extends StatelessWidget {
  const PageB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 200,
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Page B")
          ],
        ),
      ),
    );
  }

  // Route _createRoute() {
  //   return PageRouteBuilder(pageBuilder: (context,animation,secondaryAnimation)=>);
  // }
}
