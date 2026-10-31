import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: const Icon(Icons.security),
            title: const Text('App Permissions'),
            subtitle: const Text('Manage SMS, Location and Accessibility'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.notifications_active_outlined),
            title: const Text('Alert Notifications'),
            subtitle: const Text('Real-time scam warnings'),
            trailing: Switch(value: true, onChanged: (val) {}),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About Netrwa'),
            subtitle: const Text('Version 1.0.0'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
