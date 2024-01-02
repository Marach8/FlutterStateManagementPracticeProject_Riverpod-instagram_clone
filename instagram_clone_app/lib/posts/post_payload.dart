import 'dart:collection' show MapView;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_app/enums_and_extensions/enums.dart';
import 'package:instagram_clone_app/posts/post_key.dart';
import 'package:instagram_clone_app/typedefs.dart';


@immutable 
class PostPayLoad extends MapView<String, dynamic>{
  PostPayLoad({
    required UserId userId,
    required String message,
    required String thumbnailUrl,
    required String fileUrl,
    required String fileName,
    required String fileType,
    required String thumbnailStorageId,
    required double aspectRatio,
    required String originalFileStorageId,
    required Map<PostSettings, bool> postSettings
  }): super({
    PostKey.userId: userId,
    PostKey.message: message,
    PostKey.createdAt: FieldValue.serverTimestamp(),
    PostKey.thumbnailUrl: thumbnailUrl,
    PostKey.fileUrl: fileUrl,
    PostKey.fileType: fileType,
    PostKey.fileName: fileName,
    PostKey.aspectRatio: aspectRatio,
    PostKey.thumbnailStorageId: thumbnailStorageId,
    PostKey.originalFileStorageId: originalFileStorageId,
    PostKey.postSettings: {
      for(final postSetting in postSettings.entries) postSetting.key.storageKey: postSetting.value
    }
  });
}