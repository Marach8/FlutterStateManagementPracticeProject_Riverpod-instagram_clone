import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/providers/post_likes_count_provider.dart';
import 'package:instagram_clone_app/typedefs.dart';
import 'package:instagram_clone_app/views/lottie_animation/lottie_subviews.dart';
import 'dart:developer' as marach show log;

class LikesCountView extends ConsumerWidget {
  final PostId postId;
  const LikesCountView({required this.postId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likesCount = ref.watch(postLikesCountProvider(postId));
    return likesCount.when(
      data: (likesCount) => Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(
          likesCount == 1 ? '$likesCount person liked this'
          : '$likesCount people liked this',
          style: const TextStyle(color: Colors.white38)
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, trace) {
        marach.log(error.toString()); 
        marach.log('SPaCE'); marach.log(trace.toString());
        return const SmallErrorAnimationView();} 
    );
  }
}