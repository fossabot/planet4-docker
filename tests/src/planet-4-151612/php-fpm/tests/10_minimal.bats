#!/usr/bin/env bats
set -e

load env

function setup {
  begin_output
}

function teardown {
  store_output
}

# @test "image exists ${IMAGE_NAMESPACE}/${BATS_PROJECT_ID}/${BATS_IMAGE}:${IMAGE_TAG}" {
#   run run_test_image_exists "${IMAGE_NAMESPACE}/${BATS_PROJECT_ID}/${BATS_IMAGE}.*${IMAGE_TAG}"
#   [[ $status -eq 0 ]]
# }

@test "service starts with minimal config" {
  run test_minimal_startup
  [ $status -eq 0 ]
}

@test "print service environment" {
  run print_docker_env "${image}"
  [ $status -eq 0 ]
}

@test "service responds ok to health checks" {
  run test_fastcgi_response
  [ $status -eq 0 ]
  printf '%s' "$output" | grep "ok"
}

@test "service responds with PHP Version x.x.x" {
  run test_fastcgi_response "/app/source/public/index.php"
  [ $status -eq 0 ]
  version_detect="[[:digit:]]+\\.[[:digit:]]+\\.[[:digit:]]+"
  printf '%s' "$output" | grep -E "PHP Version ${version_detect}"
}

@test "service errors 404 on non-existent file" {
  run test_fastcgi_response "/app/source/public/error.php"
  printf '%s' "$output" | grep -Eq "Status: 404 Not Found"
  echo "$output" > "${ARTIFACT_LOGS_DIR}/${BATS_IMAGE}.error.php"
}

@test "minimal service cleans up" {
  run test_minimal_cleanup
  [ $status -eq 0 ]
}
