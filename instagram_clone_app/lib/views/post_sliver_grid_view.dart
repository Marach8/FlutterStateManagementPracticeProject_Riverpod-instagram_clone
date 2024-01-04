import 'package:flutter/material.dart';
import 'package:instagram_clone_app/posts/posts.dart';
import 'package:instagram_clone_app/views/post_details_view.dart';
import 'package:instagram_clone_app/views/thumbnails/post_thumbnail_view.dart';

class PostSliverGridView extends StatelessWidget {
  final Iterable<Post> posts;
  const PostSliverGridView({required this.posts, super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, mainAxisSpacing: 8, crossAxisSpacing: 8,
      ),
      delegate: SliverChildBuilderDelegate(
        childCount: posts.length,
        (_, index){
          final post = posts.elementAt(index);
          return PostThumbnailView(post: post, onTapped: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => PostDetailsView(post: post))
            );
          });
        }
      )
    );
  }
}