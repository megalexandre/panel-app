import 'package:acal/features/auth/presentation/auth_notifier.dart';
import 'package:acal/features/auth/presentation/pages/login_page.dart';
import 'package:acal/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:go_router/go_router.dart';

abstract final class AppRoutes {
  static const login = '/login';
  static const dashboard = '/dashboard';
}

GoRouter buildRouter(AuthNotifier auth) {
  return GoRouter(
    refreshListenable: auth,
    initialLocation: AppRoutes.login,
    redirect: (context, state) {
      final authenticated = auth.authenticated;

      // ainda carregando — não redireciona
      if (authenticated == null) return null;

      final onLogin = state.matchedLocation == AppRoutes.login;

      if (!authenticated && !onLogin) return AppRoutes.login;
      if (authenticated && onLogin) return AppRoutes.dashboard;
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => LoginPage(
          onLogin: ({required email, required password}) =>
              auth.login(email: email, password: password),
        ),
      ),
      GoRoute(
        path: AppRoutes.dashboard,
        builder: (context, state) => DashboardPage(
          onLogout: auth.logout,
          userEmail: auth.userEmail,
        ),
      ),
    ],
  );
}
