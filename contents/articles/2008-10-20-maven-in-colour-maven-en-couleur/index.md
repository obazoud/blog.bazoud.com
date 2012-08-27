---
template: article.jade
title: Maven in colour / Maven en couleur
date: '2008-10-20T17:05:00.000Z'
author: Olivier
aliases: ['/post/2008/10/20/maven-in-colour-maven-en-couleur/', '/post/2008/10/20/maven-in-colour-maven-en-couleur/', '/post/2008/10/20/Maven-in-colour-/-Maven-en-couleur', '/post/2008/10/20/Maven-in-colour-/', '/post/2008/10/20/maven-in-colour-/-maven-en-couleur', '/post/2008/10/20/Maven-in-colour-/-Maven-en-couleur/']
categories: [Uncategorized]
tags: [Ubuntu,maven,awk]
excerpt: <p>ENG : If you want to see maven in colour, you can just add an litle awk in a script :)</p> <p>FR : Vous voulez voir maven en couleur, il suffit d'ajouter un petit awk dans un script :)</p>
---

<p>ENG : If you want to see maven in colour, you can just add an litle awk in a script :)</p> <p>FR : Vous voulez voir maven en couleur, il suffit d'ajouter un petit awk dans un script :)</p> 
<br />
<pre class="prettyprint lang-bsh">
sudo vi /usr/local/bin/mvnc
</pre>
<br />
<pre class="prettyprint lang-bsh">
#!/bin/sh
mvn $@ 2&gt;&amp;1 | awk ' ($1 == &quot;[ALL]&quot;)     { 
print &quot;\033[1;37m&quot; $0 &quot;\033[0m&quot;; next; } ($1 == &quot;[FATAL]&quot;)     { print &quot;\033[1;31m&quot; $0 &quot;\033[0m&quot;; next; } ($1 == &quot;[ERROR]&quot;)     { print &quot;\033[1;31m&quot; $0 &quot;\033[0m&quot;; next; } ($1 == &quot;[WARNING]&quot;)     { print &quot;\033[1;33m&quot; $0 &quot;\033[0m&quot;; next; } ($1 == &quot;[INFO]&quot;)     { print &quot;\033[1;37m&quot; $0 &quot;\033[0m&quot;; next; } ($1 == &quot;[DEBUG]&quot;)     { print &quot;\033[1;36m&quot; $0 &quot;\033[0m&quot;; next; } ($1 == &quot;[TRACE]&quot;)     { print &quot;\033[1;32m&quot; $0 &quot;\033[0m&quot;; next; } { print }' </pre> 
<br />
<pre class="prettyprint lang-bsh">
vi ~/.bashrc 
</pre>
<br />
<pre class="prettyprint lang-bsh">
... 
alias mvn='JAVA_HOME=~/java/jdk/jdk6; mvnc' ... 
</pre> 
<p>
<a href="/images/mvnc.png"><img src="/images/mvnc-300x165.png" alt="" title="mvnc" width="300" height="165" class="alignnone size-medium wp-image-85" /></a>
</p>
