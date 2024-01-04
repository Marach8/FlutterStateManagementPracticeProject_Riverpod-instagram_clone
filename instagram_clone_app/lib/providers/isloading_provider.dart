import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/providers/auth_state_provider.dart';
import 'package:instagram_clone_app/providers/delete_comment_provider.dart';
import 'package:instagram_clone_app/providers/delete_post_provider.dart';
import 'package:instagram_clone_app/providers/image_uploader_provider.dart';
import 'package:instagram_clone_app/providers/upload_comment_provider.dart';

final isLoadingProvider = Provider((ref) {
  final authState = ref.watch(authStateProvider);
  final isUploadingImage = ref.watch(imageUploadProvider);
  final isSendingComment = ref.watch(uploadCommentProvider);
  final isDeletingComment = ref.watch(deleteCommentProvider);
  final isDeletingPost = ref.watch(deletePostProvider);

  return authState.isLoading||
    isUploadingImage ||
    isSendingComment ||
    isDeletingPost ||
    isDeletingComment;
});