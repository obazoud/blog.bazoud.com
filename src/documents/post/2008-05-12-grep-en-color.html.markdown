---
layout: post
title: Grep en couleur
date: '2008-05-12T20:26:00.000Z'
author: Olivier
aliases: ['/post/2008/05/12/grep-en-couleur/', '/post/2008/05/12/grep-en-color/']
categories: [Uncategorized]
tags: [Ubuntu,shell,grep]
---

<p>Pour mettre des couleurs sur les résultats de grep :</p> 
<pre class="prettyprint lang-bsh">
% grep --color=auto ... 
</pre> <p>Dans votre ~/.bashrc</p> 
<pre class="prettyprint lang-bsh">
% alias grep='grep --color=auto' 
</pre>
