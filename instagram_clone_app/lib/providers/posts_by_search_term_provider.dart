import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/firebase_fields.dart';
import 'package:instagram_clone_app/posts/posts.dart';
import 'package:instagram_clone_app/typedefs.dart';


final postsBySearchTermProvider = StreamProvider.family.autoDispose<Iterable<Post>, SearchTerm>((ref, searchTerm){
  final controller = StreamController<Iterable<Post>>();

  final sub = FirebaseFirestore.instance.collection(FirebaseCollectionName.posts)
    .orderBy(FirebaseFieldName.createdAt).snapshots().listen((snapshot){
      final posts = snapshot.docs.map((doc) => Post(json: doc.data(), postId: doc.id))
        .where((post) => post.message.toLowerCase().contains(searchTerm.toLowerCase()));
        controller.sink.add(posts);
    });
    
  ref.onDispose((){
    controller.close();
    sub.cancel();
  });

  return controller.stream;
});