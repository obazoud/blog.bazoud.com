---
layout: post
title: ViewSVN en ligne de commande
date: '2008-06-15T20:45:00.000Z'
author: Olivier
aliases: ['/post/2008/06/15/viewsvn-en-ligne-de-commande/', '/post/2008/06/15/viewsvn-en-ligne-de-commande/']
categories: [Uncategorized]
tags: [Ubuntu,svn,awk,shell,vi,viewsvn,sed,firefox]
---

<p>Lancer mon navigateur et cliquer sur chaque répertoire de l'arborescence et enfin choisir le fichier pour voir les diffs, c'est un peu lourd. Bien sûr on peut faire des svn diff entre révision. Mais, sachant qu'en général on a un checkout local, pourquoi ne pas faire un petit script ?</p> <p>Soit le repository svn : subversion.bazoud.com.</p> <p>Et le viewsvn : viewsvn.bazoud.com</p> <p>sudo vi /usr/local/bin/viewsvn :</p> 
<pre class="prettyprint lang-bsh">
#!/bin/sh 
% firefox `svn info $1 | awk  '/^URL/ { print $2 }' | sed 's/subversion.bazoud.com/viewsvn.bazoud.com\/viewvc/g'`
</pre>
<pre class="prettyprint lang-bsh">
% sudo chmod +x /usr/local/bin/viewsvn
</pre>
<p>Et là, on tape :</p> 
<pre class="prettyprint lang-bsh">
% viewsvn path/to/my/file
</pre>
<p>Et firefox s'affiche avec la bonne page de viewsvn :)</p>
