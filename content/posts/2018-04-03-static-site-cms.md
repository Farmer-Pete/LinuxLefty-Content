+++
title = "Content Management Systems for Static Sites"
slug = "content-management-systems-static-sites"
date = 2018-04-03
draft = false
toc = false
categories = ["Geek"]
tags = ["cms", "hugo"]
#images = [""]
+++

## Static Site Generations

I'm a huge fan and proponent of static site generators. They give me the flexibility to easily work offline (the Internet can be spotty out where I live), have everything backed up in Git, and the ability to deploy anywhere.

My brother and his wife are thinking of creating a blog. As much as I love the way I blog (terminal + Neovim + Git), it doesn't lend itself to people who don't understand git and markdown. So I started looking into CMS systems that I could recommend that integrate with static site generators and git.

My criteria:

* Supports [Hugo](http://www.gohugo.io)
* Integrates with Github and easy to import existing site
* Easy to use

## Gold Star - Forestry

[Forestry](https://forestry.io) is really amazing. It supports both Hugo and Jekyll and integrates well with Github. More impressively, it imported all my settings and found the pages and posts. It even detected all the front matter and displayed the proper settings. My one criticism is that I found switching between front matter and the body confusing at first.

## Silver Star - Netlify CMS

I am currently hosting this site at Netlify and decided to try the [Netlify CMS](https://www.netlifycms.org/). It is fully open source (a huge plus) and tightly integrates with Netlify (another bug plus). However, I found the configuration process a bit unclear and I wasn't able to get it working properly. Granted, I didn't spent too much time debugging, and I'm sure the problem was with my configuration, but it was taking more time than I was willing to commit. Also, it requires that you include a javascript to the template's header, which is a bummer as I try to keep external scripts to a minimum.

## Missing Star - DakoCMS

There's not much to say about [DakoCMS](http://dakocms.com) except that it didn't work for me. It gave me options to start from scratch or load a sample project, but I couldn't find a way to import my existing site.

## Honorable Mentions

These are sites which look good, but they don't support Hugo:

* [Site Leaf](https://siteleaf.com)
* [Cloud Cannon](https://cloudcannon.com/)

Hopefully some of this is useful
