import 'package:flutter/material.dart';

@immutable 
class FirebaseFieldName{
  static const userId = 'uid';
  static const postId = 'post_id'; 
  static const comment = 'comment';
  static const createdAt = 'created_at';
  static const date = 'date';
  static const displayName = 'display_name';
  static const email = 'email';
  const FirebaseFieldName._();
}


@immutable 
class FirebaseCollectionName{
  static const thumbnails = 'thumbnails';
  static const posts = 'posts'; 
  static const comments = 'comments';
  static const likes = 'likes';
  static const users = 'users';
  const FirebaseCollectionName._();
}