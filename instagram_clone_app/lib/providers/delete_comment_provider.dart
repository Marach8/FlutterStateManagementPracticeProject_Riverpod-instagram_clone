import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/notifiers/delete_comments_notifier.dart';
import 'package:instagram_clone_app/typedefs.dart';

final deleteCommentProvider = StateNotifierProvider<DeleteCommentStateNotifier, IsLoading>((_)
=> DeleteCommentStateNotifier());