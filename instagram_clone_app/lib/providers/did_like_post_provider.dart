import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/firebase_fields.dart';
import 'package:instagram_clone_app/providers/userid_provider.dart';
import 'package:instagram_clone_app/typedefs.dart';

final hasLikedPostProvider = StreamProvider.family.autoDispose<bool, PostId>((ref, postId) {
  final userId = ref.watch(userIdProvider);
  if(userId == null){return Stream<bool>.value(false);}

  final controller = StreamController<bool>();

  final sub = FirebaseFirestore.instance.collection(FirebaseCollectionName.likes)
    .where(FirebaseFieldName.postId, isEqualTo: postId)
    .where(FirebaseFieldName.userId, isEqualTo: userId).snapshots()
    .listen((snapshot) {
      snapshot.docs.isNotEmpty ? controller.sink.add(true): controller.sink.add(false);
    });

  ref.onDispose((){
    sub.cancel();
    controller.close();
  });

  return controller.stream;
});
