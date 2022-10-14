# Orb Template


[![CircleCI Build Status](https://circleci.com/gh/ForAllSecure/mapi-circleci-orb.svg?style=shield "CircleCI Build Status")](https://circleci.com/gh/ForAllSecure/mapi-circleci-orb) [![CircleCI Orb Version](https://badges.circleci.com/orbs/forallsecure/mapi.svg)](https://circleci.com/orbs/registry/orb/forallsecure/mapi) [![GitHub License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/ForAllSecure/mapi-circleci-orb/master/LICENSE) [![CircleCI Community](https://img.shields.io/badge/community-CircleCI%20Discuss-343434.svg)](https://discuss.circleci.com/c/ecosystem/orbs)



# Mayhem for API CircleCI Orb

[![Mayhem for API](https://mayhem4api.forallsecure.com/downloads/img/mapi-logo-full-color.svg)](http://mayhem4api.forallsecure.com/signup)

A CircleCI orb for using Mayhem for API to check for reliability,
performance and security issues in your APIs.

## About Mayhem for API

🧪 Modern App Testing: Mayhem for API is a dynamic testing tool that
catches reliability, performance and security bugs before they hit
production.

🧑‍💻 For Developers, by developers: The engineers building
software are the best equipped to fix bugs, including security bugs. As
engineers ourselves, we're building tools that we wish existed to make
our job easier!

🤖 Simple to Automate in CI: Tests belong in CI, running on every commit
and PRs. We make it easy, and provide results right in your PRs where
you want them. Adding Mayhem for API to a DevOps pipeline is easy.

Want to try it? [Sign up for free](http://mayhem4api.forallsecure.com/signup) today!

## Usage

Add the `forallsecure/mapi` orb to your `.circleci/config.yml` and add the configured `mapi/scan` job to your workflow.

```
version: 2.1
orbs:
  mapi: forallsecure/mapi@1.0.0
workflows:
  security:
    jobs:
      - mapi/scan:
          api-url: http://localhost:8000
          api-spec: your-openapi-spec-or-postman-collection.json
          sarif-report: "/tmp/mapi/report.sarif"
          run-args: |
            # Basic Auth
            --basic-auth
            login:password
            # Treat all warnings as errors
            --warnaserror
```