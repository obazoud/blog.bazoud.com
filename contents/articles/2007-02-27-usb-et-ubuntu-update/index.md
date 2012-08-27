---
layout: post
title: USB et Ubuntu (update)
date: '2007-02-27T18:00:00.000Z'
author: Olivier
aliases: ['/post/2007/02/27/usb-et-ubuntu-update/', '/post/2007/02/27/usb-et-ubuntu-update/']
categories: [Uncategorized]
tags: [Ubuntu]
---

<p>Avec avoir résolu mon <a href="/post/2007/01/18/USB-et-Ubuntu">problème USB</a>, il faudrait maintenant quelle soit reconnue au lancement.</p> <p>Pour cela, il faut mettre le script suivant dans l'onglet 'Startup Programs' dans 'System' &gt; 'Sessions'.</p> 
<pre class="prettyprint lang-bsh">
% gksudo -k 'sudo modprobe -r ehci-hcd' 
</pre>
 <p><a href="/images/ubuntu-sessions.png"><img src="/images/ubuntu-sessions-300x182.png" alt="" title="ubuntu-sessions" width="300" height="182" class="alignnone size-medium wp-image-88" /></a></p> <p>Après le login, une boite de dialogue s'affichera pour demander le mot de passe. Si quelqu'un a mieux, je suis preneur.</p>
