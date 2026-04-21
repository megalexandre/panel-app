# agents.md

## Objetivo
Este arquivo define como agentes e contribuidores devem organizar o projeto Flutter.

## Estrutura de pastas
Use esta organização como padrão:

```text
lib/
  app/
    app.dart
  features/
    <feature>/
      data/
      domain/
      presentation/
        pages/
  shared/
    validators/
```

## Regras de organização
- `lib/main.dart` deve conter apenas o entrypoint do app.
- `lib/app/app.dart` deve conter o widget raiz e a configuração global do `MaterialApp`.
- Cada funcionalidade nova deve ser criada dentro de `lib/features/<feature>/`.
- `data/` deve conter serviços, storages, fontes de dados e integrações externas.
- `domain/` deve conter modelos e regras centrais da feature.
- `presentation/pages/` deve conter telas e gates de navegação da feature.
- `shared/` deve conter código reutilizável entre múltiplas features.
- Validadores compartilhados devem ficar em `lib/shared/validators/`.

## Regras de nomenclatura
- Use nomes de arquivos em `snake_case`.
- Use nomes de classes em `PascalCase`.
- Sufixos recomendados:
  - `*_page.dart` para telas
  - `*_service.dart` para serviços
  - `*_storage.dart` para persistência local
  - `*_tokens.dart` ou `*_model.dart` para modelos

## Autenticação
A feature de autenticação deve permanecer em `lib/features/auth/` com esta divisão:
- `data/auth_service.dart`
- `data/auth_storage.dart`
- `domain/auth_tokens.dart`
- `presentation/pages/auth_gate.dart`
- `presentation/pages/login_page.dart`

## Testes
- Testes devem espelhar a estrutura de `lib/` dentro de `test/`.
- Código em `lib/shared/validators/` deve ser testado em `test/shared/validators/`.

## Manutenção
- Não criar pastas genéricas como `screen/`, `utils/` ou `core/` sem necessidade clara.
- Antes de adicionar uma pasta nova, preferir encaixar o código em `features/` ou `shared/`.
- Remover diretórios vazios após mover arquivos.
- Após mudanças estruturais, executar `flutter analyze` e os testes afetados.
