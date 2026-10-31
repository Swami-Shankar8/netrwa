import 'package:flutter/material.dart';

class LinkScannerScreen extends StatefulWidget {
  const LinkScannerScreen({super.key});

  @override
  State<LinkScannerScreen> createState() => _LinkScannerScreenState();
}

class _LinkScannerScreenState extends State<LinkScannerScreen> {
  final TextEditingController _urlController = TextEditingController();
  String? _result;

  void _analyzeLink() {
    setState(() {
      if (_urlController.text.contains('bit.ly') ||
          _urlController.text.contains('free')) {
        _result = '⚠️ Phishing/Suspicious Link Detected!';
      } else {
        _result = '✅ Link looks safe.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Links')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _urlController,
              decoration: InputDecoration(
                hintText: 'Paste link here (e.g., https://...)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => _urlController.clear(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F52BA),
                ),
                onPressed: _analyzeLink,
                child: const Text(
                  'Scan Link Now',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            if (_result != null) ...[
              const SizedBox(height: 24),
              Text(
                _result!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
