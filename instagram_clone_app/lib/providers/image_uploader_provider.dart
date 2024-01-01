import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/images/image_upload_notifier.dart';
import 'package:instagram_clone_app/typedefs.dart';

final imageUploadProvider = StateNotifierProvider<ImageUploadNotifier, IsLoading>((_)
  => ImageUploadNotifier());
