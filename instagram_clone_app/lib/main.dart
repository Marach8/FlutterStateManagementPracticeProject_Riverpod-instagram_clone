import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/firebase_options.dart';
import 'package:instagram_clone_app/views/home_view.dart';
import 'package:instagram_clone_app/isloggedin_provider.dart';
import 'package:instagram_clone_app/views/login_view.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white12, foregroundColor: Colors.white
        ),
        useMaterial3: true
      ),
      home: Consumer(
        builder: (context, ref, _) {
          final isLoggedIn = ref.watch(isLoggedInProvider);
          if(isLoggedIn){return const HomeView();}
          else{return const LoginView();}
        }
      )
    );
  }
}