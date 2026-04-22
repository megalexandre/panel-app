## Testes de Integracao

### 1) Subir o WireMock

```bash
docker compose up -d wiremock
```

### 2) Rodar teste de integracao (Linux)

Use o alvo abaixo para rodar tudo de forma sequencial e estavel (WireMock + build_runner + testes):

```bash
make test
```

Se quiser logs mais detalhados das chamadas HTTP, incluindo um `curl` reproduzivel para cada request:

```bash
make test-verbose
```

Para debug rapido de um unico arquivo de teste:

```bash
make test-one FILE=login_test.dart
```

Para debug com logs expandidos e filtro por nome de cenario:

```bash
make test-debug FILE=login_test.dart NAME="Login with valid credentials should call API {1} time and redirect"
```

Para iniciar pausado e anexar debugger:

```bash
make test-debug-paused FILE=login_test.dart NAME="Login with valid credentials should call API {1} time and redirect"
```

### 2.1) Debug com breakpoints no VS Code

Quando precisar inspecionar variaveis e navegar linha a linha, use o debugger do VS Code:

1. Atualize os arquivos gerados:

```bash
dart run build_runner build --delete-conflicting-outputs
```

2. Abra um arquivo de teste gerado em `integration_test/features/auth/presentation/bdd/generated/`.
3. Coloque breakpoints no proprio teste ou nos steps em `integration_test/features/auth/presentation/bdd/steps/`.
4. Abra o painel Run and Debug e rode a configuracao `Debug Integration Test (arquivo atual)`.
5. Passo de run de launch: pressione `F5` (ou clique em `Run and Debug` > botao `Start Debugging`) com a configuracao selecionada.

Configuracoes prontas de debug ficam em `.vscode/launch.json`, incluindo atalhos para:
- `Debug Login Integration Test`
- `Debug Login Failed Integration Test`

Se quiser rodar manualmente, gere/atualize os arquivos derivados dos `.feature` e execute os testes:

```bash
dart run build_runner build --delete-conflicting-outputs
```

```bash
flutter test integration_test -d linux
```

### 3) Rodar em modo headless (CI/Linux sem display)

```bash
make test-headless
```

Modo headless com logs verbosos:

```bash
make test-headless-verbose
```

Se `xvfb-run` nao estiver instalado:

```bash
sudo apt-get update && sudo apt-get install -y xvfb
```


para gerar para android 
flutter build apk --release