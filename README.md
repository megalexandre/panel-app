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

## Build e Empacotamento

### Gerar versao Android (APK release)

```bash
flutter build apk --release
```

### Gerar versao Linux (bundle release)

```bash
flutter pub get
flutter build linux --release
```

Saida do bundle:

```text
build/linux/x64/release/bundle/
```

### Gerar pacote .deb (Linux)

Passo a passo para criar um instalador Debian a partir do bundle Linux:

1. Gere o bundle release:

```bash
flutter pub get
flutter build linux --release
```

2. Monte a estrutura Debian, copie o bundle e gere o pacote:

```bash
APP_NAME=acal
APP_VERSION=$(grep '^version:' pubspec.yaml | awk '{print $2}')
ARCH=amd64
PKG_ROOT=dist/deb/${APP_NAME}_${APP_VERSION}_${ARCH}

rm -rf "$PKG_ROOT"
mkdir -p "$PKG_ROOT/DEBIAN" "$PKG_ROOT/opt/$APP_NAME" "$PKG_ROOT/usr/bin" "$PKG_ROOT/usr/share/applications"

cp -a build/linux/x64/release/bundle/. "$PKG_ROOT/opt/$APP_NAME/"

cat > "$PKG_ROOT/usr/bin/$APP_NAME" << 'EOF'
#!/usr/bin/env sh
exec /opt/acal/acal "$@"
EOF
chmod 755 "$PKG_ROOT/usr/bin/$APP_NAME"

cat > "$PKG_ROOT/usr/share/applications/$APP_NAME.desktop" << 'EOF'
[Desktop Entry]
Type=Application
Name=Acal
Exec=acal
Terminal=false
Categories=Utility;
EOF

cat > "$PKG_ROOT/DEBIAN/control" << EOF
Package: $APP_NAME
Version: $APP_VERSION
Section: utils
Priority: optional
Architecture: $ARCH
Maintainer: alex <alex@local>
Depends: libc6 (>= 2.31), libgtk-3-0
Description: Acal Flutter desktop application
EOF

dpkg-deb --build "$PKG_ROOT"
```

3. O arquivo .deb sera gerado em:

```text
dist/deb/acal_<versao>_amd64.deb
```

4. Instale localmente para validar:

```bash
sudo dpkg -i dist/deb/acal_<versao>_amd64.deb
```

Se houver dependencias pendentes:

```bash
sudo apt-get -f install
```

Painel do WireMock:

```text
http://localhost:8080/__admin/mappings
```