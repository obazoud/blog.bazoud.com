---
layout: post
title: HomePlayer
date: '2007-01-28T16:16:00.000Z'
author: Olivier
aliases: ['/post/2007/01/28/homeplayer/', '/post/2007/01/28/homeplayer/']
categories: [Uncategorized]
tags: [Ubuntu]
---

<p>Je <a href="/post/2007/01/13/Pour-quelques-softs-de-plus">recherchais</a> un équivalent à Freebrowser mais sous Ubuntu. Mon choix s'est porté sur <a href="http://homeplayer.free.fr/">HomePlayer</a> a les mêmes fonctionnalités que Freebrowser, plus je peux regarder des clips, les bandes annonces cinémas, ... L'installation se fait via Synaptic.</p> <p>Il fonctionne avec Java, un tomcat, ...</p> <p>A noter que si vous avez l'erreur suivante dans les logs :</p> 
<pre class="prettyprint lang-bsh">
Error: Couldn't find per display information 
</pre> 
<p>Il faut passer en JDK 1.5 et ne pas utiliser le JDK 1.6, ce bug est réapparu :(</p>
