---
layout: post
title: Ma migration vers Ubuntu 7.0.4 (Feisty Fawn) - partie II
date: '2007-05-01T16:05:00.000Z'
author: Olivier
aliases: ['/post/2007/05/01/ma-migration-vers-ubuntu-7-0-4-feisty-fawn-partie-ii/', '/post/2007/05/01/ma-migration-vers-ubuntu-feisty-fawn-partie-ii/']
categories: [Uncategorized]
tags: [Ubuntu]
excerpt: <p>Voici un petit guide illustré de ma migration vers Ubuntu 'Feisty Fawn' 7.0.4.<br />
La <a href="/post/2007/05/01/Ma-migration-vers-Ubuntu-Feisty-Fawn-:-partie-I">partie I</a> illustre les différentes étapes avant la migration (si nécessaire).<br />
La <a href="/post/2007/05/01/Ma-migration-vers-Ubuntu-Feisty-Fawn-:-partie-II">partie II</a> illustre les différentes étapes de la migration.<br />
La <a href="/post/2007/05/01/Ma-migration-vers-Ubuntu-Feisty-Fawn-:-partie-III">partie III</a> illustre mon petit problème lors de cette migration.<br />
Voici la partie II.</p>
---

<p>Voici un petit guide illustré de ma migration vers Ubuntu 'Feisty Fawn' 7.0.4.<br />
La <a href="/post/2007/05/01/Ma-migration-vers-Ubuntu-Feisty-Fawn-:-partie-I">partie I</a> illustre les différentes étapes avant la migration (si nécessaire).<br />
La <a href="/post/2007/05/01/Ma-migration-vers-Ubuntu-Feisty-Fawn-:-partie-II">partie II</a> illustre les différentes étapes de la migration.<br />
La <a href="/post/2007/05/01/Ma-migration-vers-Ubuntu-Feisty-Fawn-:-partie-III">partie III</a> illustre mon petit problème lors de cette migration.<br />
Voici la partie II.</p>
<!--more-->
<p>La migration vers Ubuntu 'Feisty Fawn' commence par :</p> 
<pre class="prettyprint lang-bsh">
% sudo update-manager -c 
</pre>
<p>Le système détecte bien que la version 7.0.4 est disponible : <a href="/images/feisty_11.png"><img src="/images/feisty_11-300x253.png" alt="" title="feisty_11" width="300" height="253" class="alignnone size-medium wp-image-96" /></a><br /></p> <p>Après avoir lu (?), la release note, appuyer sur &quot;Upgrade&quot; : <a href="/images/feisty_12.png"><img src="/images/feisty_12-300x260.png" alt="" title="feisty_12" width="300" height="260" class="alignnone size-medium wp-image-97" /></a><br /></p> <p>L'installation commence : <a href="/images/feisty_13.png"><img src="/images/feisty_13-300x224.png" alt="" title="feisty_13" width="300" height="224" class="alignnone size-medium wp-image-98" /></a><br />
<a href="/images/feisty_14.png"><img src="/images/feisty_14-300x224.png" alt="" title="feisty_14" width="300" height="224" class="alignnone size-medium wp-image-99" /></a><br /></p> <p>Un problème peut apparaître si les dépôts ne sont pas disponibles ou compatibles : <a href="/images/feisty_15.png"><img src="/images/feisty_15-300x246.png" alt="" title="feisty_15" width="300" height="246" class="alignnone size-medium wp-image-100" /></a><br /></p> <p>L'installation s'arrête et il faut mettre en commentaires dans /etc/apt/sources.list, les dépôts qui posent problèmes. Et relancer l'installation. <a href="/images/feisty_16.png"><img src="/images/feisty_16-300x121.png" alt="" title="feisty_16" width="300" height="121" class="alignnone size-medium wp-image-101" /></a><br /></p> <p>L'installation se poursuit : <a href="/images/feisty_17.png"><img src="/images/feisty_17-300x225.png" alt="" title="feisty_17" width="300" height="225" class="alignnone size-medium wp-image-102" /></a><br /></p> <p>La boite de dialogue apparaît résumant toutes les opérations à faire : <a href="/images/feisty_18.png"><img src="/images/feisty_18-300x222.png" alt="" title="feisty_18" width="300" height="222" class="alignnone size-medium wp-image-103" /></a><br /></p> <p>L'installation se poursuit : <a href="/images/feisty_21.png"><img src="/images/feisty_21-300x225.png" alt="" title="feisty_21" width="300" height="225" class="alignnone size-medium wp-image-106" /></a><br />
<br /><a href="/images/feisty_22.png"><img src="/images/feisty_22-300x225.png" alt="" title="feisty_22" width="300" height="225" class="alignnone size-medium wp-image-107" /></a><br />
<a href="/images/feisty_23.png"><img src="/images/feisty_23-300x225.png" alt="" title="feisty_23" width="300" height="225" class="alignnone size-medium wp-image-108" /></a><br />
<a href="/images/feisty_24.png"><img src="/images/feisty_24-300x225.png" alt="" title="feisty_24" width="300" height="225" class="alignnone size-medium wp-image-109" /></a><br />
<a href="/images/feisty_25.png"><img src="/images/feisty_25-300x225.png" alt="" title="feisty_25" width="300" height="225" class="alignnone size-medium wp-image-110" /></a><br />
<a href="/images/feisty_26.png"><img src="/images/feisty_26-300x225.png" alt="" title="feisty_26" width="300" height="225" class="alignnone size-medium wp-image-111" /></a><br /></p> <p>Dans le détail, l'installation de chaque package : <a href="/images/feisty_28.png"><img src="/images/feisty_28-300x296.png" alt="" title="feisty_28" width="300" height="296" class="alignnone size-medium wp-image-113" /></a><br /></p> <p>La boite de dialogue apparaît résumant les packages qui ne sont plus supportés : <a href="/images/feisty_29.png"><img src="/images/feisty_29-300x286.png" alt="" title="feisty_29" width="300" height="286" class="alignnone size-medium wp-image-114" /></a><br /></p> <p>Suppression des fichiers utilisés pour l'installation : <a href="/images/feisty_30.png"><img src="/images/feisty_30-294x300.png" alt="" title="feisty_30" width="294" height="300" class="alignnone size-medium wp-image-115" /></a><br /></p> <p>Liste des packages obsolètes : <a href="/images/feisty_31.png"><img src="/images/feisty_31-300x265.png" alt="" title="feisty_31" width="300" height="265" class="alignnone size-medium wp-image-116" /></a><br />
<a href="/images/feisty_32.png"><img src="/images/feisty_32-294x300.png" alt="" title="feisty_32" width="294" height="300" class="alignnone size-medium wp-image-117" /></a><br /></p> <p>L'installation s'est bien passée, et maintenant il faut rebooter : <a href="/images/feisty_33.png"><img src="/images/feisty_33-295x300.png" alt="" title="feisty_33" width="295" height="300" class="alignnone size-medium wp-image-118" /></a><br /></p>
