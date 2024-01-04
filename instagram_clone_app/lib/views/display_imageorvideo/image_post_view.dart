import 'package:flutter/material.dart';
import 'package:instagram_clone_app/posts/posts.dart';

class PostImageView extends StatelessWidget {
  final Post post;
  const PostImageView({required this.post, super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: post.aspectRatio,
      child: Image.network(
        post.fileUrl,
        loadingBuilder: (context, child, loadingIndicator){
          if(loadingIndicator == null) return child;
          return const Center(child: CircularProgressIndicator());
        }
      ),
    );
  }
}