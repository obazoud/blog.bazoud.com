---
template: article.jade
title: Commandes utiles Oracle II
date: '2007-09-11T08:56:00.000Z'
author: Olivier
aliases: ['/post/2007/09/11/commandes-utiles-oracle-ii/', '/post/2007/09/11/commandes-utiles-oracle-ii/']
categories: [Uncategorized]
tags: [Oracle]
---

<p>Un autre commande <a href="/post/2007/03/05/Commandes-utiles-Oracle">en plus de celles déjà bloggées</a> :</p> <p>Lister les séquences (et générer un script de destruction de l'ensemble) :</p> 
<pre class="prettyprint">
select 'drop sequence ', SEQUENCE_NAME, ';' from user_sequences;

'DROPSEQUENCE' SEQUENCE_NAME                  ';' 
-------------- ------------------------------ --- 
drop sequence  SEQ_XXX                                   ;   
drop sequence  SEQ_XXX                                   ;   
</pre>
