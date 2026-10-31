import 'package:flutter/material.dart';

import '../../data/spam_detector.dart';

class MessageCheckerScreen extends StatefulWidget {
  const MessageCheckerScreen({super.key});

  @override
  State<MessageCheckerScreen> createState() => _MessageCheckerScreenState();
}

class _MessageCheckerScreenState extends State<MessageCheckerScreen> {
  final TextEditingController _controller = TextEditingController();
  Map<String, Object>? _result;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _checkMessage() {
    setState(() => _result = SpamDetector.analyze(_controller.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Message Checker')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Paste an SMS or WhatsApp message',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _controller,
            maxLines: 7,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: 'Enter the complete message...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _controller.text.trim().isEmpty ? null : _checkMessage,
            icon: const Icon(Icons.security),
            label: const Text('Check Message'),
          ),
          if (_result != null) ...[
            const SizedBox(height: 20),
            Card(
              color: (_result!['isSafe'] as bool)
                  ? const Color(0xFFE8F5E9)
                  : const Color(0xFFFFEBEE),
              child: ListTile(
                leading: Icon(
                  (_result!['isSafe'] as bool)
                      ? Icons.verified
                      : Icons.warning_amber,
                ),
                title: Text(_result!['label'] as String),
                subtitle: Text(
                  'Risk level: ${_result!['risk']} • Score: ${_result!['score']}',
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
