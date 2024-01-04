import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/enums_and_extensions/enums.dart';
import 'package:instagram_clone_app/providers/image_uploader_provider.dart';
import 'package:instagram_clone_app/providers/post_settings_provider.dart';
import 'package:instagram_clone_app/providers/userid_provider.dart';
import 'package:instagram_clone_app/views/thumbnails/file_thumbnail_view.dart';
import 'package:instagram_clone_app/views/thumbnails/thumbnail_request.dart';


class CreateNewPostView extends StatefulHookConsumerWidget{
  final File fileToPost;
  final FileType fileType;
  const CreateNewPostView({required this.fileToPost, required this.fileType, super.key});

  @override 
  ConsumerState<ConsumerStatefulWidget> createState() => Marach();
}

class Marach extends ConsumerState<CreateNewPostView>{
  @override 
  Widget build(BuildContext context) {
    final thumbnailRequest = ThumbnailRequest(file: widget.fileToPost, fileType: widget.fileType);
    final postSettings = ref.watch(postSettingsProvider);
    final postController = useTextEditingController();
    final isPostButtonEnabled = useState(false);
    useEffect((){
      void listener() => isPostButtonEnabled.value = postController.text.isNotEmpty;
      postController.addListener(listener);      
      return (){postController.removeListener(listener);};
    }, [postController]);
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Posts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: isPostButtonEnabled.value ? () async{
              final userId = ref.read(userIdProvider);
              if(userId == null){return;}
              final isUploaded = await ref.read(imageUploadProvider.notifier).uploadtoRemote(
                file: widget.fileToPost, 
                fileType: widget.fileType,
                message: postController.text, 
                postSettings: postSettings, 
                userId: userId
              );
              if(isUploaded && mounted){Navigator.pop(context);}
            } : null
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FileThumbnailView(thumbnailRequest: thumbnailRequest),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: postController,
                decoration: const InputDecoration(labelText: 'Write about your post here',),
                style: const TextStyle(color: Colors.white),
                autofocus: true,
                maxLines: null,
              ),
            ),
            ...PostSettings.values.map((setting) => ListTile(
              title: Text(setting.title),
              subtitle: Text(setting.description),
              trailing: Switch(
                value: postSettings[setting] ?? false,
                onChanged: (isOn) => ref.read(postSettingsProvider.notifier).setPostSetting(setting, isOn)
              )
            ))
          ]
        ),
      )
    );
  }
}