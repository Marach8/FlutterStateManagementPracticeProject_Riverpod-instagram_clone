import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:instagram_clone_app/posts/posts.dart';
import 'package:instagram_clone_app/views/lottie_animation/lottie_subviews.dart';
import 'package:video_player/video_player.dart';

class PostVideoView extends HookWidget {
  final Post post;
  const PostVideoView({required this.post, super.key});

  @override
  Widget build(BuildContext context) {
    final videoController = VideoPlayerController.networkUrl(Uri.parse(post.fileUrl));
    final isVideoPlayerReady = useState(false);
    useEffect((){
      videoController.initialize().then((value){
        isVideoPlayerReady.value = true;
        videoController.setLooping(true);
        videoController.play();
      });
      return videoController.dispose;
    }, [videoController]);
    switch(isVideoPlayerReady.value){      
      case true:
        return AspectRatio(
          aspectRatio: post.aspectRatio,
          child: VideoPlayer(videoController)
        );
      case false:
        return const LoadingAnimationView();
      default: 
        //This should not be called
        return const ErrorAnimationView();
    }
  }
}