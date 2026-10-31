import 'package:flutter/material.dart';

import '../../data/qr_parser.dart';

class QrAnalystScreen extends StatefulWidget {
  const QrAnalystScreen({super.key});

  @override
  State<QrAnalystScreen> createState() => _QrAnalystScreenState();
}

class _QrAnalystScreenState extends State<QrAnalystScreen> {
  final TextEditingController _controller = TextEditingController();
  Map<String, String>? _result;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR Analyst')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.qr_code_scanner,
              size: 72,
              color: Color(0xFF0F52BA),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'QR content or payment link',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () =>
                  setState(() => _result = QrParser.analyze(_controller.text)),
              child: const Text('Analyse QR'),
            ),
            if (_result != null) ...[
              const SizedBox(height: 16),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: Text(_result!['label']!),
                  subtitle: Text(_result!['risk']!),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
