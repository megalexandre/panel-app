class AppValidators {
  
  static String? email(String? value) {
    final email = value?.trim() ?? '';

    final emailRegex = RegExp(
      r'^[^\s@]+@[^\s@]+\.[^\s@]+$'
    );

    if (email.isEmpty) {
      return 'Informe seu e-mail';
    }

    if (!emailRegex.hasMatch(email)) {
      return 'Informe um e-mail valido';
    }

    return null;
  }
}