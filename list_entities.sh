#!/usr/bin/env bash

# Assumes the following tools are installed
# * curl - tested against version 7.64.1
# * jq - tested against version 1.6 (https://stedolan.github.io/jq)
# * HTTPie - tested against version 2.1.0 (https://httpie.org/)

# Will exit script if we would use an uninitialised variable (nounset) or when a
# simple command (not a control structure) fails (errexit)
set -eu

function print_error() {
  read -r line file <<<"$(caller)"
  echo "An error occurred in line ${line} of file ${file}:" >&2
  sed "${line}q;d" "${file}" >&2
}

trap print_error ERR

if ! [[ -x "$(command -v http)" ]]; then
  echo 'HTTPie is required. Please install from https://httpie.org/ and try again.'
  exit 1
fi

if ! [[ -x "$(command -v jq)" ]]; then
  echo 'jq is required. Please install from https://stedolan.github.io/jq and try again.'
  exit 1
fi

# Get directory this script is located in to access script local files
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

source "${SCRIPT_DIR}/setenv.sh"

# Get temporaray session token
SESSION_AUTH_RESULT=$(
  http --json --body POST "${BASE_URL}/user/authenticate" \
    "email=${ADMIN_EMAIL}" \
    "password=${ADMIN_PASSWORD}"
)

if [[ "${SESSION_AUTH_RESULT}" == *'Not authorized'* ]]; then
  printf "Invalid Credentials\n"
  exit
fi

SESSION_API_KEY=$(jq --raw-output '.session_token' <<<"${SESSION_AUTH_RESULT}")

printf "\nDevices\n"

http --json GET "${BASE_URL}/devices" \
  "Authorization:${SESSION_API_KEY}"

printf "\nDevice Types\n"

http --json GET "${BASE_URL}/device_types" \
  "Authorization:${SESSION_API_KEY}"

printf "\nIngestors\n"

http --json GET "${BASE_URL}/ingestors" \
  "Authorization:${SESSION_API_KEY}"

printf "\nTranslators\n"

http --json GET "${BASE_URL}/translators" \
  "Authorization:${SESSION_API_KEY}"

printf "\nRules\n"

http --json GET "${BASE_URL}/rules" \
  "Authorization:${SESSION_API_KEY}"