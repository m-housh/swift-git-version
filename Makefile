DOCC_TARGET ?= GitVersion
DOCC_BASEPATH = $(shell basename "$(PWD)")
DOCC_DIR ?= ./docs

clean:
	rm -rf .build

build-and-run:
	swift run -c release build-example
	./.build/release/example --help
	./.build/release/example

build-documentation:
	swift package \
		--allow-writing-to-directory "$(DOCC_DIR)" \
		generate-documentation \
		--target "$(DOCC_TARGET)" \
		--disable-indexing \
		--transform-for-static-hosting \
		--hosting-base-path "$(DOCC_BASEPATH)" \
		--output-path "$(DOCC_DIR)"

preview-documentation:
	swift package \
		--disable-sandbox \
		preview-documentation \
		--target "$(DOCC_TARGET)"

test-linux:
	docker run --rm \
		--volume "$(PWD):$(PWD)" \
		--workdir "$(PWD)" \
		swift:5.7-focal \
		swift test


