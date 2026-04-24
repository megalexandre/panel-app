import 'dart:convert';

import 'package:acal/features/dashboard/domain/dashboard_menu_item.dart';
import 'package:flutter/services.dart';

class DashboardMenuConfig {
  const DashboardMenuConfig._();

  static const String _assetPath = 'assets/config/dashboard_menu.json';

  static Future<List<DashboardMenuItem>> load() async {
    final raw = await rootBundle.loadString(_assetPath);
    final list = json.decode(raw) as List<dynamic>;
    return list
        .cast<Map<String, dynamic>>()
        .map(DashboardMenuItem.fromJson)
        .toList();
  }
}
