---
layout: post
title: Commandes utiles SVN
date: '2007-05-08T16:29:00.000Z'
author: Olivier
aliases: ['/post/2007/05/08/commandes-utiles-svn/', '/post/2007/05/08/commandes-utiles-svn/']
categories: [Uncategorized]
tags: [svn,shell]
---

<p>Quelques commandes utiles pour SVN à garder sous le coude :</p> <p>1. Edite le svn:ignore du répertoire courant :</p> 
<pre class="prettyprint lang-bsh">
% svn propedit svn:ignore . 
</pre> <p>2. Affecte les mots clés 'Id' et 'Author' au fichier Test.java :</p> 
<pre class="prettyprint lang-bsh">
% svn propset svn:keywords &quot;Id Author&quot; Test.java 
</pre> <p>3. Pour faire la même chose mais sur un existant :</p> 
<pre class="prettyprint lang-bsh">
% find . -name &quot;*.java&quot; | grep -v '\.svn' | while read n; do svn propset svn:keywords 'Id Author HeadURL Revision Date' $n; done 
</pre>
