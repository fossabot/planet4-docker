SHELL := /bin/bash
BUILD_FLAGS ?= -rp
BUILD_LIST ?=

ifneq ($(strip $(CONFIG)),)
CONFIG := -c $(CONFIG)
endif

TEST_FOLDERS ?=

.DEFAULT_GOAL := all

all : build test
.PHONY : all

.PHONY: lint
lint:
		find . -type f -name '*.yaml' | xargs yamllint
		find . -type f -name '*.yml' | xargs yamllint

.PHONY : clean
clean :
		bin/clean.sh

.PHONY : pull
pull :
		pushd bin >/dev/null; ./build.sh -p; popd > /dev/null

.PHONY : build
build : lint
		bin/build.sh $(CONFIG) $(BUILD_FLAGS) $(BUILD_LIST)

.PHONY : test
test :
		TEST_FOLDERS=$(TEST_FOLDERS) tests/test.sh $(CONFIG)

deploy:
	  ./bin/deploy.sh
