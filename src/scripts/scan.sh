#!/bin/bash

printenv

MAPI="${MAPI_PATH}/mapi"

mkdir -p "${MAPI_PATH}"

# Download executable
curl -Lo "${MAPI}" "https://mayhem4api.forallsecure.com/downloads/cli/${MAPI_VERSION}/linux-musl/mapi" \
  && chmod +x "${MAPI}"

${MAPI} run --url "${API_URL}" "${TARGET}" "${DURATION}" "${API_SPEC}"