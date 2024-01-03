import 'package:flutter/material.dart';
import 'package:instagram_clone_app/enums_and_extensions/enums.dart';
import 'package:instagram_clone_app/posts/posts.dart';
import 'package:instagram_clone_app/views/display_imageorvideo/image_post_view.dart';
import 'package:instagram_clone_app/views/display_imageorvideo/video_post_view.dart';

class PostImageOrVideoView extends StatelessWidget {
  final Post post;
  const PostImageOrVideoView({required this.post, super.key});

  @override
  Widget build(BuildContext context) {
    switch(post.fileType){      
      case FileType.image:
        return PostImageView(post: post);
      case FileType.video:
        return PostVideoView(post: post);
      default: 
        return const SizedBox.shrink();
    }
  }
}