import 'package:flutter/material.dart';
import '../../../red_flag/presentation/screens/red_flag_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Netrwa',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const Text(
              'Think. Check. Pay Safe.',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Colors.black87,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Greeting Header
            const Text(
              'Hello, User! 👋',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Stay alert. Stay safe.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),

            // Security Status Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFC8E6C9)),
              ),
              child: const Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xFFC8E6C9),
                    child: Icon(
                      Icons.check_circle_rounded,
                      color: Color(0xFF388E3C),
                    ),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Security Status',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'All good! No major threats detected.',
                        style: TextStyle(color: Colors.black54, fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Quick Actions Grid
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.4,
              children: [
                _buildActionCard(
                  context: context,
                  title: 'Scan Message',
                  subtitle: 'Verify SMS/WhatsApp',
                  icon: Icons.chat_bubble_outline_rounded,
                  color: Colors.blue.shade50,
                  iconColor: Colors.blue,
                  onTap: () {},
                ),
                _buildActionCard(
                  context: context,
                  title: 'Check Link',
                  subtitle: 'Verify URL safety',
                  icon: Icons.link_rounded,
                  color: Colors.indigo.shade50,
                  iconColor: Colors.indigo,
                  onTap: () {},
                ),
                _buildActionCard(
                  context: context,
                  title: 'Analyse QR Codes',
                  subtitle: 'Detect fake QR/UPI',
                  icon: Icons.qr_code_scanner_rounded,
                  color: Colors.teal.shade50,
                  iconColor: Colors.teal,
                  onTap: () {},
                ),
                _buildActionCard(
                  context: context,
                  title: 'Add Applications',
                  subtitle: 'Connect your apps',
                  icon: Icons.add_to_home_screen_rounded,
                  color: Colors.purple.shade50,
                  iconColor: Colors.purple,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Red Flag & Hidden Apps Banners
            Row(
              children: [
                Expanded(
                  child: _buildBannerCard(
                    title: 'Red Flag',
                    subtitle: 'High-risk alerts',
                    icon: Icons.error_outline_rounded,
                    color: Colors.red.shade50,
                    accentColor: Colors.red,
                    onTap: () {
                      // Navigation screen push handler
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const RedFlagScreen()),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildBannerCard(
                    title: 'Hidden Apps',
                    subtitle: '2 apps found',
                    icon: Icons.security_rounded,
                    color: Colors.orange.shade50,
                    accentColor: Colors.orange,
                    onTap: () {
                      // Hidden Apps click trigger (already existing)
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Recent Activity Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Activity',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(onPressed: () {}, child: const Text('View all')),
              ],
            ),
            const SizedBox(height: 8),

            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFDCF8C6),
                child: Icon(Icons.message, color: Colors.green),
              ),
              title: const Text(
                'WhatsApp Message',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('Safe • 2m ago'),
              trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 28),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.black54, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Color accentColor,
    required VoidCallback onTap, // <--- 1. Tap handler declare karein
  }) {
    return InkWell(
      onTap: onTap, // <--- 2. Click detect karne ke liye InkWell bind karein
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, color: accentColor, size: 24),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: accentColor)),
                  Text(subtitle,
                      style:
                          const TextStyle(fontSize: 11, color: Colors.black54)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
