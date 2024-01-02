import 'dart:collection' show MapView;
import 'package:flutter/material.dart';
import 'package:instagram_clone_app/firebase_fields.dart';
import 'package:instagram_clone_app/typedefs.dart';

@immutable 
class UserInfoPayload extends MapView<String, String>{
  UserInfoPayload({
    required UserId userId, required String? displayName, required String? email
  }): super({
    FirebaseFieldName.userId: userId,
    FirebaseFieldName.displayName: displayName ?? '',
    FirebaseFieldName.email : email ?? ''
  });
}