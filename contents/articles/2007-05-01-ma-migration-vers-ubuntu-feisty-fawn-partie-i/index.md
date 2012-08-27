---
layout: post
title: Ma migration vers Ubuntu 7.0.4 (Feisty Fawn) - partie I
date: '2007-05-01T09:28:00.000Z'
author: Olivier
aliases: ['/post/2007/05/01/ma-migration-vers-ubuntu-7-0-4-feisty-fawn-partie-i/', '/post/2007/05/01/ma-migration-vers-ubuntu-feisty-fawn-partie-i/']
categories: [Uncategorized]
tags: [Ubuntu]
excerpt: <p>Voici un petit guide illustré de ma migration vers Ubuntu 'Feisty Fawn' 7.0.4.<br />
La <a href="/post/2007/05/01/Ma-migration-vers-Ubuntu-Feisty-Fawn-:-partie-I">partie I</a> illustre les différentes étapes avant la migration (si nécessaire).<br />
La <a href="/post/2007/05/01/Ma-migration-vers-Ubuntu-Feisty-Fawn-:-partie-II">partie II</a> illustre les différentes étapes de la migration.<br />
La <a href="/post/2007/05/01/Ma-migration-vers-Ubuntu-Feisty-Fawn-:-partie-III">partie III</a> illustre mon petit problème lors de cette migration.<br />
Voici la partie I.</p>
---

<p>Voici un petit guide illustré de ma migration vers Ubuntu 'Feisty Fawn' 7.0.4.<br />
La <a href="/post/2007/05/01/Ma-migration-vers-Ubuntu-Feisty-Fawn-:-partie-I">partie I</a> illustre les différentes étapes avant la migration (si nécessaire).<br />
La <a href="/post/2007/05/01/Ma-migration-vers-Ubuntu-Feisty-Fawn-:-partie-II">partie II</a> illustre les différentes étapes de la migration.<br />
La <a href="/post/2007/05/01/Ma-migration-vers-Ubuntu-Feisty-Fawn-:-partie-III">partie III</a> illustre mon petit problème lors de cette migration.<br />
Voici la partie I.</p>
<!--more-->
<p>Cette partie illustre la préparation de la mise à jour de Ubuntu 'Edgy' 6.10 vers Ubuntu 'Feisty Fawn' 7.0.4 sur ma machine personnelle.</p> <p>1. Pour plus sécurité, commencer par sauvegarder vos données ainsi que quelques fichiers systèmes (/etc/X11/xorg.conf, /etxfstab, ...). Normalement, cela n'est pas nécessaire, mais au moins vous stresserez moins lors de l'installation et du reboot.</p> <p>2. Faire une mise à jour de votre système avant de faire upgrade réelle.</p> 
<pre class="prettyprint lang-bsh">
% sudo apt-get update
</pre>
<p>puis :</p> 
<pre class="prettyprint lang-bsh">
% sudo update-manager -c 
</pre>
<p>Mon système n'est apparemment pas totalement à jour :<br />
<a href="/images/feisty_02.png"><img src="/images/feisty_02-300x146.png" alt="" title="feisty_02" width="300" height="146" class="alignnone size-medium wp-image-91" /></a><br /></p> <p>Il me manque les dernières mise à jour de XChat :<br />
<a href="/images/feisty_01.png"><img src="/images/feisty_01-216x300.png" alt="" title="feisty_01" width="216" height="300" class="alignnone size-medium wp-image-90" /></a><br /></p> <p>Le téléchargement se déroule bien :<br />
<a href="/images/feisty_03.png"><img src="/images/feisty_03-251x300.png" alt="" title="feisty_03" width="251" height="300" class="alignnone size-medium wp-image-92" /></a><br /></p> <p>Et l'installation aussi :<br />
<a href="/images/feisty_04.png"><img src="/images/feisty_04-300x291.png" alt="" title="feisty_04" width="300" height="291" class="alignnone size-medium wp-image-93" /></a><br /></p> <p>Maintenant, je dispose d'une Ubuntu 6.10 uptodate :<br />
<a href="/images/feisty_05.png"><img src="/images/feisty_05-300x291.png" alt="" title="feisty_05" width="300" height="291" class="alignnone size-medium wp-image-94" /></a><br /></p> <p>Mon système est prêt pour migrer vers Ubuntu 7.0.4 :D</p>
