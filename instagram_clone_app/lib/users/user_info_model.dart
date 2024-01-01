import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:instagram_clone_app/firebase_fields.dart';
import 'package:instagram_clone_app/users/user_id.dart';

@immutable 
class UserInfoModel extends MapView<String, dynamic>{
  final UserId userId;
  final String displayName;
  final String? email;
  
  UserInfoModel({required this.displayName, required this.userId, this.email}): super(
    {
      FirebaseFieldName.displayName : displayName,
      FirebaseFieldName.userId: userId,
      FirebaseFieldName.email: email
    }
  );
}