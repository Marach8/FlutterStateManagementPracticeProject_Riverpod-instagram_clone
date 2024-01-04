import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/providers/posts_by_search_term_provider.dart';
import 'package:instagram_clone_app/views/lottie_animation/lottie_subviews.dart';
import 'package:instagram_clone_app/views/thumbnails/post_thumbnail_view.dart';

class SearchResultView extends ConsumerWidget {
  final String searchTerm;
  const SearchResultView({required this.searchTerm, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if(searchTerm.isEmpty){
      return const EmptyContentAnimationViewWithText(text: 'Enter a search term above');
    }
    final posts = ref.watch(postsBySearchTermProvider(searchTerm));
    return posts.when(
      data: (data){
        if(data.isEmpty){return const DataNotFoundAnimationView();}
        else{return PostThumbnailGridView(posts: data);}
      },
      loading: () => const LoadingAnimationView(),
      error: (_, __) => const ErrorAnimationView()
    );
  }
}