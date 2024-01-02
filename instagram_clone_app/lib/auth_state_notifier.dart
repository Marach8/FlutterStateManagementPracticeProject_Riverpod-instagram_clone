import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/auth_results.dart';
import 'package:instagram_clone_app/auth_state.dart';
import 'package:instagram_clone_app/backend_auth.dart';
import 'package:instagram_clone_app/typedefs.dart';
import 'package:instagram_clone_app/users/user_info_storage.dart';

class AuthStateNotifier extends StateNotifier<AuthState>{
  final Authenticator authenticator = Authenticator();
  final UserInfoStorage userInfoStorage = const UserInfoStorage();

  //We start with an authentication state of unknown
  AuthStateNotifier(): super(const AuthState.unknown()){
    //We check if we are already logged in. if yes, we emit a new authState with result of success,
    //and set the id to the current userId (uid) that currently exits.
    if (authenticator.isLoggedIn){
      state = AuthState(result: AuthResult.success, isLoading: false, id: authenticator.userId);
    }
  }

  Future<void> logOut() async{
    state = state.copiedWithIsLoading(true);
    await authenticator.logOut();
    state = const AuthState.unknown();
  }

  Future<void> saveUserInfo({required UserId userId}) => userInfoStorage.saveUserInfo(
    userId: userId, displayName: authenticator.displayName ?? '', email: authenticator.email ?? ''
  );


  Future<void> loginWithGoogle() async{
    state = state.copiedWithIsLoading(true);
    final result = await authenticator.loginWithGoogle();
    final userId = authenticator.userId;
    if(result == AuthResult.success && userId != null){
      await saveUserInfo(userId: userId);
    }
    state = AuthState(id: userId, isLoading: false, result: result);
  }

  
  Future<void> loginWithFacebook() async{
    state = state.copiedWithIsLoading(true);
    final result = await authenticator.loginWithFacebook();
    final userId = authenticator.userId;
    if(result == AuthResult.success && userId != null){
      await saveUserInfo(userId: userId);
    }
    state = AuthState(id: userId, isLoading: false, result: result);
  }
}