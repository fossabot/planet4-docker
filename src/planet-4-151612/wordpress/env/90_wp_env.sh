#!/usr/bin/env bash
set -eao pipefail

# WP base configuration
# FIXME should these variables ship with default values?
WP_DB_NAME="${WP_DB_NAME:-${MYSQL_DATABASE:-}}"
WP_DB_PASS="${WP_DB_PASS:-${MYSQL_PASSWORD:-}}"
WP_DB_USER="${WP_DB_USER:-${MYSQL_USER:-}}"
# do not reorder to alphanumeric
WP_HOSTNAME="${WP_HOSTNAME:-${APP_HOSTNAME}}"
WP_SITE_URL="${WP_SITE_URL:-${WP_HOSTNAME:-}}"
WP_SITE_HOME="${WP_SITE_HOME:-${WP_SITE_URL:-}}"

# If the site is installed in a subdirectory, ensure it has a leading /
[[ -z $APP_HOSTPATH ]] || APP_HOSTPATH="/${APP_HOSTPATH#/}"
export APP_HOSTPATH

export WP_DB_NAME
export WP_DB_PASS
export WP_DB_USER
export WP_HOSTNAME
export WP_SITE_HOME
export WP_SITE_URL
