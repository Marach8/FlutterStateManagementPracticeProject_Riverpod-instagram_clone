import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/enums_and_extensions/enums.dart';
import 'package:instagram_clone_app/enums_and_extensions/extensions.dart';
import 'package:instagram_clone_app/images/image_withaspectratio.dart';
import 'package:instagram_clone_app/views/thumbnails/thumbnail_exceptions.dart';
import 'package:instagram_clone_app/views/thumbnails/thumbnail_request.dart';
import 'package:video_thumbnail/video_thumbnail.dart';


final thumbnailProvider = 
  FutureProvider.family.autoDispose<ImageWithAspectRatio, ThumbnailRequest>((ref, request) async{
    final Image image;
    switch(request.fileType){
      case FileType.image:
        image = Image.file(request.file, fit: BoxFit.cover);
        break;
      case FileType.video:
        final thumb = await VideoThumbnail.thumbnailData(
          video: request.file.path,
          imageFormat: ImageFormat.JPEG,
          quality: 75
        );
        if (thumb == null){throw const CouldNotBuildThumbnailException();}
        image = Image.memory(thumb, fit: BoxFit.cover);
        break;
    }
    final aspectRatio = await image.getImageAspectRatio();
    return ImageWithAspectRatio(image: image, aspectRatio: aspectRatio);
  });