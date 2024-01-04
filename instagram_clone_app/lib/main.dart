import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/firebase_options.dart';
import 'package:instagram_clone_app/providers/isloading_provider.dart';
import 'package:instagram_clone_app/screen_and_controller/loadingscreen.dart';
import 'package:instagram_clone_app/views/mainview.dart';
import 'package:instagram_clone_app/providers/isloggedin_provider.dart';
import 'package:instagram_clone_app/views/login_view.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(androidProvider: AndroidProvider.debug);
  runApp(
    const ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      )
    )
  );
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
        builder: (__, ref, _) {
          ref.listen(isLoadingProvider, (_, isLoading){
            if(isLoading){LoadingScreen().showOverlay(context, 'Loading...');}
            else{LoadingScreen().hideOverlay();}
          });
          final isLoggedIn = ref.watch(isLoggedInProvider);
          if(isLoggedIn){return const MainView();}
          else{return const LoginView();}
        }
      )
    );
  }
}