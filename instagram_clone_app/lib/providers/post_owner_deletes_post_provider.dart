import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/posts/posts.dart';
import 'package:instagram_clone_app/providers/userid_provider.dart';

//Here, we generated a boolean value and we are adding it to a streamProvider
//(without using a streamcontroller) by the use of yield
final canCurrentUserDeletePostProvider = StreamProvider.family.autoDispose<bool, Post>((ref, post) async*{
  final userId = ref.watch(userIdProvider);
  yield userId == post.userId;
});