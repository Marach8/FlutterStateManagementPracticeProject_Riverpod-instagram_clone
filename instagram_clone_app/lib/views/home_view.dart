import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/dialogs/dialogs.dart';
import 'package:instagram_clone_app/enums_and_extensions/extensions.dart';
import 'package:instagram_clone_app/providers/auth_state_provider.dart';
import 'package:instagram_clone_app/views/user_posts_view.dart';


class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Instant-Gram'),
          actions: [
            IconButton(
              onPressed: (){},
              icon: const FaIcon(FontAwesomeIcons.film)
            ),
            IconButton(
              onPressed: (){},
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
              Tab(icon: Icon(Icons.person)),
              Tab(icon: Icon(Icons.search)),
              Tab(icon: Icon(Icons.home))
            ]
          )
        ),
        body: const TabBarView(
          children: [
            UserPostsView(),
            UserPostsView(),
            UserPostsView()
          ],
        )
      )
    );
  }
}