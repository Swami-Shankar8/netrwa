import 'dart:async';
import 'package:flutter/services.dart';
import '../models/red_flag_model.dart';
import '../../../core/services/native_sms_listener.dart';

class RedFlagController {
  static final RedFlagController _instance = RedFlagController._internal();
  factory RedFlagController() => _instance;
  RedFlagController._internal();

  static const MethodChannel _smsChannel =
      MethodChannel('netrwa.security/sms_reader');

  final List<RedFlagAlert> _realAlerts = [];
  final StreamController<List<RedFlagAlert>> _alertsStreamController =
      StreamController<List<RedFlagAlert>>.broadcast();

  Stream<List<RedFlagAlert>> get alertsStream => _alertsStreamController.stream;
  List<RedFlagAlert> get currentAlerts => List.unmodifiable(_realAlerts);

  bool _isInitialScanned = false;

  /// Load device existing SMS and listen for live incoming ones
  Future<void> fetchAndMonitorRealSms() async {
    if (!_isInitialScanned) {
      try {
        final List<dynamic>? rawMessages =
            await _smsChannel.invokeMethod('readDeviceSms');
        if (rawMessages != null) {
          _realAlerts.clear();
          for (var item in rawMessages) {
            final Map<String, dynamic> msg = Map<String, dynamic>.from(item);
            final body = msg['body'] ?? '';
            final sender = msg['sender'] ?? 'Unknown';
            final timestampStr = msg['timestamp'];

            final category = analyzeContent(body);
            if (category != 'SAFE') {
              _realAlerts.add(RedFlagAlert(
                id: DateTime.now().microsecondsSinceEpoch.toString(),
                sender: sender,
                message: body,
                category: category,
                timestamp: timestampStr != null
                    ? DateTime.parse(timestampStr)
                    : DateTime.now(),
                appSource: 'SMS',
              ));
            }
          }
        }
      } catch (e) {
        // Fallback for native platform check
      }
      _isInitialScanned = true;
      _alertsStreamController.add(_realAlerts);
    }

    // Real-time Incoming SMS Listener
    NativeSmsListener.incomingSmsStream.listen((dynamic event) {
      if (event is Map) {
        final body = event['body'] ?? '';
        final sender = event['sender'] ?? 'Unknown';

        final category = analyzeContent(body);
        if (category != 'SAFE') {
          final newAlert = RedFlagAlert(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            sender: sender,
            message: body,
            category: category,
            timestamp: DateTime.now(),
            appSource: 'SMS',
          );
          _realAlerts.insert(0, newAlert);
          _alertsStreamController.add(_realAlerts);
        }
      }
    });
  }

  // Real Fraud & Scam Keyword Analyzer
  String analyzeContent(String text) {
    final lower = text.toLowerCase();

    // High-risk SCAM Indicators
    if (lower.contains('kyc') ||
        lower.contains('account blocked') ||
        lower.contains('electricity bill') ||
        lower.contains('pan card update') ||
        lower.contains('reward points expire') ||
        lower.contains('claim refund') ||
        lower.contains('bank suspend')) {
      return 'SCAM';
    }

    // SUSPICIOUS Indicators
    if (lower.contains('bit.ly') ||
        lower.contains('t.co') ||
        lower.contains('free bonus') ||
        lower.contains('part time job') ||
        lower.contains('lottery winner') ||
        lower.contains('click here to win')) {
      return 'SUSPICIOUS';
    }

    // SPAM Indicators
    if (lower.contains('discount offer') ||
        lower.contains('flat 50% off') ||
        lower.contains('loan approved') ||
        lower.contains('credit card pre-approved') ||
        lower.contains('cashback instantly')) {
      return 'SPAM';
    }

    return 'SAFE';
  }
}
