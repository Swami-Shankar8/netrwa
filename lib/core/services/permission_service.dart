import 'package:flutter/services.dart';

import '../../app/utils/logger.dart';

class PermissionService {
  static const MethodChannel _channel = MethodChannel(
    'netrwa.security/permissions',
  );

  static Future<bool> requestSmsPermission() async {
    try {
      final bool granted = await _channel.invokeMethod('requestSmsPermission');
      return granted;
    } on PlatformException catch (e) {
      AppLogger.error('Failed to request SMS permission', e);
      return false;
    }
  }

  static Future<bool> checkAccessibilityPermission() async {
    try {
      final bool enabled = await _channel.invokeMethod('checkAccessibility');
      return enabled;
    } on PlatformException catch (e) {
      AppLogger.error('Failed to check Accessibility status', e);
      return false;
    }
  }
}
