import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_app/firebase_fields.dart';
import 'package:instagram_clone_app/typedefs.dart';


@immutable 
class Comment{
  final CommentId commentId;
  final String comment;
  final DateTime createdAt;
  final UserId fromUserId;
  final PostId onPostId;

  Comment(Map<String, dynamic> json, this.commentId): 
    comment = json[FirebaseFieldName.comment],
    createdAt = (json[FirebaseFieldName.createdAt] as Timestamp).toDate(),
    fromUserId = json[FirebaseFieldName.userId],
    onPostId = json[FirebaseFieldName.postId];

  @override 
  bool operator ==(Object other)  => identical(this, other) || 
  other is Comment && 
  comment == other.comment && 
  commentId == other.commentId &&
  createdAt == other.createdAt &&
  fromUserId == other.fromUserId && 
  onPostId == other.onPostId;

  @override 
  int get hashCode => Object.hash(
    commentId, 
    comment,
    createdAt,
    fromUserId,
    onPostId
  );
}