import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/dialogs/dialogs.dart';
import 'package:instagram_clone_app/enums_and_extensions/enums.dart';
import 'package:instagram_clone_app/enums_and_extensions/extensions.dart';
import 'package:instagram_clone_app/images/image_picker_helper.dart';
import 'package:instagram_clone_app/posts/new_post_view.dart';
import 'package:instagram_clone_app/providers/auth_state_provider.dart';
import 'package:instagram_clone_app/providers/post_settings_provider.dart';
import 'package:instagram_clone_app/views/home_view.dart';
import 'package:instagram_clone_app/views/search_view.dart';
import 'package:instagram_clone_app/views/user_posts_view.dart';


class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<MainView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Instant-Gram'),
          actions: [
            IconButton(
              onPressed: () async{
                final pickedVideo = await ImagePickerHelper.pickVideoFromGallery();
                if(pickedVideo == null){return;}
                final newPostSettingsProvider = ref.refresh(postSettingsProvider);
                if(!mounted){return;}                
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (_) => CreateNewPostView(
                      fileToPost: pickedVideo, fileType: FileType.video
                    )
                  )
                );               
              },
              icon: const FaIcon(FontAwesomeIcons.film)
            ),
            IconButton(
              onPressed: () async{
                final pickedImage = await ImagePickerHelper.pickImageFromGallery();
                if(pickedImage == null){return;}
                final newPostSettingsProvider = ref.refresh(postSettingsProvider);
                if(!mounted){return;}
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (_) => CreateNewPostView(
                      fileToPost: pickedImage, fileType: FileType.image
                    )
                  )
                );
              },
              icon: const FaIcon(Icons.add_a_photo_rounded)
            ),
            IconButton(
              onPressed: () async{
                final shouldLogout = await LogoutAlertDialog()
                  .showAlertDialog(context).then((value) => value ?? false);
                shouldLogout ? await ref.read(authStateProvider.notifier).logOut(): {};
              },
              icon: const FaIcon(Icons.logout_rounded)
            )
          ],
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.search)),
              Tab(icon: Icon(Icons.person)),
            ]
          )
        ),
        body: const TabBarView(
          children: [
            HomeView(),
            SearchView(),
            UserPostsView(),
          ],
        )
      )
    );
  }
}