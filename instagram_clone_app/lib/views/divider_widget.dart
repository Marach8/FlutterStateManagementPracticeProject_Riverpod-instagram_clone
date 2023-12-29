import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DividerWithMargin extends StatelessWidget {
  const DividerWithMargin({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [Gap(40), Divider(thickness: 0.2, color: Colors.white), Gap(40)],
    );
  }
}