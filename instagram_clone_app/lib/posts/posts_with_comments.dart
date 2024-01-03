import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_app/comments/comment.dart';
import 'package:instagram_clone_app/posts/posts.dart';

@immutable 
class PostsWithComments{
  final Post post;
  final Iterable<Comment> comments;

  const PostsWithComments({required this.post, required this.comments});

  @override 
  bool operator ==(covariant PostsWithComments other)
    => post == other.post && const IterableEquality().equals(comments, other.comments);
    
  @override
  int get hashCode => Object.hash(post, comments);    
}