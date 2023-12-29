import 'package:flutter/material.dart' show VoidCallback, immutable;
import 'package:instagram_clone_app/views/rich_text/base_text.dart';

@immutable 
class LinkText extends BaseText{
  final VoidCallback onTapped;
  const LinkText({required this.onTapped, required super.text, super.style});
}