import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/providers/thumbnail_provider.dart';
import 'package:instagram_clone_app/views/lottie_animation/lottie_subviews.dart';
import 'package:instagram_clone_app/views/thumbnails/thumbnail_request.dart';

class FileThumbnailView extends ConsumerWidget {
  final ThumbnailRequest thumbnailRequest;
  const FileThumbnailView({required this.thumbnailRequest, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thumbnail = ref.watch(thumbnailProvider(thumbnailRequest));
    return thumbnail.when(
      data: (data) => AspectRatio(
        aspectRatio: data.aspectRatio,
        child: data.image
      ),
      error: (__, _) => const SmallErrorAnimationView(),
      loading: () => const LoadingAnimationView()
    );
  }
}