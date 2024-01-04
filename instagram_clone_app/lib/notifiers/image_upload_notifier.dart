import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/foundation.dart' show Uint8List;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/enums_and_extensions/enums.dart';
import 'package:instagram_clone_app/enums_and_extensions/extensions.dart';
import 'package:instagram_clone_app/firebase_fields.dart';
import 'package:instagram_clone_app/posts/post_payload.dart';
import 'package:instagram_clone_app/typedefs.dart';
import 'package:instagram_clone_app/views/thumbnails/thumbnail_exceptions.dart';
import 'package:uuid/uuid.dart';
import 'package:video_thumbnail/video_thumbnail.dart';


class ImageUploadNotifier extends StateNotifier<IsLoading>{
  ImageUploadNotifier(): super(false);

  set isLoading(bool value) => state = value;

  Future<bool> uploadtoRemote({
    required File file, 
    required FileType fileType, 
    required String message, 
    required Map<PostSettings, bool> postSettings,
    required UserId userId 
  }) async{
    isLoading = true;
    late Uint8List thumbnailUint8List;
    switch(fileType){      
      case FileType.image:
        final fileAsImage = img.decodeImage(file.readAsBytesSync());
        if(fileAsImage == null){
          isLoading = false; 
          throw const CouldNotBuildThumbnailException();
        }
        final thumbnail = img.copyResize(fileAsImage, width: 150);
        final thumbnailData = img.encodeJpg(thumbnail);
        thumbnailUint8List = Uint8List.fromList(thumbnailData);
        break;

      case FileType.video:
        final thumb = await VideoThumbnail.thumbnailData(
          video: file.path, 
          imageFormat: ImageFormat.JPEG,
          maxHeight: 450,
          quality: 75
        );
        if(thumb == null){
          isLoading = false; 
          throw const CouldNotBuildThumbnailException();
        }
        thumbnailUint8List = thumb;
        break;
    }
    final thumbnailAspectRatio = await thumbnailUint8List.getBytesASpectRatio();
    final fileName = const Uuid().v4();

    final thumbnailRef = FirebaseStorage.instance.ref()
      .child(userId).child(FirebaseCollectionName.thumbnails)
      .child(fileName);

    final originalFileRef = FirebaseStorage.instance.ref()
    .child(userId).child(fileType.collectionName).child(fileName);

    try{
      final thumbnailUploadTask = await thumbnailRef.putData(thumbnailUint8List);
      final thumbnailStorageId = thumbnailUploadTask.ref.name;

      final originalFileUploadTask = await originalFileRef.putFile(file);
      final originalFileStorageId = originalFileUploadTask.ref.name;
      
      final postPayLoad = PostPayLoad(
        userId: userId, 
        message: message, 
        thumbnailUrl: await thumbnailRef.getDownloadURL(), 
        fileUrl: await originalFileRef.getDownloadURL(),
        fileName: fileName, 
        fileType: fileType.name, 
        thumbnailStorageId: thumbnailStorageId,
        aspectRatio: thumbnailAspectRatio, 
        originalFileStorageId: originalFileStorageId, 
        postSettings: postSettings
      );

      await FirebaseFirestore.instance.collection(FirebaseCollectionName.posts)
        .add(postPayLoad);
      return true;
    } catch(e){return false;}
    finally{isLoading = false;}
  }
}