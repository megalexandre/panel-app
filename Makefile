
.PHONY: test test-headless test-verbose test-headless-verbose

test:
	./scripts/run_integration_tests.sh

test-headless:
	xvfb-run -a ./scripts/run_integration_tests.sh

test-verbose:
	AUTH_API_VERBOSE=1 ./scripts/run_integration_tests.sh

test-headless-verbose:
	AUTH_API_VERBOSE=1 xvfb-run -a ./scripts/run_integration_tests.sh
