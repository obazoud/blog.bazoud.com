---
layout: post
title: Vi en couleur
date: '2007-08-29T17:58:00.000Z'
author: Olivier
aliases: ['/post/2007/08/29/vi-en-couleur/', '/post/2007/08/29/vi-en-couleur/']
categories: [Uncategorized]
tags: [Ubuntu,vi]
---

<p>Vi est installé sous Ubuntu dans une version vi-tiny, de nombreuses options ne sont pas disponibles; par exemple, la gestion de la couleur. Pour faire apparaître des couleurs dans vi/vim sous Ubuntu, il faut installer la version full :</p> 
<pre class="prettyprint lang-bsh">
% sudo apt-get install vim-full
</pre> <p>Ajouter dans ~/.vimrc</p> 
<pre class="prettyprint lang-bsh">
:syntax enable 
</pre> <p>UPDATE : si vous avez un fond sombre, vous pouvez rajouter :</p> 
<pre class="prettyprint lang-bsh">
 :set background=dark 
</pre>
