---
title: Automated building with CircleCI
date: 2018-10-02 20:57 UTC
tags: development
keywords: CircleCI, Github
---

I've started using [CircleCI]() to automatically build repos - specifically my various static websites.
It's working really well. CircleCI will detect a change to the Github repo, automatically trigger a build and then push the result to the gh-pages branch.

One tip I found useful is to use a [machine account](https://circleci.com/docs/2.0/gh-bb-integration/#enable-your-project-to-check-out-additional-private-repositories) to push to the gh-pages branch - this means that we don't need to use our actual github SSH key.
You will need machine accounts in [both[(https://github.com/DevProgress/onboarding/wiki/Using-Circle-CI-with-Github-Pages-for-Continuous-Delivery) Github and CircleCI.
For each repository that you want to build you need to add the machine account as a collaborator on the Github repository.

CircleCI will also trigger a build on the push to the gh-pages branch which is not what you want. To stop this we need to add `[ci skip]` to our commit message. In Middleman we can do this by adding `deploy.commit_message = "Automated commit at #{time} by #{signature} [ci skip]"` to our `config.ru`.
