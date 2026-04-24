import 'package:flutter/material.dart';

class DashboardTopBar extends StatelessWidget implements PreferredSizeWidget {
  const DashboardTopBar({super.key, required this.onLogout});

  final Future<void> Function() onLogout;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      title: Text(
        'Dashboard',
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w700,
          color: theme.colorScheme.onPrimary,
        ),
      ),
      actions: [
        IconButton(
          tooltip: 'Sair',
          icon: const Icon(Icons.logout),
          onPressed: onLogout,
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
