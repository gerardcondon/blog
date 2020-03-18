---
title: "Setting up a static site with basic web authentication"
date: 2020-03-18 08:00
tags: heroku, development
---

I have some Gitbooks created for notes that I've taken on various programming books or courses down throughout the years. I didn't want to put these up on a Github pages site as notes like that probably violate copyright. So I wanted some way to hide them behind authentication so that only I could see them.

My initial thinking is that I would need some kind of server to respond to requests and only serve the content if needed. You could probably do this with S3 or some other AWS service but I'm paranoid about using those as even if you think you are within the free tier, you could still be hit with a bill for unexpected usage. I didn't trust that my site would always be configured correctly enough to avoid that. Then next I considered a site that would give me enough free CPU to run a basic server. Enter [Heroku](https://www.heroku.com).

I tried to use the [Jekyll Auth](https://github.com/benbalter/jekyll-auth) plugin but couldn't get it working.

* The gem released on rubygems is out of date and clashes with the dependencies in Jekyll 4.0. On the upside this did teach me how to include a [gem](https://bundler.io/guides/git.html) directly from Github. If the repository in question has a `.gemspec` file at the root level then you can use the `git` option and pass the url of the repo e.g. `gem 'jekyll-auth', git: "https://github.com/benbalter/jekyll-auth"`
* Even after getting everything configured I was getting denied when trying to authenticate with my Github account. It looked similar to this [issue](https://github.com/benbalter/jekyll-auth/issues/141) which didn't get resolved so I decided to try something else.

**Heroku Buildpack**

I tried a different approach which was to get Heroku to serve the files and then use http basic authentication to protect them. Heroku has a [buildpack](https://github.com/heroku/heroku-buildpack-static) for static sites. This is marked as experimental but it worked fine for me. Hopefully they won't remove it.

* I used the guide [here](https://blog.heroku.com/jekyll-on-heroku) to get a basic Jekyll installation up and running on Heroku. This worked pretty much as outlined.
* Then I add http basic authentication as outlined in the relevant [section](https://github.com/heroku/heroku-buildpack-static#basic-authentication) on the Heroku build pack page. You add the option to the static.json file and specify the username and password that you want in env variables. I only wanted a single user i.e. me so I'm not sure if this approach scales to multiple users. I think it does via htpasswd files. To set the password you must first run it through a tool to generate a hash that [htpasswd](https://httpd.apache.org/docs/2.4/programs/htpasswd.html) can accept. I used `openssl passwd -apr1 <password_plaintext>`. Then you set the env variable `BASIC_AUTH_PASSWORD` to be this value. This didn't work for me from the command line - probably some characters that needed escaping - so I just set it via the web interface.

Some misc Heroku issues that I ran into.

* I work on WSL and the snap approach for installation didn't work for me so I used the curl script. This mostly worked, however the [permissions](https://github.com/heroku/cli/issues/1160) on a couple of folders were set to root so I had to chown these back to my normal account.
* I got errors about an app that I thought I had deleted. However the Heroku CLI adds a remote to the git repo pointing to the app so even if you delete the app, make sure that the remote is deleted also.

In the end this worked out fine - a lot easier than I expected and I have a website hidden behind authentication. The dyno that the website is on goes to sleep if not used for a while so the initial request for a page can be slow if the dyno is loading up but it's still only a few seconds. Now that I have a server on Heroku I look forward to seeing what else I can do with it.