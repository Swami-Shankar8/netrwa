import 'package:flutter/services.dart';
import '../../app/utils/logger.dart';

class NativeSmsListener {
  static const EventChannel _smsEventChannel =
      EventChannel('netrwa.security/sms_stream');

  /// Real-time incoming SMS broadcast stream
  static Stream<dynamic> get incomingSmsStream {
    return _smsEventChannel.receiveBroadcastStream().map((dynamic event) {
      if (event is Map) {
        return {
          'sender': event['sender'] ?? '',
          'body': event['body'] ?? '',
          'timestamp': DateTime.now().toIso8601String(),
        };
      }
      return event;
    }).handleError((dynamic error) {
      AppLogger.error('SMS Listener Error in Stream', error);
    });
  }
}
