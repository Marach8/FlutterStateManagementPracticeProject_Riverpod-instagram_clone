import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/posts/posts.dart';
import 'package:instagram_clone_app/providers/user_info_model_provider.dart';
import 'package:instagram_clone_app/views/rich_text/comments_rich_text_view.dart';
import 'package:instagram_clone_app/views/lottie_animation/lottie_subviews.dart';


class PostDisplayNameAndMessageView extends ConsumerWidget {
  final Post post;
  const PostDisplayNameAndMessageView({required this.post, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfoModel = ref.watch(userInfoModelProvider(post.userId));
    return userInfoModel.when(
      data: (userInfo) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: RichTwoPartsText(leftPart: userInfo.displayName, rightPart:post.message),
      ), 
      error: (_, __) => const SmallErrorAnimationView(),
      loading: () => const Center(child: CircularProgressIndicator())
    );
  }
}