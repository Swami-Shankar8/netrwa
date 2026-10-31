import 'package:flutter/material.dart';
import 'app/config/theme.dart';
import 'features/home/presentation/screens/home_screen.dart';
import 'features/red_flag/presentation/screens/red_flag_screen.dart';
import 'features/privacy_tips/presentation/screens/privacy_tips_screen.dart';
import 'features/settings/presentation/screens/settings_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const NetrwaApp());
}

class NetrwaApp extends StatelessWidget {
  const NetrwaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Netrwa',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const RedFlagScreen(),
    const PrivacyTipsScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF0F52BA),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.error_outline_rounded),
            label: 'Red Flag',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb_outline_rounded),
            label: 'Tips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_rounded),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
