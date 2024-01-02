import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/firebase_fields.dart';
import 'package:instagram_clone_app/typedefs.dart';

class DeleteCommentStateNotifier extends StateNotifier<IsLoading>{
  DeleteCommentStateNotifier(): super(false);

  set isLoading(bool value) => state = value;
  Future<bool> deleteComment(CommentId commentId) async{
    try{
      isLoading = true;
      await FirebaseFirestore.instance.collection(FirebaseCollectionName.comments)
        .where(FieldPath.documentId, isEqualTo: commentId).limit(1).get()
        .then((query) async{
          for (final doc in query.docs){await doc.reference.delete();}
        });
      return true;
    } 
    catch(_){
      return false;
    }
    finally{
      isLoading = false;
    }
  }
}