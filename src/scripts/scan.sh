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
curl -Lo "${MAPI}" "https://app.mayhem.security/cli/mapi/linux-musl/latest/mapi" \
  && chmod +x "${MAPI}"

if [[ -n $MAPI_TESTING ]]; then
  echo "MAPI_TESTING parameter was detected.  mapi will now fail if no issues are found."
fi

# don't fail if the subshell fails (we expect it to if MAPI_TESTING is set)
set +e
# redirect output to console as well as capture it to the out var
exec 5>&1
out=$(${MAPI} run --url "${API_URL}" "${TARGET}" "${DURATION}" "${API_SPEC}" "${params[@]}" "${run_args[@]}" 2>&1 | tee /dev/fd/5 )
MAPI_EXIT_CODE=$?
# restore failure if any command fails
set -e

echo "mapi exited with code ${MAPI_EXIT_CODE}"

if [[ -n $MAPI_TESTING && $MAPI_EXIT_CODE == 1 && "$out" == *"Completed job"* ]]; then
  echo "Expected issues found in test." && exit 0
elif [[ $MAPI_EXIT_CODE != 0 && -n $IGNORE_EXIT_CODE ]]; then
  echo "Ignoring non-zero exit code returned by mapi." && exit 0
else
  exit $MAPI_EXIT_CODE
fi

