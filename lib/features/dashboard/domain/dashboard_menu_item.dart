import 'package:flutter/material.dart';

enum DashboardMenuItemType { item, header }

class DashboardMenuItem {
  const DashboardMenuItem._({
    required this.type,
    required this.label,
    this.id = '',
    this.icon,
    this.hasChildren = false,
  });

  factory DashboardMenuItem.item({
    required String id,
    required String label,
    required IconData icon,
    bool hasChildren = false,
  }) =>
      DashboardMenuItem._(
        type: DashboardMenuItemType.item,
        id: id,
        label: label,
        icon: icon,
        hasChildren: hasChildren,
      );

  factory DashboardMenuItem.header(String label) => DashboardMenuItem._(
        type: DashboardMenuItemType.header,
        label: label,
      );

  factory DashboardMenuItem.fromJson(Map<String, dynamic> json) {
    if (json['type'] == 'header') {
      return DashboardMenuItem.header(json['label'] as String);
    }
    return DashboardMenuItem.item(
      id: json['id'] as String,
      label: json['label'] as String,
      icon: _iconMap[json['icon'] as String] ?? Icons.circle_outlined,
      hasChildren: json['hasChildren'] as bool? ?? false,
    );
  }

  final DashboardMenuItemType type;
  final String id;
  final String label;
  final IconData? icon;
  final bool hasChildren;

  bool get isHeader => type == DashboardMenuItemType.header;
  bool get isItem => type == DashboardMenuItemType.item;

  static const Map<String, IconData> _iconMap = {
    'bolt': Icons.bolt,
    'search': Icons.search,
    'receipt_long': Icons.receipt_long,
    'history': Icons.history,
  };
}
