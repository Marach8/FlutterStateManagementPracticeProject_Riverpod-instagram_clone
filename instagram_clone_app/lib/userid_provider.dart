import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/auth_state_provider.dart';

final userIdProvider = Provider((ref) => ref.watch(authStateProvider).id);