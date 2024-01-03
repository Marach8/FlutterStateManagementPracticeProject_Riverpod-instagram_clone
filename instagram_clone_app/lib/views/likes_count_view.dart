import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/providers/post_likes_count_provider.dart';
import 'package:instagram_clone_app/typedefs.dart';
import 'package:instagram_clone_app/views/lottie_animation/lottie_subviews.dart';

class LikesCountView extends ConsumerWidget {
  final PostId postId;
  const LikesCountView({required this.postId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likesCount = ref.watch(postLikesCountProvider(postId));
    return likesCount.when(
      data: (likesCount) => Text(
        likesCount == 1 ? '$likesCount person liked this'
        : '$likesCount people liked this'
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const SmallErrorAnimationView()
    );
  }
}