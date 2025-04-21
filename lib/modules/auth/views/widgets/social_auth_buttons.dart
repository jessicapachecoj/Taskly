import 'package:flutter/material.dart';

class SocialAuthButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        const SizedBox(height: 16),
        Text('Ou continue com'),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.g_mobiledata, size: 40),
              onPressed: () {},
            ),
            const SizedBox(width: 20),
            IconButton(
              icon: Icon(Icons.facebook, size: 40),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}