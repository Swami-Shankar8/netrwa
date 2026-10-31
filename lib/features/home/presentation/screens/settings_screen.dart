import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _monitorBackgroundApps = true;
  bool _onDeviceAnalysis = true;
  bool _anonymisedReporting = false;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy & Security')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Banner Info Box
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.verified_user_rounded,
                  color: Colors.green,
                  size: 36,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Privacy Matters',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'All analysis is done on your device or in an anonymised way. Your personal data and messages are never stored.',
                        style: TextStyle(fontSize: 12, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // App Monitoring Toggles
          const Text(
            'App Monitoring',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Monitor background apps'),
            subtitle: const Text('Detect hidden apps and suspicious activity'),
            value: _monitorBackgroundApps,
            onChanged: (val) => setState(() => _monitorBackgroundApps = val),
          ),
          const Divider(),

          // Data Protection Toggles
          const Text(
            'Data Protection',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('On-device analysis'),
            subtitle: const Text(
              'Your messages and files are analysed locally',
            ),
            value: _onDeviceAnalysis,
            onChanged: (val) => setState(() => _onDeviceAnalysis = val),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Anonymised reporting'),
            subtitle: const Text(
              'Help improve security without giving personal data',
            ),
            value: _anonymisedReporting,
            onChanged: (val) => setState(() => _anonymisedReporting = val),
          ),
          const Divider(),

          // Permissions & Data Management
          const Text(
            'Permissions',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.admin_panel_settings_outlined),
            title: const Text('Manage app permissions'),
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
            onTap: () {},
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(
              Icons.delete_outline_rounded,
              color: Colors.red,
            ),
            title: const Text(
              'Clear data',
              style: TextStyle(color: Colors.red),
            ),
            subtitle: const Text('Delete all app scan history'),
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
            onTap: () => _showClearDataDialog(context),
          ),
          const Divider(),

          // Language Selection
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.language_rounded),
            title: const Text('Language'),
            trailing: DropdownButton<String>(
              value: _selectedLanguage,
              underline: const SizedBox(),
              items: <String>['English', 'हिन्दी', 'ਪੰਜਾਬੀ'].map((
                String value,
              ) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                if (newValue != null) {
                  setState(() => _selectedLanguage = newValue);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showClearDataDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Scan History?'),
        content: const Text(
          'This will delete all saved scan logs from your device.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Scan history cleared')),
              );
            },
            child: const Text('Clear', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
