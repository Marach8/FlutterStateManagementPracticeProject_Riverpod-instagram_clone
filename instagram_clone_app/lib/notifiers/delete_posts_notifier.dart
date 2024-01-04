import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/enums_and_extensions/extensions.dart';
import 'package:instagram_clone_app/firebase_fields.dart';
import 'package:instagram_clone_app/posts/posts.dart';
import 'package:instagram_clone_app/typedefs.dart';

class DeletePostStateNotifier extends StateNotifier<IsLoading>{
  DeletePostStateNotifier():super(false);

  set isLoading(bool value) => state = value;

  Future<bool> deletePost({required Post post}) async{
    isLoading = true;
    try{
      await FirebaseStorage.instance.ref().child(post.userId).child(FirebaseCollectionName.thumbnails)
        .child(post.thumbnailStorageId).delete();

      await FirebaseStorage.instance.ref().child(post.userId).child(post.fileType.collectionName)
        .child(post.originalFileStorageId).delete();

      await _deleteAllDocuments(postId: post.postId, inCollection: FirebaseCollectionName.comments);

      await _deleteAllDocuments(postId: post.postId, inCollection: FirebaseCollectionName.likes);

      final postsInCollection = await FirebaseFirestore.instance.collection(FirebaseCollectionName.posts)
        .where(FieldPath.documentId, isEqualTo: post.postId).limit(1).get();
      for (final doc in postsInCollection.docs){await doc.reference.delete();}
      return true;
    } catch (_){
      return false;
    } finally{
      isLoading = false;
    }
  }


  Future<void> _deleteAllDocuments({required PostId postId, required String inCollection}){
    return FirebaseFirestore.instance.runTransaction(
      maxAttempts: 3,
      timeout: const Duration(seconds: 20),
      (transaction) async {
        final query = await FirebaseFirestore.instance.collection(inCollection)
          .where(FirebaseFieldName.postId, isEqualTo: postId).get();
        for(final doc in query.docs){transaction.delete(doc.reference);}
      }
    );
  }

}