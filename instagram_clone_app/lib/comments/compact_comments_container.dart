import 'package:flutter/material.dart';
import 'package:instagram_clone_app/comments/comment.dart';
import 'package:instagram_clone_app/comments/comments_tile.dart';

class CompactCommentsContainer extends StatelessWidget {
  final Iterable<Comment> comments;
  const CompactCommentsContainer({required this.comments, super.key});

  @override
  Widget build(BuildContext context) {
    if(comments.isEmpty){return const SizedBox.shrink();}
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: comments.map((comment) => CommentTile(comment: comment)).toList()
      ),
    );
  }
}