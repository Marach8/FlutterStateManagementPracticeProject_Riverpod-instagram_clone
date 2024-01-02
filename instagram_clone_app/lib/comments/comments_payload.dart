import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_clone_app/firebase_fields.dart';
import 'package:instagram_clone_app/typedefs.dart';

@immutable 
class CommentPayload extends MapView<String, dynamic> {
  CommentPayload({
    required UserId fromUserId,
    required String comment,
    required PostId onPostId
  }): super(
    {
      FirebaseFieldName.comment: comment,
      FirebaseFieldName.userId : fromUserId,
      FirebaseFieldName.postId : onPostId,
      FirebaseFieldName.createdAt: FieldValue.serverTimestamp()
    }
  );
}