---
template: article.jade
title: Alt Gr
date: '2007-01-11T23:21:00.000Z'
author: Olivier
aliases: ['/post/2007/01/12/alt-gr/', '/post/2007/01/12/alt-gr/']
categories: [Uncategorized]
tags: [Ubuntu]
excerpt: <p>J'ai résolu mon problème de touche <a href="/post/2007/01/11/Quelques-details-a-finir">Alt Gr</a> de mon clavier. Il suffit d'indiquer une variante <strong>latin9</strong>.</p>
---

<p>J'ai résolu mon problème de touche <a href="/post/2007/01/11/Quelques-details-a-finir">Alt Gr</a> de mon clavier. Il suffit d'indiquer une variante <strong>latin9</strong>.</p>
<!--more-->
<pre class="prettyprint lang-bsh">
sudo gedit /etc/X11/xorg.conf 
</pre> 
<pre class="prettyprint lang-bsh">
...
Section "InputDevice"
        Identifier      "Generic Keyboard"
        Driver          "kbd"
        Option          "CoreKeyboard"
        Option          "XkbRules"    "xorg"
        Option          "XkbModel"    "pc105"
        Option          "XkbLayout"   "fr"
        Option          "XkbVariant"  "latin9"
        Option          "XkbOptions"  "lv3:ralt_switch"
EndSection
...
</pre> 
<p>Puis faire un Ctrl + Alt + BackSpace pour relancer le serveur X.</p> <p>Source : <a href="http://franck.hecht.free.fr/index.php?2006/10/30/44-problemes-solutions-ubuntu"> ici</a> et <a href="http://forum.ubuntu-fr.org/viewtopic.php?pid=672068#p672068">là</a></p>