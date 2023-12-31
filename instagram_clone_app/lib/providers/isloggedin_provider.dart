import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/auth_results.dart';
import 'package:instagram_clone_app/providers/auth_state_provider.dart';

final isLoggedInProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.result == AuthResult.success;
});