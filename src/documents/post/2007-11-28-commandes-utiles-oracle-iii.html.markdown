---
layout: post
title: Commandes utiles Oracle III
date: '2007-11-28T07:00:00.000Z'
author: Olivier
aliases: ['/post/2007/11/28/commandes-utiles-oracle-iii/', '/post/2007/11/28/commandes-utiles-oracle-iii/']
categories: [Uncategorized]
tags: [Oracle]
---

<p>Encore quelques commandes utiles pour la vie de tous les jours sous Oracle :</p> <p>1. Liste des tables</p> 
<pre class="prettyprint"> 
SELECT table_name FROM user_tables; 
</pre> <p>2. Liste des vues</p> 
<pre class="prettyprint">
SELECT view_name FROM user_views; 
</pre> 
<p>3. Informations sur les contraintes</p> 
<pre class="prettyprint">
SELECT * FROM user_constraints WHERE constraint_name='FKXXXXXXXXXXXXXXXX';
</pre> 
<p>4. Liste des procédures</p> 
<pre class="prettyprint">
SELECT DISTINCT procedure_name FROM all_procedures; 
</pre>
