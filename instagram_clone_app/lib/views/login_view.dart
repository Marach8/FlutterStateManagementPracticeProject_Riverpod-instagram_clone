import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/providers/auth_state_provider.dart';
import 'package:instagram_clone_app/views/divider_widget.dart';
import 'package:instagram_clone_app/views/login_buttons.dart';
import 'package:instagram_clone_app/views/rich_text/login_rich_text_view.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Instant-Gram'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Gap(40),
              const Text(
                'Welcome to Instant-Gram!',
                style: TextStyle(
                  color: Colors.white, 
                  fontSize: 40
                )
              ),
              const DividerWithMargin(),
              const Text(
                'Login to your account using any of the options below.',
                style: TextStyle(
                  color: Colors.white, 
                  fontSize: 15
                )
              ),
              const Gap(20),
              TextButton(
                onPressed: ref.read(authStateProvider.notifier).loginWithFacebook,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black
                ),
                child: const FacebookButton()
              ),
              const Gap(20),
              TextButton(
                onPressed: ref.read(authStateProvider.notifier).loginWithGoogle,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black
                ),
                child: const GoogleButton()
              ),
              const DividerWithMargin(),
              const RichTextView()
            ]
          )
        ),
      )
    );
  }
}