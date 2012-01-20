---
layout: post
title: Conversion en masse de projets SVN vers Git
date: '2012-07-11T21:00:00.000Z'
author: Olivier
categories: [Uncategorized]
tags: [git,svn,ruby,bash,gem,svn2git]
excerpt: Article sur la migration d'un large repository SVN vers un ensemble de repositories Git.
---

## Objectifs
 
Comme vous avez pu le lire dans l'article [Migration de SVN vers Git en 4 étapes](/post/2010-12-11-migration-de-svn-vers-git-en-4-etapes.html), le passage de [SVN](http://subversion.apache.org/) vers [Git](http://git-scm.com/) fonctionne très bien. Oui mais voilà, ça fonctionne pour un projet. Que se passe t il si l'on souhaite migrer des centaines de projets SVN vers Git ?
Nous allons étudier une conversion en masse des projets SVN en Git et également abordé la gestion de ces nombreux projets Git ainsi créés.

## Les chiffres

Je vous donne quelques chiffres permettant de vous donner une idée du projet:

* le SVN à migrer est très large ~130 000 commits, ~9 Go le dump et à peu près 250 projets
* chaque projet SVN ayant un layout standard comme le montre le schéma suivant.
<pre class="prettyprint lang-bsh">
.
├── projetA
│   ├── branches
│   ├── tags
│   └── trunk
├── ...
└── projetX
    ├── sousprojet1
    │   ├── branches
    │   ├── tags
    │   └── trunk
    └── sousprojet2
        ├── branches
        ├── tags
        └── trunk
</pre>

Pour un tel volume, il est nécessaire d'avoir une approche plus industrielle qu'un simple script shell à passer par projet. 
Pour cela, il faut:

* créer la liste des auteurs SVN
* créer un script Ruby ... parce que [@Florian_elam](https://twitter.com/Florian_elam) m'a dit un jour que Ruby c'est bien! ;) et surtout parce que le binding Ruby/SVN existe
* scanner le repository SVN et détecter les différents projets
* pour chaque projet, le transformer en repository [Git](http://git-scm.com/)
* parallèliser les phases de transformation

![Transformer un gros SVN en pleins Git](/images/svn2git.png)

## Gérer les auteurs

Comme abordé dans [Migration de SVN vers Git en 4 étapes](/post/2010-12-11-migration-de-svn-vers-git-en-4-etapes.html), git svn a besoin d'un fichier d'auteurs. Il doit être absolument à jour pour une bonne conversion. Lors de mes essais, j'ai dû écrire un script, car des personnes ont été ajoutés dans le SVN entre mes essais.
[author-diff.rb](https://github.com/obazoud/svn2git-massive-conversion/author-diff.rb) permet de connaître les différences entre le fichier des auteurs Git "git-authors.txt" et le fichier "svn-authors.txt" issu du dernier "svn log".
Il existe plusieurs options:

* --repo SVN_REPOSITORY : l'url du repository SVN
* --update : effectue un "svn log" pour récuperer l'ensemble des indentifiants utilisateurs.

Générer le fichier "svn-authors.txt"
<pre class="prettyprint lang-bsh">
% ./author-diff.rb --repo http://svn.mycompany.com --update
</pre>

Afficher les différences entre les fichiers des auteurs SVN et Git
<pre class="prettyprint lang-bsh">
% ./author-diff.rb
</pre>

Passons maintenant à la détection de projet SVN.

## Analyser le repository SVN

Le script ruby [svn2git-massive-conversion.rb](https://github.com/obazoud/svn2git-massive-conversion/svn2git-massive-convertion.rb) permet de scanner un repository SVN et de créer les projets Git associés. Cela se passe en deux étapes distinctes pour plus de performance.
Tout d'abord, il parcourt le repository SVN, si le répertoire courant contient soit 'branches', 'tags' ou 'trunk', c'est un vrai projet sinon ça continue récursivement. A la fin, une collection d'objets SVNPath est obtenue avec le chemin du projet et s'il y a le répertoire branches, tags et/ou trunk. Ces informations seront utiles pour convertir en Git plus finement et sont sauvegardés dans un fichier .dmp. 
La deuxième étape est de convertir, à l'aide du fichier .dmp, chaque projet SVN en repository Git. Pour cela, nous allons utilisé svn2git.

## Introduction à svn2git

Comme dirait [Aurélien](http://blogpro.toutantic.net/2011/09/25/de-svn-a-git/), il y a [svn2git](https://github.com/nirvdrum/svn2git) et [svn2git](http://gitorious.org/svn2git/pages/Home). Si le repository SVN a subit plusieurs refactoring (déplacement de projet, ...), le deuxième peut s'avérer un peu complexe à configurer, il est à noter qu'il beaucoup plus performant que le premier. Cependant, je préfère utiliser le premier car c'est juste un wrapper élaboré écrit en Ruby du classique git-svn.

L'installation est simple:

<pre class="prettyprint lang-bsh">
% gem install svn2git
</pre>

Voici un exemple simple de conversion:

<pre class="prettyprint lang-bsh">
% svn2git http://svn.mycompany.com/myproject --authors svn-authors.txt --metadata
</pre>

Il faut être au plus près du serveur SVN pour éviter les latences réseaux, voir sur le serveur lui même pour aller encore plus vite. Et si'l a des SSD c'est encore mieux ;)

Ce [svn2git](https://github.com/nirvdrum/svn2git) permet facilement de convertir un repository Git avec plusieurs options:

* --rebase : permet de mettre à jour le repository Git plutôt que de cloner
* --username NAME : utilise cet utilisateur pour se connecter au serveur SVN
* --trunk PATH / --branches PATH / --tags PATH : indique le chemin pour 'trunk' / 'branches' / 'tags' si votre layout n'est pas classique
* --rootistrunk : indique que le root du projet SVN est trunk (branches et tags ne seront pas importés)
* --notrunk / --nobranches / --notags : n'importera pas 'trunk' / 'branches' / 'tags'
* --no-minimize-url : utilise strcitement l'url et n'utilisera pas l'url du repository SVN.
* --revision REV : démarre l'import SVN à la révision REV
* --metadata : ajout les métadata SVN dans les commenentaires et notes au sein du commit Git
* --authors AUTHORS_FILE : emplacement du fichier des auteurs
* --exclude REGEX : exclus des chemins à importer (voir --ignore-paths dans git svn fetch)
* --verbose : afficher les informations de debug

Une fois le projet SVN converti en repository Git, [svn2git](https://github.com/nirvdrum/svn2git) permet de mettre à jour le projet Git en ajoutant les derniers commit et/ou branches. Tant que des personnes commit sur SVN, il veut mieux que le Git soit read only.

<pre class="prettyprint lang-bsh">
% svn2git http://svn.mycompany.com/myproject --rebase
</pre>

Nous avons toutes les briques de base pour finir l'ensemble du script.

## Tous ensemble

La commande suivante permet de générer le fichier layout.dump, qui contiendra la structure des projets SVN à convertir.
A noter que pour l'ensemble de la configuration, le script va lire le fichier config.yaml (valeur par défaut) et écrit le dump dans layout.dump (valeur par défaut). Il y a des options pour changer la valeur de ces options.

<pre class="prettyprint lang-bsh">
% ./svn2git-massive-convertion.rb --layout
</pre>

Ensuite, nous passons à la conversion des projets SVN. L'option --threads permet de paralléliser la conversion pour aller plus vite. Par défaut, le script va créer autant de threads que de processeurs sur la machine.

<pre class="prettyprint lang-bsh">
% ./svn2git-massive-convertion.rb --threads 8
</pre>

Et enfin, le dernier permet de pusher vers votre repository Git. Cela est configurable dans le fichier config.yaml. A noter que le chemin des repository Git reflète le chemin des projets SVN pour mieux s'y retrouvé.
<pre class="prettyprint lang-bsh">
% ./svn2git-massive-convertion.rb --push
</pre>

Voilà c'est fait, l'ensemble des projets SVN ont été migrés vers Git. Cela a pris à peu ~20h avec 8 threads, ~13h sur un poste avec SSD.
Maintenant, comment vais je pouvoir gérer autant de repository Git ? 

## Gérer ces repository Git

Un fois, tous ces repository Git crées, quelle serait les possibilités ?

* à la main, on va dire que cela ne semble pas souhaitable au vu du nombre de répositories
* avec un "beau script shell" bash/zsh à base de "for repo in ..."
* bon commençons par google ;)

Je vous donne en vrac l'ensemble des pistes étudiées, je vous donne juste après ma préférence:

* [Git submodules](http://progit.org/book/ch6-6.html) permet de créer des sous modules Git dans un repository Git. Seul problème, il se base sur des commits et pas sur des branches. De ce fait, ça peut devenir lours avec 250 repository Git 
* [Repo, Git et guerrit](http://source.android.com/source/version-control.html) est la façcon dont le projet Android gère l'ensemble de son source. Quelques précisions: le workspace Repo n'est pas un repository Git, il faut avoir un workflow avec Guerrit installé. Malgré tout, c'est très intéressant à étudier mais un peu overkill pour mon cas.
* [read-tree](http://www.kernel.org/pub/software/scm/git/docs/git-read-tree.html) / [filter-branch](http://www.kernel.org/pub/software/scm/git/docs/git-filter-branch.html): vous trouverez un [article en français](http://grummfy.be/blog/389) parlant de ce sujet. Ici, cela reviendrait à partir de l'ensemble de repository Git crée et de les fusionner en un seul
* L'aide GitHub pour faire des [merges avec subtree](https://help.github.com/articles/working-with-subtree-merge) et aussi [ici](http://help.github.com/subtree-merge)
* [Git subtree](https://github.com/apenwarr/git-subtree): solution sophistiquée et complexe, mais assez intéressante écrite en C
* à la [symfony](https://github.com/symfony/symfony-standard)
* [git-externals](https://github.com/eneroth/git-externals) qui a l'avantage de mixer Git et SVN avec l'utilisation de [la stratégie de subtree](http://www.kernel.org/pub/software/scm/git/docs/howto/using-merge-subtree.html)
* [externals](https://github.com/winton/externals)
* [git external](https://github.com/ronanchilvers/git-external)
* [Braid](https://github.com/evilchelu/braid)
* [externals](https://github.com/azimux/externals) et son [tutorial](http://nopugs.com/ext-tutorial)
* [cached externals](https://github.com/37signals/cached_externals)
* [Git external: *a git-submodule alternative*](https://github.com/dcestari/git-external)

Ma préférence va au dernier cité: [Git external](https://github.com/dcestari/git-external), la [documentation se trouve ici](http://dcestari.github.com/git-external/).
Certes, ce n'est pas parfait mais je suis en train de faire pas mal de pull request pour améliorer ce projet, mon fork se trouve [ici](https://github.com/obazoud/git-external). A noter que la branche "develop" intégre déjà tous mes pull request non encore mergé dans le projet principal.

## Git External

### Installation de Git External

Cloner le repository Git
<pre class="prettyprint lang-bsh">
% git clone git://github.com/obazoud/git-external.git
% git checkout develop
</pre>

Builder et install le gem
<pre class="prettyprint lang-bsh">
% gem build git-external.gemspec && gem install git-external-0.1.1.gem
</pre>

<pre class="prettyprint lang-bsh">
 % git external
Usage: git external add repository-url path [branch]
   or: git external status
   or: git external init
   or: git external update
   or: git external cmd 'command'
</pre>

### Utilisation

Prenons un exemple rapide: [Jenkins](https://github.com/jenkinsci/jenkins). Nous allons créer un repository Git assemblant le repository Jenkins et deux plugins Jenkins.

<pre class="prettyprint lang-bsh">
% git init
% git external add git://github.com/jenkinsci/jenkins.git jenkins master
% git external add git://github.com/jenkinsci/dashboard-view-plugin.git jenkins-plugins/dashboard-view-plugin master
% git external add git://github.com/jenkinsci/maven3-plugin.git jenkins-plugins/maven3-plugin master
% git external init
jenkins-plugins/maven3-plugin
Cloning into 'jenkins-plugins/maven3-plugin'...
remote: Counting objects: 65, done.
remote: Compressing objects: 100% (32/32), done.
remote: Total 65 (delta 9), reused 4 (delta 1)
Receiving objects: 100% (65/65), 15.43 KiB, done.
Resolving deltas: 100% (9/9), done.
jenkins
Cloning into 'jenkins'...
remote: Counting objects: 177346, done.
remote: Compressing objects: 100% (51998/51998), done.
remote: Total 177346 (delta 116849), reused 175606 (delta 115323)
Receiving objects: 100% (177346/177346), 52.50 MiB | 753 KiB/s, done.
Resolving deltas: 100% (116849/116849), done.
jenkins-plugins/dashboard-view-plugin
Cloning into 'jenkins-plugins/dashboard-view-plugin'...
remote: Counting objects: 1427, done.
remote: Compressing objects: 100% (648/648), done.
remote: Total 1427 (delta 438), reused 1220 (delta 343)
Receiving objects: 100% (1427/1427), 149.13 KiB | 62 KiB/s, done.
Resolving deltas: 100% (438/438), done.
fatal: A branch named 'master' already exists.
</pre>

Alors comment ça marche ? C'est simple en fait. Git external clone les repository Git dans les repertoires précisés et ceux ci sont ajoutés dans le .gitignore. Ils sont donc ignoré du nouveau repository. Voilà!
<pre class="prettyprint lang-bsh">
% cat .gitignore
jenkins
jenkins-plugins/dashboard-view-plugin
jenkins-plugins/maven3-plugin
</pre>

Git external maintient dans le fichier .gitexternals comme suit.
<pre class="prettyprint lang-bsh">
% cat .gitexternals 
[external "jenkins"]
  path = jenkins
  url = git://github.com/jenkinsci/jenkins.git
  branch = master
[external "jenkins-plugins/dashboard-view-plugin"]
  path = jenkins-plugins/dashboard-view-plugin
  url = git://github.com/jenkinsci/dashboard-view-plugin.git
  branch = master
[external "jenkins-plugins/maven3-plugin"]
  path = jenkins-plugins/maven3-plugin
  url = git://github.com/jenkinsci/maven3-plugin.git
  branch = master
</pre>

Et enfin la commande git external cmd 'xxx' permet d'itérer sur tous les projets et d'appliquer une commande shell, qui peut être une autre commande git. Par exemple, git external cmd 'git diff'.

Git external se base sur une branche et pas un commit, ce qui permet une gestion plus facile que les submodules par exemple.

## Conclusion

Nous avons mis en oeuvre une migration massive de projets SVN vers Git et également une solution pour gérer plus facilement un ensemble conséquent de projet Git.

Tout le code source se trouve sur GitHub: [https://github.com/obazoud/svn2git-massive-conversion](https://github.com/obazoud/svn2git-massive-conversion).
