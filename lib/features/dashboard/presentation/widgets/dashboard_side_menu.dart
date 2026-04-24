import 'package:acal/features/dashboard/domain/dashboard_menu_item.dart';
import 'package:flutter/material.dart';

const double _sidebarWidth = 220;

/// Sidebar de navegação — versão desktop (coluna fixa lateral).
class DashboardSideMenu extends StatelessWidget {
  const DashboardSideMenu({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onSelect,
  });

  final List<DashboardMenuItem> items;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.secondaryContainer;

    return SizedBox(
      width: _sidebarWidth,
      child: ColoredBox(
        color: color,
        child: _SideMenuContent(
          items: items,
          selectedIndex: selectedIndex,
          onSelect: onSelect,
        ),
      ),
    );
  }
}

/// Gaveta de navegação — versão mobile.
class DashboardDrawer extends StatelessWidget {
  const DashboardDrawer({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onSelect,
    required this.onLogout,
  });

  final List<DashboardMenuItem> items;
  final int selectedIndex;
  final ValueChanged<int> onSelect;
  final Future<void> Function() onLogout;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Drawer(
      width: _sidebarWidth,
      backgroundColor: colorScheme.secondaryContainer,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _SideMenuContent(
                items: items,
                selectedIndex: selectedIndex,
                onSelect: (i) {
                  onSelect(i);
                  Navigator.of(context).pop();
                },
              ),
            ),
            const Divider(height: 1),
            _MenuItem(
              icon: Icons.logout,
              label: 'Sair',
              selected: false,
              hasChildren: false,
              onTap: () => onLogout(),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Conteúdo compartilhado
// ---------------------------------------------------------------------------

class _SideMenuContent extends StatelessWidget {
  const _SideMenuContent({
    required this.items,
    required this.selectedIndex,
    required this.onSelect,
  });

  final List<DashboardMenuItem> items;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: items.length,
      itemBuilder: (context, i) {
        final item = items[i];

        if (item.isHeader) {
          return _SectionHeader(label: item.label);
        }

        return _MenuItem(
          icon: item.icon!,
          label: item.label,
          selected: selectedIndex == i,
          hasChildren: item.hasChildren,
          onTap: () => onSelect(i),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Cabeçalho de seção
// ---------------------------------------------------------------------------

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.45);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
          color: color,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Item de menu
// ---------------------------------------------------------------------------

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.hasChildren,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final bool hasChildren;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final foreground = selected ? colorScheme.primary : colorScheme.onSurface.withValues(alpha: 0.75);
    final bgColor = selected ? colorScheme.primary.withValues(alpha: 0.1) : Colors.transparent;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
      child: Material(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                Icon(icon, size: 18, color: foreground),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: textTheme.bodyMedium?.copyWith(
                      color: foreground,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (hasChildren) ...[
                  const SizedBox(width: 4),
                  Icon(
                    Icons.chevron_right,
                    size: 16,
                    color: colorScheme.onSurface.withValues(alpha: 0.35),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

