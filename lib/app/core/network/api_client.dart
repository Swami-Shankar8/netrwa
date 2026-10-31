import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../utils/logger.dart';

class ApiClient {
  final String baseUrl;

  ApiClient({this.baseUrl = 'https://api.netrwa.security/v1'});

  Future<Map<String, dynamic>?> checkUrlReputation(String url) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/scan-url'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'url': url}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        AppLogger.error('URL Scan failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      AppLogger.error('Network Error in URL scanning', e);
      return null;
    }
  }
}
