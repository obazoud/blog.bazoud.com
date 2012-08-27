---
layout: post
title: Compter le nombre de processeurs
date: '2007-12-19T20:29:00.000Z'
author: Olivier
aliases: ['/post/2007/12/19/compter-le-nombre-de-processeurs/', '/post/2007/12/19/compter-le-nombre-de-processeurs/']
categories: [Uncategorized]
tags: [Ubuntu]
---

<p>Il suffit de lancer la commande suivante :</p> 
<pre class="prettyprint lang-bsh"> 
% cat /proc/cpuinfo | grep processor | wc -l 
</pre> 
<p>Résultat : 2 pour ma machine qui est un Core Duo</p>
