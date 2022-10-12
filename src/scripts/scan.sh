#!/bin/bash
docker run -it \
  -e MAPI_TOKEN=<< parameters.mapi-token >> \
  -e GITHUB_TOKEN=<< parameters.github-token >> \
  -e POSTMAN_ENVIRONMENT=<< parameters.postman-environment-id >> \
  -e POSTMAN_API_KEY=<< parameters.postman-api-key >> \
  forallsecure/mapi:latest \
  --url <<parameters.api-url >> \
  << parameters.api-spec >>