import 'package:flutter/material.dart';

class AddApplicationsScreen extends StatelessWidget {
  const AddApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, Object>> apps = [
      {
        'name': 'WhatsApp',
        'desc': 'Scan messages & media',
        'icon': Icons.chat_rounded,
        'color': Colors.green,
      },
      {
        'name': 'SMS',
        'desc': 'Scan text messages',
        'icon': Icons.textsms_rounded,
        'color': Colors.blue,
      },
      {
        'name': 'Gmail',
        'desc': 'Scan emails for phishing',
        'icon': Icons.email_rounded,
        'color': Colors.red,
      },
      {
        'name': 'Phone',
        'desc': 'Monitor call logs & contacts',
        'icon': Icons.phone_rounded,
        'color': Colors.blueAccent,
      },
      {
        'name': 'Telegram',
        'desc': 'Scan messages & channels',
        'icon': Icons.send_rounded,
        'color': Colors.lightBlue,
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Add Applications')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: apps.length,
        separatorBuilder: (context, index) => const Divider(height: 24),
        itemBuilder: (context, index) {
          final app = apps[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: (app['color'] as Color).withAlpha(25),
              child: Icon(
                app['icon'] as IconData,
                color: app['color'] as Color,
              ),
            ),
            title: Text(
              app['name'] as String,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(app['desc'] as String),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0F52BA),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {},
              child: const Text(
                'Connect',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}
