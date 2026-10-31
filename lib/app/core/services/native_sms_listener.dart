import 'package:flutter/services.dart';

import '../../utils/logger.dart';

class NativeSmsListener {
  static const EventChannel _smsEventChannel = EventChannel(
    'netrwa.security/sms_stream',
  );

  /// Stream to listen for incoming SMS in real-time
  static Stream<dynamic> get incomingSmsStream {
    return _smsEventChannel.receiveBroadcastStream().handleError((error) {
      AppLogger.error('SMS Listener Error', error);
    });
  }
}
