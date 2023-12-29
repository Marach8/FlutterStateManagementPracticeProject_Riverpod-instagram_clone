import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_app/views/rich_text/base_text.dart';
import 'package:instagram_clone_app/views/rich_text/link_text.dart';

class RichTextWidget extends StatelessWidget {
  final Iterable<BaseText> texts;
  final TextStyle? styleForAll;
  const RichTextWidget({required this.texts, this.styleForAll, super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: texts.map((myText){
          if(myText is LinkText){
            return TextSpan(
              text: myText.text,
              style: styleForAll?.merge(myText.style),
              recognizer: TapGestureRecognizer()..onTap = myText.onTapped,
            );
          } else{
            return TextSpan(
              text: myText.text,
              style: styleForAll?.merge(myText.style),
            );
          }
        }).toList()
      )
    );
  }
}