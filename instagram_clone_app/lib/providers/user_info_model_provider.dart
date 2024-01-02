import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/firebase_fields.dart';
import 'package:instagram_clone_app/typedefs.dart';
import 'package:instagram_clone_app/users/user_info_model.dart';

final userInfoModelProvider = StreamProvider.family.autoDispose<UserInfoModel, UserId>((ref, userId){
  final controller = StreamController<UserInfoModel>();

  final sub = FirebaseFirestore.instance.collection(FirebaseCollectionName.users)
    .where(FirebaseFieldName.userId, isEqualTo: userId).limit(1).snapshots().listen((snapshot){
      final json = snapshot.docs.first.data();
      final userInfoModel = UserInfoModel.fromJson(json: json, id: userId);
      controller.sink.add(userInfoModel);
    });

  ref.onDispose(() {
    controller.close();
    sub.cancel();
  });
  return controller.stream;
});