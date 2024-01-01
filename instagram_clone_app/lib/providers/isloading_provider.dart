import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/providers/auth_state_provider.dart';
import 'package:instagram_clone_app/providers/image_uploader_provider.dart';

final isLoadingProvider = Provider((ref) {
  final authState = ref.watch(authStateProvider);
  final isUploadingImage = ref.watch(imageUploadProvider);
  
  return authState.isLoading  || isUploadingImage;
});