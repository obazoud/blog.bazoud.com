---
template: article.jade
title: Ma migration vers Ubuntu 7.0.4 (Feisty Fawn) - partie III
date: '2007-05-01T16:23:00.000Z'
author: Olivier
aliases: ['/post/2007/05/01/ma-migration-vers-ubuntu-7-0-4-feisty-fawn-partie-iii/', '/post/2007/05/01/ma-migration-vers-ubuntu-feisty-fawn-partie-iii/']
categories: [Uncategorized]
tags: [Ubuntu]
excerpt: <p>Voici un petit guide illustré de ma migration vers Ubuntu 'Feisty Fawn' 7.0.4.<br />
La <a href="/post/2007/05/01/Ma-migration-vers-Ubuntu-Feisty-Fawn-:-partie-I">partie I</a> illustre les différentes étapes avant la migration (si nécessaire).<br />
La <a href="/post/2007/05/01/Ma-migration-vers-Ubuntu-Feisty-Fawn-:-partie-II">partie II</a> illustre les différentes étapes de la migration.<br />
La <a href="/post/2007/05/01/Ma-migration-vers-Ubuntu-Feisty-Fawn-:-partie-III">partie III</a> illustre mon petit problème lors de cette migration.<br />
Voici la partie III.</p>
---

<p>Voici un petit guide illustré de ma migration vers Ubuntu 'Feisty Fawn' 7.0.4.<br />
La <a href="/post/2007/05/01/Ma-migration-vers-Ubuntu-Feisty-Fawn-:-partie-I">partie I</a> illustre les différentes étapes avant la migration (si nécessaire).<br />
La <a href="/post/2007/05/01/Ma-migration-vers-Ubuntu-Feisty-Fawn-:-partie-II">partie II</a> illustre les différentes étapes de la migration.<br />
La <a href="/post/2007/05/01/Ma-migration-vers-Ubuntu-Feisty-Fawn-:-partie-III">partie III</a> illustre mon petit problème lors de cette migration.<br />
Voici la partie III.</p>
<!--more-->
<p>Deux petits soucis quand même après le reboot :<br />
1. Mon répertoire /home est monté à partir de /dev/hdb1. Après le reboot, je ne suis pas arrivé à me loger parce que /dev/hdb1 n'existe pas !?<br />
Ubuntu a remapper mes devices de /dev/hd** en /dev/sd**.<br />
En éditant le fichier /etc/fstab, j'ai changé le mount de /dev/hdb1 en /dev/sdb1<br />
<br />
2. adesklets ne fonctionne plus avec la version Ubuntu 7.0.4 (Feisty Fawn). Je n'ai pas investigué le problème, si quelqu'un a des infos, laissez un commentaire.<br /></p>