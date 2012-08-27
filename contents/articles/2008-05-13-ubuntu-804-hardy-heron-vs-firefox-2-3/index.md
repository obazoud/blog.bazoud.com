---
layout: post
title: Ubuntu 8.04 Hardy Heron vs Firefox 2 & 3
date: '2008-05-13T19:59:00.000Z'
author: Olivier
aliases: ['/post/2008/05/13/ubuntu-8-04-hardy-heron-vs-firefox-2-3/', '/post/2008/05/13/ubuntu-804-hardy-heron-vs-firefox-2-3/']
categories: [Uncategorized]
tags: [Ubuntu,firefox]
---

<p>Tout le monde l'a remarqué lors de l'installation de Hardy, Firefox 3 a été installé.</p> <p>Toutes les extensions ne sont pas compatibles entre FF 2 et FF3; par exemple : <a href="https://addons.mozilla.org/fr/firefox/addon/3829">Live HTTP Headers</a>, <a href="https://addons.mozilla.org/fr/firefox/addon/1843">Firebug</a>, <a href="https://addons.mozilla.org/fr/firefox/addon/518">Fetch Text URL</a> ,...</p> <p>Pour gérer cette cohabitation, il faut passer par les profiles.</p> <p>Création d'un profile &quot;FF2&quot; pour firefox 2:</p> 
<pre class="prettyprint lang-bsh">
% firefox-2 --profilemanager 
</pre>
<p>Lancer les firefox :</p>
<pre class="prettyprint lang-bsh">
% firefox-2 -P FF2 -no-remote 
</pre>
<pre class="prettyprint lang-bsh">
% firefox -P default -no-remote 
</pre>
 <p>Il faut réinstaller un à un les extensions dans FF2 ainsi que la configuration générale (gestion du cache, historique, ...) puisque FF2 est avec un profile tout neuf.</p>
