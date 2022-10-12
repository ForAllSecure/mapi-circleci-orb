# Mayhem for API CircleCI Orb

[![Mayhem for API](https://mayhem4api.forallsecure.com/downloads/img/mapi-logo-full-color.svg)](http://mayhem4api.forallsecure.com/signup)

A CircleCI orb for using Mayhem for API to check for reliability,
performance and security issues in your APIs.

## @orb.yml

This is the entry point for our orb "tree", which becomes our `orb.yml` file later.

Within the `@orb.yml` we generally specify 4 configuration keys

**Keys**

1. **version**
    Specify version 2.1 for orb-compatible configuration `version: 2.1`
2. **description**
    Give your orb a description. Shown within the CLI and orb registry
3. **display**
    Specify the `home_url` referencing documentation or product URL, and `source_url` linking to the orb's source repository.
4. **orbs**
    (optional) Some orbs may depend on other orbs. Import them here.

## See:
 - [Orb Author Intro](https://circleci.com/docs/2.0/orb-author-intro/#section=configuration)
 - [Reusable Configuration](https://circleci.com/docs/2.0/reusing-config)
