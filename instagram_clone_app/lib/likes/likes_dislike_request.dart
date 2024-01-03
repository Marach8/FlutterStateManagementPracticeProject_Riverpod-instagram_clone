import 'package:flutter/material.dart';
import 'package:instagram_clone_app/typedefs.dart';

@immutable 
class LikesDislikesRequest{
  final PostId postId;
  final UserId likedBy;
  
  const LikesDislikesRequest({
    required this.postId, 
    required this.likedBy
  });
}