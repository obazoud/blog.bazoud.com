---
template: article.jade
title: NTFS - Ubuntu
date: '2007-01-09T22:48:00.000Z'
author: Olivier
aliases: ['/post/2007/01/09/ntfs-ubuntu/', '/post/2007/01/09/ntfs-ubuntu/']
categories: [Uncategorized]
tags: [Ubuntu]
excerpt: <p>L'installation d'Ubuntu se passe bien, c'est agréable de surfer sur le net pendant le processus d'installation, il n'y a pas de petit plaisir :)</p> <p>Tout se passe bien, je réussie même à monter ma partition NTFS de mon OS d'avant.</p> <pre> ~$sudo mount /dev/hdc1 /media/disk2/ -t ntfs -o nls=utf8,umask=0222 </pre> <p>Malheureusement, il n'y a pas d'outil qui permette de convertir une partition NTFS en ext3. Je souhaite être full linux, je tente de retailler ma partition NTFS pour créer une nouvelle partition ext3, et petit à petit j'espère transférer mes données de l'une vers l'autre, puis retailler ... J'essaie de faire cette manipulation avec <a href="http://gparted.sourceforge.net">GParted</a> sans succès, il m'indique que je n'ai pas assez de place, bizarre je pense que ma partition est fragmentée en fin de disque.</p>
---

<p>L'installation d'Ubuntu se passe bien, c'est agréable de surfer sur le net pendant le processus d'installation, il n'y a pas de petit plaisir :)</p> <p>Tout se passe bien, je réussie même à monter ma partition NTFS de mon OS d'avant.</p> 
<pre class="prettyprint lang-bsh">
% sudo mount /dev/hdc1 /media/disk2/ -t ntfs -o nls=utf8,umask=0222 
</pre> 
<p>Malheureusement, il n'y a pas d'outil qui permette de convertir une partition NTFS en ext3. Je souhaite être full linux, je tente de retailler ma partition NTFS pour créer une nouvelle partition ext3, et petit à petit j'espère transférer mes données de l'une vers l'autre, puis retailler ... J'essaie de faire cette manipulation avec <a href="http://gparted.sourceforge.net">GParted</a> sans succès, il m'indique que je n'ai pas assez de place, bizarre je pense que ma partition est fragmentée en fin de disque.</p>
<!--more-->
<p>Je me tourne vers des outils plus exotique avec autant succès, pire un d'eux m'a &quot;mangé&quot; quelque chose dans les références NTFS. Après ça, <a href="http://gparted.sourceforge.net">GParted</a> met un temps fou à retrouver ma partition, de plus la commande précédente me répond :</p> 
<pre class="prettyprint lang-bsh">
mount: wrong fs type, bad option, bad superblock on /dev/hdc1,
      missing codepage or other error
      In some cases useful info is found in syslog - try
      dmesg | tail  or so
</pre>
<pre class="prettyprint lang-bsh">
% dmesg | tail
[drm] Setting GART location based on new memory map
[drm] Loading R300 Microcode
[drm] writeback test succeeded in 1 usecs
NTFS driver 2.1.27 [Flags: R/O MODULE].
NTFS-fs error (device hdc1): load_system_files():
Failed to load $Bitmap.
NTFS-fs error (device hdc1): ntfs_fill_super():
Failed to load system files.
NTFS-fs error (device hdc1): load_system_files():
Failed to load $Bitmap.
NTFS-fs error (device hdc1): ntfs_fill_super():
Failed to load system files.
NTFS-fs error (device hdc1): load_system_files():
Failed to load $Bitmap.
NTFS-fs error (device hdc1): ntfs_fill_super():
Failed to load system files.
</pre>
<p>Bref, rien de très encouragent, mais <a href="http://www.cgsecurity.org/wiki/TestDisk">TestDisk</a> malgré des messages suivant,</p> 
<pre class="prettyprint lang-bsh">
Warning: Bad ending head (CHS and LBA don't match)
Warning: the current number of heads per cylinder is 16
but the correct value may be 255.
You can use the Geometry menu to change this value.
</pre> 
<p>arrive à lire la structure de mes répertoires d'où un peu de panique.</p> <p>Après quelques recherches sur le net, je me suis résolu à installer sur une autre partition mon ancien OS, juste pour qu'au reboot, il détecte toutes mes partitions et fasse un check disk.</p> <p>L'essentiel est là : j'ai installé Ubuntu 6.10 et que j'ai toujours mes anciennes données !</p>
