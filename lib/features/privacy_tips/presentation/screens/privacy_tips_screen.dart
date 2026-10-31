import 'package:flutter/material.dart';

class PrivacyTipsScreen extends StatelessWidget {
  const PrivacyTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Tips'),
      ),
      body: const Center(
        child: Text('Stay alert! Never share OTPs or click unverified links.'),
      ),
    );
  }
}
