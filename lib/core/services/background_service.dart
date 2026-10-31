import 'dart:async';

import '../../app/utils/logger.dart';
import 'native_sms_listener.dart';

class BackgroundMonitoringService {
  static final BackgroundMonitoringService _instance =
      BackgroundMonitoringService._internal();
  factory BackgroundMonitoringService() => _instance;
  BackgroundMonitoringService._internal();

  StreamSubscription? _smsSubscription;

  void startMonitoring({
    required Function(String sender, String body) onScamSmsDetected,
  }) {
    AppLogger.log('Starting Netrwa Real-time Background Monitoring...');

    _smsSubscription = NativeSmsListener.incomingSmsStream.listen(
      (dynamic event) {
        if (event is Map) {
          final String sender = event['sender'] ?? 'Unknown';
          final String body = event['body'] ?? '';

          AppLogger.log('Incoming Message Received from: $sender');

          // Basic keyword detection trigger
          if (_checkScamKeywords(body)) {
            onScamSmsDetected(sender, body);
          }
        }
      },
      onError: (error) {
        AppLogger.error('Error listening to SMS Stream', error);
      },
    );
  }

  bool _checkScamKeywords(String text) {
    final lower = text.toLowerCase();
    return lower.contains('kyc') ||
        lower.contains('lottery') ||
        lower.contains('account blocked') ||
        lower.contains('bit.ly') ||
        lower.contains('claim now');
  }

  /// Stop monitoring service
  void stopMonitoring() {
    _smsSubscription?.cancel();
    AppLogger.log('Background Monitoring Stopped.');
  }
}
