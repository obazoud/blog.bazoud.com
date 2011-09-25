---
layout: post
title: Migration de SVN vers GIT en 4 étapes
date: '2010-12-11T18:47:32.000Z'
author: Olivier
aliases: ['/?p=456', '/post/2010/12/11/migration-de-svn-vers-git-en-4-etapes/']
categories: [Uncategorized]
tags: [svn,awk,shell,git,subversion,grep]
excerpt: Migration de SVN vers Git en 4 étapes
---

Petit guide pour migrer de SVN vers Git en 4 étapes :

1. Créer un mapping entre les users SVN et GIT
Git a besoin d'un utilisateur avec un nom et un email, il faut constituer un fichier avec ces informations depuis votre serveur SVN comme suit :
Exemple : 
svnusername = fullname &lt;name@mycompany.com&gt;

<pre class="prettyprint lang-bsh">
% svn log --quiet 'http://subversion.mycompany.com/myproject' | grep "^r" | awk '{print $3}' | sort | uniq | awk '{ print $1" = "$1" <"$1"@mycompany.com>" }' > author.txt
</pre>

2. Cloner le repository SVN
<pre class="prettyprint lang-bsh">
% git svn clone 'http://subversion.mycompany.com/myproject' --no-metadata -A authors.txt -t tags -b branches -T trunk myproject
</pre>

3. Convertir les tags (optionnel)
Après le clone, les tags et les branches SVN sont tous vu comme des branches dans Git. Il faut passer ce petit script pour convertir les tags SVN vers des vrais tags Git.

<pre class="prettyprint lang-bsh">
#!/bin/sh
set -x
cd myproject

for i in `git branch -r | grep "tags\/" | grep -v "\\@"`
do
    TAGNAME=`echo $i | perl -p -e 's/tags\///sig;'`
    echo “Converting $i to $TAGNAME”;
    git tag $TAGNAME $i
    git branch -r -d $i >/dev/null
done
</pre>

4. Pusher !
Il ne reste qu'à définir un "remote", ie votre hosting Git d'entreprise et de pusher !
<pre class="prettyprint lang-bsh">
% git remote add origin git@git.mycompany.com:/myproject.git
% git push origin master --tags
</pre>
Et vous pouvez soit utilisé le clone soit un créer un autre, histoire de vérifier de tout fonctionne bien :
<pre class="prettyprint lang-bsh">
% cd path/to/somewhere
% git clone git@git.mycompany.com:/myproject.git
% cd myproject
% git status
</pre>

Voilà, trop simple.

