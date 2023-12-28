import 'package:flutter/material.dart';
import 'package:instagram_clone_app/backend_auth.dart';
import 'dart:developer' as marach show log;

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Homepage'), centerTitle: true),
      body: Column(
        children: [
          TextButton(
            onPressed: () async{
              final result = await Authenticator().loginWithGoogle();
              print(result.toString());
            },
            child: const Text('SignIn with Google')
          ),
          TextButton(
            onPressed: () async{
              final facebookResult = await Authenticator().loginWithFacebook();
              print(facebookResult.toString());
            },
            child: const Text('SignIn with Facebook')
          )
        ]
      )
    );
  }
}