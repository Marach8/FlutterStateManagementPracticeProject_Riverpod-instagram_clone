import 'package:flutter/material.dart';

class RichTwoPartsText extends StatelessWidget {
  final String leftPart, rightPart;
  const RichTwoPartsText({required this.leftPart, required this.rightPart, super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          height: 1.5
        ),
        children: [
          TextSpan(
            text: leftPart,
            style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white)
          ),
          TextSpan(text: ' $rightPart', style: const TextStyle(color: Colors.white60)),          
        ]
      )
    );
  }
}