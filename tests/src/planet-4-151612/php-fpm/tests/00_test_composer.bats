#!/usr/bin/env bats
set -e

load env

function setup {
  begin_output
}

function teardown {
  store_output
}

@test "composer --version" {
  run run_docker_binary "$image" composer --no-ansi --version
  [ $status -eq 0 ]
  printf '%s' "$output" | grep -Eq "Composer version [[:digit:]]+\\.[[:digit:]]+"
}
