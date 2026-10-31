// Local SQLite / Key-Value Database Helper for storing scan logs offline

class LocalDatabase {
  static final LocalDatabase instance = LocalDatabase._init();
  LocalDatabase._init();

  final List<Map<String, dynamic>> _scanHistory = [];

  Future<void> saveScanResult(Map<String, dynamic> scanData) async {
    scanData['timestamp'] = DateTime.now().toIso8601String();
    _scanHistory.insert(0, scanData);
  }

  Future<List<Map<String, dynamic>>> getScanHistory() async {
    return List.unmodifiable(_scanHistory);
  }

  Future<void> clearHistory() async {
    _scanHistory.clear();
  }
}
