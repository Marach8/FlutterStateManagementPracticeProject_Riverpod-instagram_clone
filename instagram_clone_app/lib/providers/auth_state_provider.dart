import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/auth_state.dart';
import 'package:instagram_clone_app/auth_state_notifier.dart';

final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>((_) => AuthStateNotifier());