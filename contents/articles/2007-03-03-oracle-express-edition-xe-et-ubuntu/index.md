---
layout: post
title: Oracle Express Edition (XE) et Ubuntu
date: '2007-03-03T16:52:00.000Z'
author: Olivier
aliases: ['/post/2007/03/03/oracle-express-edition-xe-et-ubuntu/', '/post/2007/03/03/oracle-express-edition-xe-et-ubuntu/']
categories: [Uncategorized]
tags: [Ubuntu,Oracle]
---

<p>L'installation d'Oracle sous Ubuntu est simplifiée grâce à apt-get. Dans le fichier /etc/apt/sources.list, ajouter le dépôt Oracle :</p> 
<pre class="prettyprint lang-bsh">
% deb http://oss.oracle.com/debian/ unstable main non-free 
</pre>
<p>Puis lancer l'installation du paquet <strong>oracle-xe-universal</strong> (soyez patient il faut télécharger 262MB):</p> 
<pre class="prettyprint lang-bsh">
% sudo apt-get update 
... 
% sudo apt-get install oracle-xe-universal 
... 
</pre>
<p><strong>Attention</strong> : l'installation demande 1006 MB dans le <a href="/post/2007/03/03/Swap-et-UUID">swap</a>.</p> <p>L'installation doit être suivi par la commande suivante (qui prend un peu de temps) :</p> 

<pre class="prettyprint lang-bsh">
% sudo /etc/init.d/oracle-xe configure

Oracle Database 10g Express Edition Configuration
&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;
This will configure on-boot properties of Oracle Database 10g Express 
Edition.  The following questions will determine whether the database should 
be starting upon system boot, the ports it will use, and the passwords that 
will be used for database accounts.  Press <Enter> to accept the defaults. 
Ctrl-C will abort.

Specify the HTTP port that will be used for Oracle Application Express [8080]:8079

Specify a port that will be used for the database listener [1521]:

Specify a password to be used for database accounts.  Note that the same
password will be used for SYS and SYSTEM.  Oracle recommends the use of 
different passwords for each database account.  This can be done after 
initial configuration:
Confirm the password:

Do you want Oracle Database 10g Express Edition to be started on boot (y/n) [y]:y

Starting Oracle Net Listener...Done
Configuring Database...Done
Starting Oracle Database 10g Express Edition Instance...Done
Installation Completed Successfully.
To access the Database Home Page go to "http://127.0.0.1:8079/apex"
</pre> <p>J'ai choisi le 8079 pour éviter des conflits éventuels avec les serveurs d'applications java.</p>
