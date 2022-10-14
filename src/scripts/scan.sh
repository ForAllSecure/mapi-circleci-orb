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
[[ -n $HTML_REPORT ]] && params+=("--html") && params+=("${HTML_REPORT}") && mkdir -p "$(dirname "$HTML_REPORT")"
[[ -n $JUNIT_REPORT ]] && params+=("--junit") && params+=("${JUNIT_REPORT}") && mkdir -p "$(dirname "$JUNIT_REPORT")"
[[ -n $SARIF_REPORT ]] && params+=("--sarif") && params+=("${SARIF_REPORT}") && mkdir -p "$(dirname "$SARIF_REPORT")"

# Remove commented lines from run args & parameterize them
[[ -n $RUN_ARGS ]] && RUN_ARGS=$(sed '/^#/d' <<<"${RUN_ARGS}") && readarray -t run_args <<<"${RUN_ARGS}"

# Create binary folder
mkdir -p "${MAPI_PATH}"

# Download binary
curl -Lo "${MAPI}" "https://mayhem4api.forallsecure.com/downloads/cli/${MAPI_VERSION}/linux-musl/mapi" \
  && chmod +x "${MAPI}"

${MAPI} run --url "${API_URL}" "${TARGET}" "${DURATION}" "${API_SPEC}" "${params[@]}" "${run_args[@]}"