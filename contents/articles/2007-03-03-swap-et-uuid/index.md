---
layout: post
title: Swap et UUID
date: '2007-03-03T16:39:00.000Z'
author: Olivier
aliases: ['/post/2007/03/03/swap-et-uuid/', '/post/2007/03/03/swap-et-uuid/']
categories: [Uncategorized]
tags: [Ubuntu]
---

<p>Après avoir retailler mon swap, celui ci n'était plus reconnu par Ubuntu.</p> 
<pre class="prettyprint lang-bsh">
% free              total       used       free     shared    buffers     cached Mem:        515880     503032      12848          0      82072     154704 -/+ buffers/cache:     266256     249624 Swap:            0          0          0 
</pre> <p>En fait, dans /etc/fstab, le swap est reconnu par son UUID. Il suffit de changer les anciens UUID par les nouveaux.</p> 
<pre class="prettyprint lang-bsh">
% sudo ls -l /dev/disk/by-uuid
total 0
lrwxrwxrwx 1 root root 10 2007-03-03 17:04 xxxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx -> ../../hdb1
lrwxrwxrwx 1 root root 10 2007-03-03 17:04 xxxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx -> ../../hdc1
lrwxrwxrwx 1 root root 10 2007-03-03 17:04 xxxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx -> ../../hda1
lrwxrwxrwx 1 root root 10 2007-03-03 17:14 xxxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx -> ..
</pre>
