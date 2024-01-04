import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/providers/user_posts_provider.dart';
import 'package:instagram_clone_app/views/lottie_animation/lottie_subviews.dart';
import 'package:instagram_clone_app/views/thumbnails/post_thumbnail_view.dart';

class UserPostsView extends ConsumerWidget {
  const UserPostsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(userPostProvider);
    return RefreshIndicator(
      onRefresh: (){
        final refreshedProvider = ref.refresh(userPostProvider);
        return Future.delayed(const Duration(seconds: 1));
      },
      child: posts.when(
        data: (data){
          if(data.isEmpty){return const EmptyContentAnimationViewWithText(text: 'You currently have no posts');}
          else{return PostThumbnailGridView(posts: data);}
        },
        error: (_, __) => const ErrorAnimationView(),
        loading: () => const LoadingAnimationView()
      )
    );
  }
}