import 'package:flutter/material.dart';
import 'package:instagram_clone_app/enums/enums.dart';
import 'package:instagram_clone_app/posts/post_key.dart';

@immutable
class Post{
  final String postId;
  final String userId;
  final String message;
  final DateTime createdAt;
  final String thumbnailUrl;
  final String fileUrl;
  final FileType fileType;
  final String fileName;
  final double aspectRatio;
  final String thumbnailStorageId;
  final String originalFileStorageId;
  final Map<PostSettings, bool> postSettings;

  Post({required this.postId, required Map<String, dynamic> json})
    : userId = json[PostKey.userId],
      message = json[PostKey.message],
      createdAt = json[PostKey.createdAt] as DateTime,
      thumbnailUrl= json[PostKey.thumbnailUrl],
      fileUrl = json[PostKey.message],
      fileType = FileType.values.firstWhere((file) 
        => file.name == json[PostKey.fileType], orElse: () => FileType.image),
      fileName = json[PostKey.fileName],
      aspectRatio = json[PostKey.aspectRatio],
      thumbnailStorageId = json[PostKey.thumbnailStorageId],
      originalFileStorageId = json[PostKey.originalFileStorageId],
      postSettings = {
        for (final entry in json[PostKey.postSettings].entries)
          PostSettings.values.firstWhere((element) => element.storageKey == entry.key): entry.value
      };

  bool get allowLikes => postSettings[PostSettings.allowLikes] ?? false;
  bool get allowComments => postSettings[PostSettings.allowComments] ?? false;
}
