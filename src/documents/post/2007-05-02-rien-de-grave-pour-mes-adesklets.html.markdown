---
layout: post
title: Rien de grave pour mes adesklets
date: '2007-05-02T21:25:00.000Z'
author: Olivier
aliases: ['/post/2007/05/02/rien-de-grave-pour-mes-adesklets/', '/post/2007/05/02/rien-de-grave-pour-mes-adesklets/']
categories: [Uncategorized]
tags: [Ubuntu]
---

<p>Après avoir migrer vers <a href="/post/2007/05/01/Ma-migration-vers-Ubuntu-Feisty-Fawn-%3A-partie-III">Ubuntu 7.0.4 (Feisty Fawn)</a>, mes adesklets ne fonctionnaient plus.</p> 
<pre class="prettyprint lang-bsh">
% ./weatherforecast.py Traceback (most recent call last):   File &quot;./weatherforecast.py&quot;, line 41, in &lt;module&gt;     import adesklets ImportError: No module named adesklets 
</pre> 
<p>Rien de grave, la nouvelle version Ubuntu a dû changer la version de python, il suffit de compiler à nouveau et tout fonctionne correctement.</p> 
<pre class="prettyprint lang-bsh">
% make 
% sudo make install 
</pre>
<p>PS : Le sudo est là pour autoriser le remplacement du binaire.</p>
