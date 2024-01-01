import 'dart:io';
import 'package:flutter/material.dart';
import 'package:instagram_clone_app/enums_and_extensions/enums.dart';

@immutable 
class ThumbnailRequest{
  final File file;
  final FileType fileType;

  const ThumbnailRequest({required this.file, required this.fileType});

  @override
  bool operator ==(Object other) => 
    identical(this, other) || 
    other is ThumbnailRequest && 
      runtimeType == other.runtimeType 
      && file == other.file && fileType == other.fileType;

  @override 
  int get hashCode => Object.hash(file, fileType, runtimeType);
}