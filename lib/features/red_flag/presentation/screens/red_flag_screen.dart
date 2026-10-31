import 'package:flutter/material.dart';
import '../../controllers/red_flag_controller.dart';
import '../../models/red_flag_model.dart';

class RedFlagScreen extends StatefulWidget {
  const RedFlagScreen({super.key});

  @override
  State<RedFlagScreen> createState() => _RedFlagScreenState();
}

class _RedFlagScreenState extends State<RedFlagScreen> {
  final RedFlagController _controller = RedFlagController();
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    _controller.fetchAndMonitorRealSms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Red Flag',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_rounded, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: StreamBuilder<List<RedFlagAlert>>(
        stream: _controller.alertsStream,
        initialData: _controller.currentAlerts,
        builder: (context, snapshot) {
          final alerts = snapshot.data ?? [];
          final filteredAlerts = _filterAlerts(alerts);
          final scamCount = alerts.where((a) => a.category == 'SCAM').length;

          return Column(
            children: [
              const SizedBox(height: 12),
              // Filter Chips: All, Scam, Suspicious, Spam
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: ['All', 'Scam', 'Suspicious', 'Spam'].map((filter) {
                    final isSelected = _selectedFilter == filter;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        selected: isSelected,
                        label: Text(filter),
                        selectedColor: const Color(0xFF0F52BA),
                        backgroundColor: Colors.grey.shade200,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                          fontSize: 13,
                        ),
                        onSelected: (bool selected) {
                          if (selected) {
                            setState(() {
                              _selectedFilter = filter;
                            });
                          }
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 12),

              // Alert Banner Indicator matching design
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEBEE),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.redAccent,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.warning_amber_rounded,
                            color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$scamCount high-risk alerts',
                              style: const TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            const Text(
                              'Take action to stay safe',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Real Alerts List
              Expanded(
                child: filteredAlerts.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.shield_outlined,
                              size: 50,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 12),
                            const Text(
                              'No threats detected in this category',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: filteredAlerts.length,
                        itemBuilder: (context, index) {
                          final alert = filteredAlerts[index];
                          return _buildAlertTile(alert);
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  List<RedFlagAlert> _filterAlerts(List<RedFlagAlert> alerts) {
    if (_selectedFilter == 'Scam') {
      return alerts.where((a) => a.category == 'SCAM').toList();
    } else if (_selectedFilter == 'Suspicious') {
      return alerts.where((a) => a.category == 'SUSPICIOUS').toList();
    } else if (_selectedFilter == 'Spam') {
      return alerts.where((a) => a.category == 'SPAM').toList();
    }
    return alerts;
  }

  Widget _buildAlertTile(RedFlagAlert alert) {
    Color tagColor;
    Color tagBg;

    if (alert.category == 'SCAM') {
      tagColor = const Color(0xFFE53935);
      tagBg = const Color(0xFFFFEBEE);
    } else if (alert.category == 'SUSPICIOUS') {
      tagColor = const Color(0xFFFB8C00);
      tagBg = const Color(0xFFFFF3E0);
    } else {
      tagColor = const Color(0xFFF57C00);
      tagBg = const Color(0xFFFFF8E1);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey.shade100,
                child: Text(
                  alert.sender.isNotEmpty ? alert.sender[0].toUpperCase() : '?',
                  style: TextStyle(
                    color: tagColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      alert.sender,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    Text(
                      '${alert.timestamp.hour}:${alert.timestamp.minute.toString().padLeft(2, '0')}',
                      style: const TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: tagBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  alert.category,
                  style: TextStyle(
                    color: tagColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            alert.message,
            style: const TextStyle(
                color: Colors.black87, fontSize: 13, height: 1.3),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
