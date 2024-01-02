import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/comments/comments_payload.dart';
import 'package:instagram_clone_app/firebase_fields.dart';
import 'package:instagram_clone_app/typedefs.dart';

class UploadCommentNotifier extends StateNotifier<IsLoading>{
  UploadCommentNotifier(): super(false);

  set isLoading(bool value) => state = value;

  Future<bool> uploadComment(PostId onPostId, UserId fromUserId, String comment) async{
    isLoading = true;
    final payLoad = CommentPayload(fromUserId: fromUserId, comment: comment, onPostId: onPostId);
    try{
      await FirebaseFirestore.instance.collection(FirebaseCollectionName.comments)
        .add(payLoad);
      return true;
    } catch(_){
      return false;
    } finally {
      isLoading = false;
    }
  }
}