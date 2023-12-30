import 'package:flutter/material.dart' show immutable;

@immutable
class AlertDialogModel<T>{
  final String title, message;
  final Map<String, T> buttons;

  const AlertDialogModel({required this.title, required this.message, required this.buttons});
}
