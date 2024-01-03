import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/comments/comment.dart';
import 'package:instagram_clone_app/comments/post_comments_request.dart';
import 'package:instagram_clone_app/enums_and_extensions/extensions.dart';
import 'package:instagram_clone_app/firebase_fields.dart';
import 'package:instagram_clone_app/posts/posts.dart';
import 'package:instagram_clone_app/posts/posts_with_comments.dart';

final specificPostWithCommentsProvider 
  = StreamProvider.family.autoDispose<PostsWithComments, RequestForPostAndComment>((ref, request){
    final controller = StreamController<PostsWithComments>();
    
    Post? post;
    Iterable<Comment>? comments;
    
    void notify(){
      final localPost = post;
      if(localPost == null){return;}
      final outputComments = (comments ?? []).applySorting(request);
      final result = PostsWithComments(post: localPost, comments: outputComments);
      controller.sink.add(result);
    }

    final postSub = FirebaseFirestore.instance.collection(FirebaseCollectionName.posts)
      .where(FieldPath.documentId, isEqualTo: request.postId)
      .limit(1).snapshots().listen((snapshot){
        if(snapshot.docs.isEmpty){
          post = null;
          comments = null;
          notify();
          return;
        }
        final doc = snapshot.docs.first;
        if(doc.metadata.hasPendingWrites){return;}
        post = Post(postId: doc.id, json: doc.data());
        notify();
      });
    //watch changes to the comments and order them
    final commentsQuery = FirebaseFirestore.instance.collection(FirebaseCollectionName.comments)
      .where(FirebaseFieldName.postId, isEqualTo: request.postId)
      .orderBy(FirebaseFieldName.createdAt, descending: true);

    final limitedCommentsQuery = request.limit != null ? commentsQuery.limit(request.limit!): commentsQuery;
    final commentsSub = limitedCommentsQuery.snapshots().listen((snapshot){
      comments = snapshot.docs.where((doc) => !doc.metadata.hasPendingWrites)
        .map((document) => Comment(document.data(), document.id)).toList();
      notify();
    });

    ref.onDispose((){
      postSub.cancel();
      commentsSub.cancel();
      controller.close();
    });
    return controller.stream;
  });
  