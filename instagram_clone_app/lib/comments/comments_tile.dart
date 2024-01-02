import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/comments/comment.dart';
import 'package:instagram_clone_app/dialogs/dialogs.dart';
import 'package:instagram_clone_app/enums_and_extensions/extensions.dart';
import 'package:instagram_clone_app/providers/delete_comment_provider.dart';
import 'package:instagram_clone_app/providers/user_info_model_provider.dart';
import 'package:instagram_clone_app/providers/userid_provider.dart';
import 'package:instagram_clone_app/views/lottie_animation/lottie_subviews.dart';

class CommentTile extends ConsumerWidget {
  final Comment comment;
  const CommentTile({required this.comment, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userInfoModelProvider(comment.fromUserId));
    return userInfo.when(
      data: (userInfo){
        final currentUserId = ref.read(userIdProvider);
        return ListTile(
          title: Text(userInfo.displayName, style: const TextStyle(color: Colors.white70),),
          subtitle: Text(
            comment.comment,
            style: const TextStyle(overflow: TextOverflow.ellipsis, color: Colors.white54)
          ),
          trailing: currentUserId == comment.fromUserId ? IconButton(
            icon: const Icon(Icons.delete_rounded),
            onPressed: () async{
              await DeleteCommentAlertDialog().showAlertDialog(context).then((value) async{
                value == true ? await ref.read(deleteCommentProvider.notifier).deleteComment(comment.commentId):{};
              });
            }
          ): null
        );
      },
      loading: () => const CircularProgressIndicator.adaptive(),
      error: (_, __) => const SmallErrorAnimationView(),
    );
  }
}