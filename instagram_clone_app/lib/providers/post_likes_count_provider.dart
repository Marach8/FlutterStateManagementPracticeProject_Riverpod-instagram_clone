import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/firebase_fields.dart';
import 'package:instagram_clone_app/typedefs.dart';

final postLikesCountProvider = StreamProvider.family.autoDispose<int, PostId> ((ref, postId){
  final controller = StreamController<int>.broadcast();
  
  //Set the default number of likes
  controller.onListen = (){controller.sink.add(0);};
  final sub = FirebaseFirestore.instance.collection(FirebaseCollectionName.likes)
    .where(FirebaseFieldName.postId, isEqualTo: postId).snapshots()
    .listen((snapshot){controller.sink.add(snapshot.docs.length);});
    
  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });
  return controller.stream;
});