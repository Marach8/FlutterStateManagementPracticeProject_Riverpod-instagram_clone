import 'dart:collection';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/enums_and_extensions/enums.dart';

class PostSettingsNotifier extends StateNotifier<Map<PostSettings, bool>>{
  PostSettingsNotifier(): super(
    UnmodifiableMapView({
      for (final setting in PostSettings.values) setting: true
    })
  );

  void setPostSetting(PostSettings setting, bool value){
    final existingValue = state[setting];
    if(existingValue == null || existingValue == value){return;}
    state = Map.unmodifiable(Map.from(state)..[setting] = value);
  }
}