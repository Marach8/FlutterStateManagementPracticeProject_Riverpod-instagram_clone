import 'dart:collection' show MapView;
import 'package:flutter/material.dart';
import 'package:instagram_clone_app/firebase_fields.dart';
import 'package:instagram_clone_app/typedefs.dart';

@immutable 
class Likes extends MapView<String, String>{
  Likes({
    required PostId postId,
    required UserId likedBy, 
    required DateTime dateTime,
  }): super(
    {
      FirebaseFieldName.postId: postId,
      FirebaseFieldName.userId: likedBy,
      FirebaseFieldName.date: dateTime.toIso8601String()
    }
  );
}