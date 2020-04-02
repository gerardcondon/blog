---
title: "Setting up a static site with basic web authentication"
date: 2020-04-02 18:00
tags: heroku, development
---
Moving on from my initial Heroku experiment, I removed the Jekyll site and now have the bare minimum required for hosting content requiring authentication on Heroku

1. Create a new Heroku app
2. Add the [static site buildpack]
3. Create a folder (I called mine static) and create a file called `static.json` with the following contents
```
{
  "clean_urls": true,
  "https_only": true,
  "root": "static/",
  "basic_auth": true
}
```
4. Set two environment variables `BASIC_AUTH_USERNAME` and `BASIC_AUTH_PASSWORD` - make sure that the value of password is readable by htpasswd e.g. `openssl passwd -apr1 <password_plaintext>`
5. Copy whatever content you are going to host into the `static` folder, add this to git and push to heroku using `git push heroku master` (Heroku will have set up that remote when creating the app). When regenerating the site this is the only step you will need to rerun.

I have a lot of Gitbook content which I will need to add to the site - for now I am manually building the books and copying them into the `static` folder. Next step will be to script that.