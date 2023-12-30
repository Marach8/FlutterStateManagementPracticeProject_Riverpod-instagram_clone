import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/firebase_fields.dart';
import 'package:instagram_clone_app/posts/post_key.dart';
import 'package:instagram_clone_app/posts/posts.dart';
import 'package:instagram_clone_app/providers/userid_provider.dart';

final userPostProvider = StreamProvider.autoDispose<Iterable<Post>>((ref){
  final controller = StreamController<Iterable<Post>>();
  final userId = ref.watch(userIdProvider);

  controller.onListen = () => controller.sink.add([]);
  
  final sub = FirebaseFirestore.instance.collection(FirebaseCollectionName.posts)
    .orderBy(FirebaseFieldName.createdAt, descending: true)
    .where(PostKey.userId, isEqualTo: userId).snapshots().listen((snapshot){
      final documents = snapshot.docs;
      final posts = documents.where((document) => !document.metadata.hasPendingWrites)
        .map((doc) => Post(postId: doc.id, json: doc.data()));
      controller.sink.add(posts);
    });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });

  return controller.stream;
});