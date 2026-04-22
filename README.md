## Testes de Integracao

### 1) Subir o WireMock

```bash
docker compose up -d wiremock
```

### 2) Rodar teste de integracao (Linux)

```bash
flutter test integration_test -d linux
```

### 3) Rodar em modo headless (CI/Linux sem display)

```bash
xvfb-run -a flutter test integration_test -d linux
```

Se `xvfb-run` nao estiver instalado:

```bash
sudo apt-get update && sudo apt-get install -y xvfb
```