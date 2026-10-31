import 'package:flutter/services.dart';
import '../../app/utils/logger.dart';

class AccessibilityService {
  static const MethodChannel _channel =
      MethodChannel('netrwa.security/accessibility');

  /// Checks if Accessibility service is enabled for app monitoring
  static Future<bool> isServiceEnabled() async {
    try {
      final bool isEnabled =
          await _channel.invokeMethod('isAccessibilityEnabled');
      return isEnabled;
    } on PlatformException catch (e) {
      AppLogger.error('Failed to check accessibility permission', e);
      return false;
    }
  }

  /// Opens Accessibility Settings screen on device
  static Future<void> openAccessibilitySettings() async {
    try {
      await _channel.invokeMethod('openAccessibilitySettings');
    } on PlatformException catch (e) {
      AppLogger.error('Failed to open settings', e);
    }
  }
}
