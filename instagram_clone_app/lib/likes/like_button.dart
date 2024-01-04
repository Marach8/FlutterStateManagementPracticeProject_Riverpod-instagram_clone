import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/likes/likes_dislike_request.dart';
import 'package:instagram_clone_app/providers/like_dislike_post_provider.dart';
import 'package:instagram_clone_app/providers/did_like_post_provider.dart';
import 'package:instagram_clone_app/providers/userid_provider.dart';
import 'package:instagram_clone_app/typedefs.dart';
import 'package:instagram_clone_app/views/lottie_animation/lottie_subviews.dart';

class LikeButton extends ConsumerWidget {
  final PostId postId;
  const LikeButton({required this.postId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasLiked = ref.watch(hasLikedPostProvider(postId));

    return hasLiked.when(
      data: (hasLiked) => IconButton(
        color: Colors.white70,
        icon: Icon(hasLiked? Icons.favorite_rounded : Icons.favorite_outline_rounded),
        onPressed: (){
          final userId = ref.read(userIdProvider);
          if(userId == null){return;}
          final likeRequest = LikesDislikesRequest(postId: postId, likedBy: userId);
          ref.read(likeDislikePostProvider(likeRequest));
        }
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const SmallErrorAnimationView()
    );
  }
}