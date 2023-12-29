import 'package:flutter/material.dart';
import 'package:instagram_clone_app/views/lottie_animation/lottie_animation.dart';
import 'package:lottie/lottie.dart';

class LottieAnimationView extends StatelessWidget {
  final LottieAnimation animation;
  final bool repeat, reverse;
  const LottieAnimationView({
    required this.animation, this.repeat = true, this.reverse = false, super.key
  });

  @override
  Widget build(BuildContext context) => Lottie.asset(
    animation.getFullPath,
    reverse: reverse,
    repeat: repeat
  );
}


extension GetFullPath on LottieAnimation{
  String get getFullPath => 'assets/animations/$name.json';
}