import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:instagram_clone_app/firebase_fields.dart';
import 'package:instagram_clone_app/typedefs.dart';


@immutable 
class UserInfoModel extends MapView<String, dynamic>{
  final UserId userId;
  final String displayName;
  final String? email;
  
  UserInfoModel({required this.displayName, required this.userId, required this.email}): super(
    {
      FirebaseFieldName.displayName : displayName,
      FirebaseFieldName.userId: userId,
      FirebaseFieldName.email: email
    }
  );

  UserInfoModel.fromJson({required Map<String, dynamic> json, required UserId id}): this (
    email: json[FirebaseFieldName.email],
    displayName: json[FirebaseFieldName.displayName],
    userId: id
  );

  @override 
  bool operator ==(Object other) => identical(this, other) || other is UserInfoModel && 
    userId == other.userId && runtimeType == other.runtimeType && displayName == other.displayName 
    && email == other.email;


  @override 
  int get hashCode => Object.hash(runtimeType, email, userId, displayName);
}