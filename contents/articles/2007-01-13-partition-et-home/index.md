---
template: article.jade
title: Partition et /home
date: '2007-01-13T17:38:00.000Z'
author: Olivier
aliases: ['/post/2007/01/13/partition-et-home/', '/post/2007/01/13/partition-et-home/']
categories: [Uncategorized]
tags: [Ubuntu]
excerpt: <p>J'ai trois partitions que je souhaite organiser comme suit :</p> <ul> <li>/dev/hda1 pour l'installation de Ubuntu, monté sur &quot;/&quot;</li> <li>/dev/hdb1 pour la home, monté sur &quot;/home&quot;</li> <li>/dev/hdc1 pour mes backups, monté sur &quot;/home/olivier/backups&quot;</li> </ul> <p>Sachant qu'à l'installation, tout a été installé sur le même disque, il faut réorganiser tout ça.</p>
---

<p>J'ai trois partitions que je souhaite organiser comme suit :</p> <ul> <li>/dev/hda1 pour l'installation de Ubuntu, monté sur &quot;/&quot;</li> <li>/dev/hdb1 pour la home, monté sur &quot;/home&quot;</li> <li>/dev/hdc1 pour mes backups, monté sur &quot;/home/olivier/backups&quot;</li> </ul> <p>Sachant qu'à l'installation, tout a été installé sur le même disque, il faut réorganiser tout ça.</p>
<!--more-->
<p>1. Création d'un répertoire où je vais monter /dev/hdb1 (ce sera ma nouvelle home)</p> 
<pre class="prettyprint lang-bsh">
% mkdir /mnt/newhome
% sudo mount -t ext3 /dev/hdb1 /mnt/newhome 
</pre> 
<p>2. Copier l'ensemble de mes fichiers vers la future home</p>
<pre class="prettyprint lang-bsh">
% cd /home ~$find . -depth -print0 | sudo cpio --null --sparse --preserve-modification-time -pvd /mnt/newhome 
</pre> 
<p>Évidemment cela demande quelques explications :</p> <ul> <li>Le &quot;find&quot; recherche les fichiers</li> <li>à partir du répertoire &quot;.&quot; (courant)</li> <li>&quot;-depth&quot; permet d'analyser les répertoires enfants avant lui même</li> <li>&quot;cpio -p&quot; copie les fichiers vers la cible</li> <li>&quot;-null&quot; précise que la liste des fichiers est séparé par un caractère ASCII null</li> <li>&quot;--sparse&quot; force la copie exacte sans optimisation (pas de performance mais d'écriture, à garder obligatoire)</li> <li>&quot;--preserve-modification-time&quot; garde le timestamp de chaque fichier</li> <li>&quot;-pvd&quot; : &quot;p&quot; précise le &quot;Copy-pass mode&quot;, d'être en &quot;v&quot;erbose et de créer &quot;d&quot; des répertoire si nécessaire</li> </ul> <p>3. Démonter la nouvelle home</p> 
<pre class="prettyprint lang-bsh">
% sudo umount /mnt/newhome 
</pre> 
<p>4. Backup de l'ancienne</p> 
<pre class="prettyprint lang-bsh">
% sudo mv /home /old_home 
</pre> 
<p>5. Création de la home</p> 
<pre class="prettyprint lang-bsh">
% sudo mkdir /home
% sudo mount /dev/hdb1 /home
</pre> 
<p>Si ça fonctionne bien, pour que cela soit permanent, écrire dans &quot;/etc/fstab&quot; :</p> 
<pre class="prettyprint lang-bsh">
/dev/hdb1 /home ext3 nodev,nosuid 0 2 
</pre> 
<p>6. Monter les backups</p> 
<pre class="prettyprint lang-bsh">
% mkdir /home/olivier/backups
% mount /dev/hdc1 /home/olivier/backups 
</pre>
 <p>Si ça fonctionne bien, écrire dans le fichier &quot;/etc/fstab&quot;</p> 
<pre class="prettyprint">
/dev/hdc1 /home ext3 nodev,nosuid 0 2
</pre> 
<p>Voilà, mes disques sont réorganisés.</p>

