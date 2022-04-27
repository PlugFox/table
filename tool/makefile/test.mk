.PHONY: test coverage check fix format

test: get
	@flutter test --no-pub --concurrency=6 --coverage test/all_test.dart

coverage: test
	@genhtml -o coverage coverage/lcov.info

check:
	@dart format --set-exit-if-changed .
	@dart analyze --fatal-infos --fatal-warnings .
	@pana --json --no-warning --line-length 80

fix: format

format:
	@dart fix --apply .
	@dart format -l 80 --fix .

test-beta:
	@docker run --rm -it \
		-v ${PWD}:/package \
		-v ${PWD}/tool/script/test.sh:/package/test.sh \
		--user root --workdir /package --name dart_beta \
			plugfox/flutter:beta ./test.sh 1> $(PWD)/.log.txt
