import 'package:acal/features/dashboard/data/dashboard_menu_config.dart';
import 'package:acal/features/dashboard/domain/dashboard_menu_item.dart';
import 'package:acal/features/dashboard/presentation/widgets/dashboard_footer.dart';
import 'package:acal/features/dashboard/presentation/widgets/dashboard_side_menu.dart';
import 'package:acal/features/dashboard/presentation/widgets/dashboard_top_bar.dart';
import 'package:acal/features/queries/presentation/pages/queries_page.dart';
import 'package:acal/features/report/presentation/pages/report_page.dart';
import 'package:flutter/material.dart';

const double _desktopBreakpoint = 800;

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key, required this.onLogout, this.userEmail});

  final Future<void> Function() onLogout;
  final String? userEmail;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  List<DashboardMenuItem> _menuItems = [];

  @override
  void initState() {
    super.initState();
    _loadMenu();
  }

  Future<void> _loadMenu() async {
    final items = await DashboardMenuConfig.load();
    if (!mounted) return;
    setState(() => _menuItems = items);
  }

  String get _selectedId {
    final items = _menuItems.where((i) => i.isItem).toList();
    if (_selectedIndex < 0 || _selectedIndex >= items.length) return '';
    return items[_selectedIndex].id;
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.sizeOf(context).width >= _desktopBreakpoint;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DashboardTopBar(onLogout: widget.onLogout),
      drawer: isDesktop
          ? null
          : DashboardDrawer(
              items: _menuItems,
              selectedIndex: _selectedIndex,
              onSelect: (i) {
                setState(() => _selectedIndex = i);
                Navigator.of(context).pop();
              },
              onLogout: widget.onLogout,
            ),
      bottomNavigationBar: DashboardFooter(userEmail: widget.userEmail),
      body: Row(
        children: [
          if (isDesktop)
            DashboardSideMenu(
              items: _menuItems,
              selectedIndex: _selectedIndex,
              onSelect: (i) => setState(() => _selectedIndex = i),
            ),
          Expanded(child: _pageForId(_selectedId)),
        ],
      ),
    );
  }
}

Widget _pageForId(String id) => switch (id) {
      'relatorio' => const ReportPage(),
      'consultas' => const QueriesPage(),
      _ => const SizedBox.shrink(),
    };
