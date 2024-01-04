import 'package:facebook_auth/facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:instagram_clone_app/auth_results.dart';
import 'package:instagram_clone_app/constants.dart';
import 'package:instagram_clone_app/typedefs.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Authenticator{
  UserId? userId = FirebaseAuth.instance.currentUser?.uid;
  bool get isLoggedIn => userId != null;
  String? get displayName => FirebaseAuth.instance.currentUser?.displayName;
  String? get email => FirebaseAuth.instance.currentUser?.email;


  Future<void> logOut() async{
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth().logout();
  }

  Future<AuthResult> loginWithFacebook() async{
    final loginResult = await FacebookAuth().login(['public_profile',]);
    final String? result = loginResult['token'];
    if(result == null){return AuthResult.aborted;}
    else{
      final oauthCredential = FacebookAuthProvider.credential(result);
      try{
        await FirebaseAuth.instance.signInWithCredential(oauthCredential);
        return AuthResult.success;
      } on FirebaseAuthException catch(e){
        final email = e.email;
        final credential  = e.credential;
        if(e.code == Constants.accountExistsWithDifferentCredential &&
        email != null && credential != null){
          final providers = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
          if(providers.contains(Constants.googleCom)){await loginWithGoogle();}
          FirebaseAuth.instance.currentUser?.linkWithCredential(credential);
          return AuthResult.success;
        }
        return AuthResult.failure;
      } catch (e){return AuthResult.failure;}
    }    
  }



  Future<AuthResult> loginWithGoogle() async{
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [Constants.emailScope], 
      clientId: '310781821333-t1vng3i3j24v6tjdchgclpa3536ppb4e.apps.googleusercontent.com'
    );

    final signInAccount = await googleSignIn.signIn();
    if(signInAccount == null){return AuthResult.aborted;}
    final googleAuth = await signInAccount.authentication;
    final oauthCredentials = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken, idToken: googleAuth.idToken
    );
    try{
      await FirebaseAuth.instance.signInWithCredential(oauthCredentials);
      return AuthResult.success;
    } on FirebaseAuthException catch(_){return AuthResult.failure;}
    catch (_){return AuthResult.failure;}
  }
}