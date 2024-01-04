import 'package:flutter/material.dart';
import 'package:instagram_clone_app/views/rich_text/base_text.dart';
import 'package:instagram_clone_app/views/rich_text/richtext_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class RichTextView extends StatelessWidget {
  const RichTextView({super.key});

  @override
  Widget build(BuildContext context) {
    return RichTextWidget(
      styleForAll: Theme.of(context).textTheme.titleMedium?.copyWith(height: 1.5),
      texts: [
        BaseText.plain(text: "Don't have an account? "),
        BaseText.plain(text: "SignUp on "),
        BaseText.link(text: "Facebook ", onTapped: () => launchUrl(Uri.parse('https://wwww.facebook.com/signup'))),
        BaseText.plain(text: "or create an account on "),
        BaseText.link(text: "Google", onTapped: () => launchUrl(Uri.parse('https://wwww.google.com/signup'))),
      ]
    );
  }
}