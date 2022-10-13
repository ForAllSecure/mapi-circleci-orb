#!/bin/bash

# The CircleCI orb can override the names of these environment variables
export MAPI_TOKEN="${!MAPI_TOKEN_NAME}"
export POSTMAN_API_KEY="${!POSTMAN_API_KEY_NAME}"
export GITHUB_TOKEN="${!GITHUB_TOKEN_NAME}"

# Default the target to the circle ci repo name
TARGET="${TARGET:-$CIRCLE_PROJECT_REPONAME}"

MAPI="${MAPI_PATH}/mapi"

params=()
[[ $ZAP_API_SCAN == 1 ]] && params+=(--zap)

echo "${params[@]}"

mkdir -p "${MAPI_PATH}"

# Download executable
curl -Lo "${MAPI}" "https://mayhem4api.forallsecure.com/downloads/cli/${MAPI_VERSION}/linux-musl/mapi" \
  && chmod +x "${MAPI}"

${MAPI} run "${params[@]}" --url "${API_URL}" "${TARGET}" "${DURATION}" "${API_SPEC}"