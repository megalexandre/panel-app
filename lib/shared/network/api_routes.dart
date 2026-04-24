class ApiRoutes {
  static const String defaultBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://app.project-deploy.shop/api/api',
  );
}
