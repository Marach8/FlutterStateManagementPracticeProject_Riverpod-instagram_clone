import 'package:flutter/foundation.dart';
import 'package:instagram_clone_app/auth_results.dart';
import 'package:instagram_clone_app/typedefs.dart';

@immutable 
class AuthState{
  final AuthResult? result;
  final bool isLoading; 
  final UserId? id;

  const AuthState({required this.result, required this.isLoading, required this.id});
  
  const AuthState.unknown(): result = null, isLoading = false, id = null;

  AuthState copiedWithIsLoading(bool loading) => AuthState(result: result, isLoading : loading, id: id);

  @override 
  bool operator ==(covariant AuthState other) 
  => identical(this, other) || (result == other.result && isLoading == other.isLoading && id == other.id);

  @override 
  int get hashCode => Object.hash(result, isLoading, id);
}