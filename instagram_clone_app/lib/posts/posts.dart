import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_app/enums_and_extensions/enums.dart';
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
      createdAt = (json[PostKey.createdAt] as Timestamp).toDate(),
      thumbnailUrl= json[PostKey.thumbnailUrl],
      fileUrl = json[PostKey.fileUrl],
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
