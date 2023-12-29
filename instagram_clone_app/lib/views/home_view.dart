import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/providers/auth_state_provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Homepage'), centerTitle: true),
      body: Consumer(
        builder: (__, ref, _){
            return TextButton(
            onPressed: (){
              ref.read(authStateProvider.notifier).logOut();
            },
            child: const Text('Logout')
          );
        }
      )
    );
  }
}