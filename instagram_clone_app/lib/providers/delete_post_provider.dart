import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/notifiers/delete_posts_notifier.dart';
import 'package:instagram_clone_app/typedefs.dart';

final deletePostProvider = StateNotifierProvider<DeletePostStateNotifier, IsLoading>((_)
  => DeletePostStateNotifier());