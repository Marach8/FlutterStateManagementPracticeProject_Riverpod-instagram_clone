import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/comments/comments_tile.dart';
import 'package:instagram_clone_app/comments/post_comments_request.dart';
import 'package:instagram_clone_app/providers/post_comments_provider.dart';
import 'package:instagram_clone_app/providers/upload_comment_provider.dart';
import 'package:instagram_clone_app/providers/userid_provider.dart';
import 'package:instagram_clone_app/typedefs.dart';
import 'package:instagram_clone_app/views/lottie_animation/lottie_subviews.dart';

class PostCommentsView extends HookConsumerWidget {
  final PostId postId;
  const PostCommentsView({required this.postId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentController = useTextEditingController();
    final hasText = useState(false);
    final request = useState(RequestForPostAndComment(postId: postId));
    final comments = ref.watch(postCommentProvider(request.value));
    useEffect((){
      commentController.addListener((){
        hasText.value = commentController.text.isNotEmpty;
      });
      return (){};
    }, [commentController]);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
        actions: [
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: hasText.value ? () async{
              final userId = ref.read(userIdProvider);
              if(userId == null){return;}
              final isUploaded = await ref.read(uploadCommentProvider.notifier).uploadComment(
                postId, userId, commentController.text
              );
              if(isUploaded){
                commentController.clear();
                //dismissKeyboard();
              }
            }: null
          )
        ],
      ),
      body: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 4,
              child: comments.when(
                data:(comments) {
                  if(comments.isEmpty){
                    return const SingleChildScrollView(
                      child: EmptyContentAnimationViewWithText(text: 'No comments yet')
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: (){
                      final newPostPostCommentProvider = ref.refresh(postCommentProvider(request.value));
                      return Future.delayed(const Duration(seconds: 1));
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: comments.length,
                      itemBuilder: (_, index){
                        final comment = comments.elementAt(index);
                        return CommentTile(comment: comment);
                      }
                    ),
                  );
                },
                loading: () => const LoadingAnimationView(),
                error: (_, __) => const ErrorAnimationView()
              )
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: TextField(
                    controller: commentController,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (comment) async{
                      if(comment.isNotEmpty) {
                        final userId = ref.read(userIdProvider);
                        if(userId == null){return;}
                        final isUploaded = await ref.read(uploadCommentProvider.notifier).uploadComment(
                          postId, userId, commentController.text
                        );
                        if(isUploaded){
                          commentController.clear();
                          //dismissKeyboard();
                        }
                      }
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Write your comments here.')
                    ),
                    style: const TextStyle(color: Colors.white70)
                  ),
                )
              )
            )
          ]
        )
      )
    );
  }
}