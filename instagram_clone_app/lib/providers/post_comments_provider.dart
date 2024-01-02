import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/comments/comment.dart';
import 'package:instagram_clone_app/comments/post_comments_request.dart';
import 'package:instagram_clone_app/enums_and_extensions/extensions.dart';
import 'package:instagram_clone_app/firebase_fields.dart';

final postCommentProvider = StreamProvider
  .family.autoDispose<Iterable<Comment>, RequestForPostAndComment>((ref, request){
    final controller = StreamController<Iterable<Comment>>();
    
    final sub = FirebaseFirestore.instance.collection(FirebaseCollectionName.comments)
      .where(FirebaseFieldName.postId, isEqualTo: request.postId).snapshots()
      .listen((snapshot){
        final documents = snapshot.docs;
        final limitedDocuments = request.limit != null ?  documents.take(request.limit!) : documents;
        final comments = limitedDocuments.where((element) => !element.metadata.hasPendingWrites)
          .map((document) => Comment(document.data(), document.id));
      final result = comments.applySorting(request);
      controller.sink.add(result);
      });
    ref.onDispose((){
      sub.cancel();
      controller.close();
    });
    return controller.stream;
  });
