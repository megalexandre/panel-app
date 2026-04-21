class AppValidators {
  
  static final RegExp _emailRegex = RegExp(
    r'^[^\s@]+@[^\s@]+\.[^\s@]+$',
  );

  static String? email(String? value) {
    final email = value?.trim() ?? '';

    if (email.isEmpty) {
      return 'Informe seu e-mail';
    }

    if (!_emailRegex.hasMatch(email)) {
      return 'Informe um e-mail valido';
    }

    return null;
  }
}