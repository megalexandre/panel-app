
.PHONY: test test-headless test-verbose test-headless-verbose test-one test-debug test-debug-paused

test:
	./scripts/run_integration_tests.sh

test-headless:
	xvfb-run -a ./scripts/run_integration_tests.sh

test-verbose:
	AUTH_API_VERBOSE=1 ./scripts/run_integration_tests.sh

test-headless-verbose:
	AUTH_API_VERBOSE=1 xvfb-run -a ./scripts/run_integration_tests.sh

test-one:
	@if [ -z "$(FILE)" ]; then echo "Uso: make test-one FILE=login_test.dart"; exit 1; fi
	TEST_FILE="$(FILE)" ./scripts/run_integration_tests.sh

test-debug:
	@if [ -z "$(FILE)" ]; then echo "Uso: make test-debug FILE=login_test.dart [NAME='nome do cenario']"; exit 1; fi
	AUTH_API_VERBOSE=1 VERBOSE_TEST_OUTPUT=1 TEST_FILE="$(FILE)" TEST_NAME="$(NAME)" ./scripts/run_integration_tests.sh

test-debug-paused:
	@if [ -z "$(FILE)" ]; then echo "Uso: make test-debug-paused FILE=login_test.dart [NAME='nome do cenario']"; exit 1; fi
	AUTH_API_VERBOSE=1 VERBOSE_TEST_OUTPUT=1 START_PAUSED=1 TEST_FILE="$(FILE)" TEST_NAME="$(NAME)" ./scripts/run_integration_tests.sh
