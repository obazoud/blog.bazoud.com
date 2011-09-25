---
layout: post
title: Git et ubuntu
date: '2010-05-04T06:27:00.000Z'
author: Olivier
aliases: ['/?p=375', '/post/2010/05/04/git-et-ubuntu/']
categories: [Uncategorized]
tags: [Ubuntu,git,ppa]
---

Pour avoir la dernière version de <a href="http://git-scm.com/" target="_blank">GIT</a> sur Ubuntu, j'ai installé un <a href="https://launchpad.net/ubuntu/+ppas" target="_blank">PPA.</a>

Le <a href="https://launchpad.net/~pdoes/+archive/ppa" target="_blank">PPA for Peter van der Does</a> contient la dernière version de GIT, la 1.7.1 à ce jour.
<pre class="prettyprint lang-bsh">
% sudo add-apt-repository ppa:pdoes/ppa
% sudo apt-get update
</pre>

Si vous n'avez pas GIT encore d'installer, il faut passer par apt-get :

<pre class="prettyprint lang-bsh">
% sudo apt-get install git-core
</pre>

Voilà vous pouvez jouer avec la dernierè version de GIT :
<pre class="prettyprint lang-bsh">
% git --version
% git version 1.7.1
</pre>

