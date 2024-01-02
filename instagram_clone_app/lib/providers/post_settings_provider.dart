import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/enums_and_extensions/enums.dart';
import 'package:instagram_clone_app/notifiers/posts_settings_notifier.dart';

final postSettingsProvider = StateNotifierProvider<PostSettingsNotifier, Map<PostSettings, bool>>(
  (_) => PostSettingsNotifier()
);