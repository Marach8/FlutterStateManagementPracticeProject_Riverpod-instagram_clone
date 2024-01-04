import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostDateView extends StatelessWidget {
  final DateTime dateTime;
  const PostDateView({required this.dateTime, super.key});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd MMMM, yyyy, hh:mm a');
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(formattedDate.format(dateTime), style: const TextStyle(color: Colors.white54)),
    );
  }
}