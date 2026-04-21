import 'package:acal/shared/validators/app_validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppValidators.email', () {
    test('retorna erro quando valor e nulo', () {
      expect(AppValidators.email(null), 'Informe seu e-mail');
    });

    test('retorna erro quando valor esta vazio', () {
      expect(AppValidators.email(''), 'Informe seu e-mail');
    });

    test('retorna erro quando valor contem apenas espacos', () {
      expect(AppValidators.email('   '), 'Informe seu e-mail');
    });

    test('retorna erro quando e-mail nao tem formato valido', () {
      expect(AppValidators.email('alex'), 'Informe um e-mail valido');
      expect(AppValidators.email('alex@'), 'Informe um e-mail valido');
      expect(AppValidators.email('alex@site'), 'Informe um e-mail valido');
    });

    test('retorna null quando e-mail e valido', () {
      expect(AppValidators.email('alex@site.com'), isNull);
    });

    test('ignora espacos nas extremidades para e-mail valido', () {
      expect(AppValidators.email('  alex@site.com  '), isNull);
    });
  });
}
