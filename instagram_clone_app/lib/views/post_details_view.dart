import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/comments/compact_comments_container.dart';
import 'package:instagram_clone_app/comments/post_comments_request.dart';
import 'package:instagram_clone_app/dialogs/dialogs.dart';
import 'package:instagram_clone_app/enums_and_extensions/enums.dart';
import 'package:instagram_clone_app/enums_and_extensions/extensions.dart';
import 'package:instagram_clone_app/likes/like_button.dart';
import 'package:instagram_clone_app/posts/posts.dart';
import 'package:instagram_clone_app/providers/delete_post_provider.dart';
import 'package:instagram_clone_app/providers/post_owner_deletes_post_provider.dart';
import 'package:instagram_clone_app/providers/specific_posts_with_commentsprovider.dart';
import 'package:instagram_clone_app/views/display_imageorvideo/image_video_post_view.dart';
import 'package:instagram_clone_app/views/display_name_and_message_view.dart';
import 'package:instagram_clone_app/views/likes_count_view.dart';
import 'package:instagram_clone_app/views/lottie_animation/lottie_subviews.dart';
import 'package:instagram_clone_app/views/post_comments_view.dart';
import 'package:instagram_clone_app/views/posts_date_view.dart';
import 'package:share_plus/share_plus.dart';

class PostDetailsView extends ConsumerStatefulWidget {
  final Post post;
  const PostDetailsView({required this.post, super.key});

  @override
  ConsumerState<PostDetailsView> createState() => _PostDetailsViewState();
}

class _PostDetailsViewState extends ConsumerState<PostDetailsView> {
  @override
  Widget build(BuildContext context) {
    final request = RequestForPostAndComment(
      postId: widget.post.postId,
      limit: 3, 
      sortByCreatedAt: true,
      dateSorting: DateSorting.oldestOnTop
    );
    final postsWithComments = ref.watch(specificPostWithCommentsProvider(request));
    final canDeletePosts = ref.watch(canCurrentUserDeletePostProvider(widget.post));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        actions: [
          postsWithComments.when(
            data: (data) => IconButton(
              icon: const Icon(Icons.share),
              onPressed: (){
                final url = data.post.fileUrl;
                Share.share(url, subject: 'Checkout this post', );
              }
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) => const SmallErrorAnimationView()
          ),
          
          if(canDeletePosts.value ?? false) 
            IconButton(
              icon: const Icon(Icons.delete_rounded),
              onPressed: () async{
                final shouldDelete = await DeletePostAlertDialog()
                  .showAlertDialog(context).then((result) => result ?? false);
                if(shouldDelete){
                  await ref.read(deletePostProvider.notifier).deletePost(post: widget.post);
                  if(mounted){Navigator.pop(context);}
                }
              }
            )
        ],
      ),

      body: postsWithComments.when(
        data: (data){
          final postId = data.post.postId;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PostImageOrVideoView(post: data.post),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    data.post.allowLikes ? LikeButton(postId: postId) : const SizedBox.shrink(),
                    data.post.allowComments ? IconButton(
                      icon: const Icon(Icons.mode_comment_outlined, color: Colors.white70),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => PostCommentsView(postId: postId))
                      ),
                    ) : const SizedBox.shrink()
                  ],
                ),
                PostDisplayNameAndMessageView(post: data.post),
                PostDateView(dateTime: data.post.createdAt),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(color: Colors.white70,),
                ),
                CompactCommentsContainer(comments: data.comments),
                data.post.allowLikes ? LikesCountView(postId: postId) : const SizedBox.shrink(),
                const Gap(100)
              ]
            )
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const SmallErrorAnimationView()
      )
    );
  }
}