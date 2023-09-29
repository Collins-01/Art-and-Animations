import 'package:flutter/material.dart';

class PhotoHero extends StatelessWidget {
  const PhotoHero({
    super.key,
    required this.photo,
    required this.onTap,
    required this.width,
  });

  final String photo;
  final VoidCallback onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: photo,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.asset(
              photo,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

class PhotoHeroAnimation extends StatelessWidget {
  const PhotoHeroAnimation({super.key});

  final image = "assets/images/wolf.jpeg";
  @override
  Widget build(BuildContext context) {
    const timeDilation = 5.0; // 1.0 means normal animation speed.

    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Hero Animation'),
      ),
      body: Center(
        child: PhotoHero(
          photo: image,
          width: 300.0,
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute<void>(builder: (BuildContext context) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Wolf'),
                ),
                body: Container(
                  // The blue background emphasizes that it's a new route.
                  // color: Colors.lightBlueAccent,
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.bottomRight,
                  child: PhotoHero(
                    photo: image,
                    width: 100.0,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              );
            }));
          },
        ),
      ),
    );
  }
}
