import 'package:flutter/material.dart';
import 'package:instagram_clone_app/views/lottie_animation/lottie_animation.dart';
import 'package:instagram_clone_app/views/lottie_animation/lottie_animation_view.dart';

class EmptyContentAnimationViewWithText extends StatelessWidget {
  final String text;
  const EmptyContentAnimationViewWithText({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              text, 
              style: const TextStyle(
                fontSize: 20, color: Colors.white54
              )
            ),
          ),
          const EmptyContentAnimationView()
        ]
      ),
    );
  }
}



class DataNotFoundAnimationView extends LottieAnimationView{
  const DataNotFoundAnimationView({super.key}): super(animation: LottieAnimation.dataNotFound);
}

class EmptyContentAnimationView extends LottieAnimationView{
  const EmptyContentAnimationView({super.key}): super(animation: LottieAnimation.empty);
}

class ErrorAnimationView extends LottieAnimationView{
  const ErrorAnimationView({super.key}): super(animation: LottieAnimation.error);
}

class LoadingAnimationView extends LottieAnimationView{
  const LoadingAnimationView({super.key}): super(animation: LottieAnimation.loading);
}

class SmallErrorAnimationView extends LottieAnimationView{
  const SmallErrorAnimationView({super.key}): super(animation: LottieAnimation.smallError);
}


