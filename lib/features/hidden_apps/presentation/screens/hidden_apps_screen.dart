import 'package:flutter/material.dart';

class HiddenAppsScreen extends StatelessWidget {
  const HiddenAppsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, Object>> detectedApps = [
      {
        'name': 'System Update Service',
        'risk': 'High Risk',
        'access': 'Location, Network',
        'color': Colors.red,
      },
      {
        'name': 'Hidden Camera',
        'risk': 'High Risk',
        'access': 'Camera, Microphone',
        'color': Colors.red,
      },
      {
        'name': 'Weather Pro',
        'risk': 'Medium Risk',
        'access': 'Accessed Location',
        'color': Colors.orange,
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Hidden Apps')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.red,
                    size: 32,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '2 suspicious apps found',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'These apps are accessing your data without direct knowledge.',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: detectedApps.length,
                itemBuilder: (context, index) {
                  final app = detectedApps[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.android, color: Colors.white),
                      ),
                      title: Text(
                        app['name'] as String,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Accessed: ${app['access']}'),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: (app['color'] as Color).withAlpha(25),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          app['risk'] as String,
                          style: TextStyle(
                            color: app['color'] as Color,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
