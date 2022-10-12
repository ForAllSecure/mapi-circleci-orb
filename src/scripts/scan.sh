#!/bin/bash
docker run -it \
  --env MAPI_TOKEN \
  --env GITHUB_TOKEN \
  --env POSTMAN_ENVIRONMENT \
  --env POSTMAN_API_KEY \
  forallsecure/mapi:latest \
  --url "${API_URL}" \
  "${API_SPEC}"