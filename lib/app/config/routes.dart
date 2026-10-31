import 'package:flutter/material.dart';

import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/app_connector/presentation/screens/add_applications_screen.dart';
import '../../features/hidden_apps/presentation/screens/hidden_apps_screen.dart';
import '../../features/red_flag/presentation/screens/red_flag_screen.dart';
import '../../features/privacy_tips/settings/presentation/screens/settings_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String addApplications = '/add-applications';
  static const String hiddenApps = '/hidden-apps';
  static const String redFlag = '/red-flag';
  static const String settings = '/settings';

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Splash Screen'))),
        );
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case home:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Home Screen'))),
        );
      case addApplications:
        return MaterialPageRoute(builder: (_) => const AddApplicationsScreen());
      case hiddenApps:
        return MaterialPageRoute(builder: (_) => const HiddenAppsScreen());
      case redFlag:
        return MaterialPageRoute(builder: (_) => const RedFlagScreen());
      case settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }
}
