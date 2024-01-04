import 'package:flutter/material.dart';
import 'package:instagram_clone_app/posts/posts.dart';
import 'package:instagram_clone_app/views/post_details_view.dart';

class PostThumbnailView extends StatelessWidget {
  final Post post;
  final VoidCallback onTapped;
  const PostThumbnailView({required this.post, required this.onTapped, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapped,
      child: Image.network(post.thumbnailUrl, fit: BoxFit.cover)
    );
  }
}

class PostThumbnailGridView extends StatelessWidget {
  final Iterable<Post> posts;
  const PostThumbnailGridView({required this.posts, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, mainAxisSpacing: 8, crossAxisSpacing: 8,
        ),
        itemCount: posts.length,
        itemBuilder: (_, index){
          final post = posts.elementAt(index);
          return PostThumbnailView(post: post, onTapped: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => PostDetailsView(post: post))
            );
          });
        }
      ),
    );
  }
}