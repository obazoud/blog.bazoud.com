---
template: article.jade
title: SVN Diff en couleur
date: '2008-05-29T22:28:00.000Z'
author: Olivier
aliases: ['/post/2008/05/30/svn-diff-en-couleur/', '/post/2008/05/30/svn-diff-en-couleur/']
categories: [Uncategorized]
tags: [Ubuntu,svn,shell]
---

<p>Pour mieux visualiser les diff svn, vous pouvez les coloriser.</p> 
<pre class="prettyprint lang-bsh">
% vi svndiff
</pre>
<p>Copier/coller le script dans svndiff</p>
<pre class="prettyprint lang-bsh">
#!/bin/sh 
svn diff $@ 2&gt;&amp;1 | colordiff
</pre>
<p>Et le placer dans /usr/local/bin</p> 
<pre class="prettyprint lang-bsh">
% mv svndiff /usr/local/bin 
% sudo chmod +x svndiff
</pre>
<p>Et voilà, maintenant plus d'excuses pour louper un merge.</p>
