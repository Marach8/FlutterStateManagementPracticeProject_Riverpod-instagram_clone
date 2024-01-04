import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/providers/all_posts_provider.dart';
import 'package:instagram_clone_app/views/lottie_animation/lottie_subviews.dart';
import 'package:instagram_clone_app/views/thumbnails/post_thumbnail_view.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(allPostsProvider);
    return RefreshIndicator(
      onRefresh: () {
        final refreshedProvider = ref.refresh(allPostsProvider);
        return Future.delayed(const Duration(seconds: 1));
      },
      child: posts.when(
        data: (data){
          if(data.isEmpty){
            return const EmptyContentAnimationViewWithText(text: 'You have not made a post yet');
          }
          return PostThumbnailGridView(posts: data);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const ErrorAnimationView()
      )
    );
  }
}