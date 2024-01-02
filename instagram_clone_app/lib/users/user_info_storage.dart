import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_app/firebase_fields.dart';
import 'package:instagram_clone_app/typedefs.dart';
import 'package:instagram_clone_app/users/user_info_payload.dart';

@immutable 
class UserInfoStorage{
  const UserInfoStorage();

  Future<bool> saveUserInfo ({
    required UserId userId, required String displayName, required String? email
  }) async{
    try{
      final userInfo = await FirebaseFirestore.instance.collection(FirebaseCollectionName.users)
        .where(FirebaseFieldName.userId, isEqualTo: userId).limit(1).get();
      //Check if user already exists and update it
      if(userInfo.docs.isNotEmpty){
        await userInfo.docs.first.reference.update(
          {
            FirebaseFieldName.displayName: displayName, 
            FirebaseFieldName.email: email ?? ''
          }
        ); 
        return true;
      }
      //User does not exist, so create and add it.
      final payload = UserInfoPayload(userId: userId, displayName: displayName, email: email);
      await FirebaseFirestore.instance.collection(FirebaseCollectionName.users).add(payload);
      return true;
    } catch (_){return false;}
  }
}