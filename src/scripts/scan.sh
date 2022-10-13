#!/bin/bash

# The CircleCI orb can override the names of these environment variables
export MAPI_TOKEN="${!MAPI_TOKEN_NAME}"
export POSTMAN_API_KEY="${!POSTMAN_API_KEY_NAME}"
export GITHUB_TOKEN="${!GITHUB_TOKEN_NAME}"
TARGET="${TARGET:-$CIRCLE_PROJECT_REPONAME}"

MAPI="${MAPI_PATH}/mapi"

mkdir -p "${MAPI_PATH}"

# Download executable
curl -Lo "${MAPI}" "https://mayhem4api.forallsecure.com/downloads/cli/${MAPI_VERSION}/linux-musl/mapi" \
  && chmod +x "${MAPI}"

${MAPI} run --url "${API_URL}" "${TARGET}" "${DURATION}" "${API_SPEC}"