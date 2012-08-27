---
layout: post
title: Souris et Ubuntu
date: '2007-02-03T10:52:00.000Z'
author: Olivier
aliases: ['/post/2007/02/03/souris-et-ubuntu/', '/post/2007/02/03/souris-et-ubuntu/']
categories: [Uncategorized]
tags: [Ubuntu]
---

<p>J'ai résolu mon problème de <a href="/post/2007/01/11/Quelques-details-a-finir">bouton back de ma souris Logitech M-BD53</a>, il fallait légèrement modifier le fichier /etc/X1/org.conf. J'ai juste ajouter les 2 dernières lignes pour préciser comment sont mappés les boutons de la souris.</p> 
<pre class="prettyprint lang-bsh">
Section "InputDevice"
        Identifier      "Configured Mouse"
        Driver          "mouse"
        Option          "CorePointer"
        Option          "Device"              "/dev/input/mice"
        Option          "Protocol"            "ExplorerPS/2"
        Option          "ZAxisMapping"                "4 5"
        Option          "Emulate3Buttons"     "false" # true
        Option          "Buttons" "6"
        Option          "ButtonMapping" "1 2 3 6"
EndSection
</pre>