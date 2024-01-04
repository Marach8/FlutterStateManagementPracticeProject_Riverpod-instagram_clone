import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/comments/comment.dart';
import 'package:instagram_clone_app/providers/user_info_model_provider.dart';
import 'package:instagram_clone_app/views/rich_text/comments_rich_text_view.dart';
import 'package:instagram_clone_app/views/lottie_animation/lottie_subviews.dart';

class CompactCommentTile extends ConsumerWidget {
  final Comment comment;
  const CompactCommentTile({required this.comment, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userInfoModelProvider(comment.fromUserId));
    return userInfo.when(
      data: (userInfo){
        return RichTwoPartsText(leftPart: userInfo.displayName, rightPart: comment.comment);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const SmallErrorAnimationView()
    );
  }
}