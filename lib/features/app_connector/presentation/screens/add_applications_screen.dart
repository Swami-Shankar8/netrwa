import 'package:flutter/material.dart';
import '../../models/app_info_model.dart';
import '../../../../core/services/native_app_scanner.dart';

class AddApplicationsScreen extends StatefulWidget {
  const AddApplicationsScreen({super.key});

  @override
  State<AddApplicationsScreen> createState() => _AddApplicationsScreenState();
}

class _AddApplicationsScreenState extends State<AddApplicationsScreen> {
  List<AppInfoModel> _supportedApps = [
    AppInfoModel(name: 'WhatsApp', packageName: 'com.whatsapp', iconPath: 'chat', isConnected: true),
    AppInfoModel(name: 'SMS', packageName: 'com.android.mms', iconPath: 'sms', isConnected: true),
    AppInfoModel(name: 'Gmail', packageName: 'com.google.android.gm', iconPath: 'email', isConnected: false),
    AppInfoModel(name: 'Phone', packageName: 'com.android.dialer', iconPath: 'phone', isConnected: false),
    AppInfoModel(name: 'Telegram', packageName: 'org.telegram.messenger', iconPath: 'send', isConnected: false),
  ];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadInstalledApps();
  }

  Future<void> _loadInstalledApps() async {
    setState(() => _isLoading = true);
    try {
      final installedApps = await NativeAppScanner.getInstalledApps();
      if (installedApps.isNotEmpty) {
        // Match with installed native packages
      }
    } catch (_) {}
    setState(() => _isLoading = false);
  }

  void _toggleConnect(int index) {
    setState(() {
      _supportedApps[index] = _supportedApps[index].copyWith(
        isConnected: !_supportedApps[index].isConnected,
      );
    });

    final app = _supportedApps[index];
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          app.isConnected
              ? '${app.name} connected for monitoring'
              : '${app.name} disconnected',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Add Applications',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Connect Your Apps Info Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F0FE),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Color(0xFF0F52BA),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.apps_rounded, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Connect your apps',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Link your applications to get better protection and scan for suspicious activity.',
                          style: TextStyle(color: Colors.black54, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            const Text(
              'Supported apps',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),

            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _supportedApps.length,
                    itemBuilder: (context, index) {
                      final app = _supportedApps[index];
                      return _buildAppTile(app, index);
                    },
                  ),

            const SizedBox(height: 24),

            // Add Application Custom Button
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                side: const BorderSide(color: Color(0xFF0F52BA)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                _showAddMoreAppsDialog();
              },
              icon: const Icon(Icons.add, color: Color(0xFF0F52BA)),
              label: const Text(
                'Add application',
                style: TextStyle(color: Color(0xFF0F52BA), fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 28),

            // Privacy Note
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.security, color: Color(0xFF0F52BA), size: 20),
                      SizedBox(width: 8),
                      Text('Your privacy matters', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _buildPrivacyBullet('You choose which apps to connect'),
                  _buildPrivacyBullet('We only access notifications (not full content)'),
                  _buildPrivacyBullet('You can disconnect anytime'),
                  _buildPrivacyBullet('All data is encrypted and secure'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppTile(AppInfoModel app, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFE8F0FE),
            child: Icon(_getIconData(app.iconPath), color: const Color(0xFF0F52BA)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              app.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: app.isConnected ? Colors.grey.shade200 : const Color(0xFF0F52BA),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () => _toggleConnect(index),
            child: Text(
              app.isConnected ? 'Connected' : 'Connect',
              style: TextStyle(
                color: app.isConnected ? Colors.black87 : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyBullet(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          const Text('• ', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
          Expanded(child: Text(text, style: const TextStyle(color: Colors.black54, fontSize: 12))),
        ],
      ),
    );
  }

  IconData _getIconData(String name) {
    switch (name) {
      case 'chat':
        return Icons.chat_bubble_outline_rounded;
      case 'sms':
        return Icons.sms_outlined;
      case 'email':
        return Icons.email_outlined;
      case 'phone':
        return Icons.phone_outlined;
      case 'send':
        return Icons.send_rounded;
      default:
        return Icons.apps;
    }
  }

  void _showAddMoreAppsDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Scan More Apps', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 12),
              const Text('Scanning installed packages on device...'),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F52BA),
                  minimumSize: const Size(double.infinity, 45),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text('Close', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      },
    );
  }
}