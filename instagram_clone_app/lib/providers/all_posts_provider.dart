import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/firebase_fields.dart';
import 'package:instagram_clone_app/posts/posts.dart';


final allPostsProvider = StreamProvider.autoDispose((ref){
  final controller = StreamController<Iterable<Post>>();

  final sub = FirebaseFirestore.instance.collection(FirebaseCollectionName.posts)
    .orderBy(FirebaseFieldName.createdAt, descending: true).snapshots()
    .listen((snapshot){
      final posts = snapshot.docs.map((doc) => Post(json: doc.data(), postId: doc.id));
      controller.sink.add(posts);
    });

  ref.onDispose(() {
    controller.close();
    sub.cancel();
  });

  return controller.stream;
});