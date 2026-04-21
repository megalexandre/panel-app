import 'package:acal/validators/app_validators.dart';
import 'package:flutter/material.dart';

const double _desktopBreakpoint = 800;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailContoller = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailContoller.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= _desktopBreakpoint;
            final content = _buildLoginForm(theme, isDesktop);

            if (!isDesktop) {
              return Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: content,
                ),
              );
            }

            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1180),
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      border: Border.all(
                        color: theme.colorScheme.outlineVariant,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 24,
                          offset: const Offset(0, 16),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: _LoginBanner(theme: theme),
                        ),
                        Expanded(
                          child: Center(
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.all(48),
                              child: content,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoginForm(ThemeData theme, bool isDesktop) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: isDesktop ? 420 : 480),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Entrar',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Use seu e-mail e senha para acessar sua conta.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _emailContoller,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'E-mail'),
              validator: AppValidators.email,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: 'Senha',
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Informe sua senha';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  final isValid = _formKey.currentState!.validate();
                  final messenger = ScaffoldMessenger.of(context);

                  messenger.hideCurrentSnackBar();
                  messenger.showSnackBar(
                    SnackBar(
                      content: Text(
                        isValid
                            ? 'Login enviado para validacao.'
                            : 'Preencha os campos para continuar.',
                      ),
                    ),
                  );
                },
                child: const Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginBanner extends StatelessWidget {
  const _LoginBanner({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(56),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.lock_person_rounded,
              size: 72,
              color: theme.colorScheme.onPrimary,
            ),
            const SizedBox(height: 24),
            Text(
              'Acesse com seguranca',
              style: theme.textTheme.headlineLarge?.copyWith(
                color: theme.colorScheme.onPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Gerencie seu acesso em uma interface pensada para telas grandes, sem comprometer a experiencia no mobile.',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onPrimary.withValues(alpha: 0.88),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
