class ApiRoutes {
  static const String _runtimeBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: '__RUNTIME_API_BASE_URL__',
  );

  static String get defaultBaseUrl {
    if (_runtimeBaseUrl.startsWith('__RUNTIME_')) {
      return 'https://app.project-deploy.shop/api';
    }

    return _runtimeBaseUrl;
  }
}
