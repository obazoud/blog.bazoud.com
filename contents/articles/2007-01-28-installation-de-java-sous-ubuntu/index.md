---
layout: post
title: Installation de Java sous Ubuntu
date: '2007-01-28T15:33:00.000Z'
author: Olivier
aliases: ['/post/2007/01/28/installation-de-java-sous-ubuntu/', '/post/2007/01/28/installation-de-java-sous-ubuntu/']
categories: [Uncategorized]
tags: [Ubuntu,java]
---

<p>Je vais quand même commencer à parler de Java :) L'installation de Java sous Ubuntu est d'une simplicité déconcertante, cf la <a href="http://doc.ubuntu-fr.org/java?s=java">documentation</a>.</p> <p>J'ai opté pour une installation à la main pour mieux contrôler les versions de Java installées sur mon poste pour faire du développement.</p> <p>Il faut d'abord télécharger un JDK :</p> <ul> <li>Pour le JDK 5, allez sur le site <a href="http://java.sun.com/javase/downloads/index_jdk5.jsp">http://java.sun.com/javase/downloads/index_jdk5.jsp</a>, choisir l'item JDK 5.0 Update 10, puis le fichier jdk-1_5_0_10-linux-i586.bin</li> <li>Pour le JDK 6, allez sur le site <a href="http://java.sun.com/javase/downloads/index.jsp">http://java.sun.com/javase/downloads/index.jsp</a>, choisir l'item JDK 6, puis le fichier jdk-6-linux-i586.bin</li> </ul> <p>Une fois, le ou les fichiers récupérés :</p> 
<pre class="prettyprint lang-bsh">
% chmod +x jre-6-linux-i586.bin
% sudo ./jre-6-linux-i586.bin 
</pre> 
<p>Après acceptation de la licence, un répertoire a été créé jdk1.6.0 ou jdk1.5.0_10 suivant le JDK installé.</p> <p>Je préfère installer les JDK pour le développement dans ma home, sous le répertoire java/jdk</p> 
<pre class="prettyprint lang-bsh">
% mv jdk1.6.0 java/jdk
% mv jdk1.5.0_10 java/jdk 
</pre> 
<p>Comme je vais vouloir &quot;switcher&quot; entre plusieurs JDK, je vais faire un lien &quot;current&quot; vers le JDK utilisé.</p> 
<pre class="prettyprint lang-bsh">
% ln -s /home/bazoud/java/jdk/jdk1.5.10 current 
</pre> 
<p>Ubuntu gère le lien &quot;/etc/alternatives/java&quot;, il va falloir lui dire de pointer vers &quot;current&quot;.</p> <p>Voilà, ce n'est pas plus compliqué que ça. Pour les logiciels utilisant Java, comme Homeplayer par exemple, j'ai utilisé le JDK installée via Synaptic.</p>
