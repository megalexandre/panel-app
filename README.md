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