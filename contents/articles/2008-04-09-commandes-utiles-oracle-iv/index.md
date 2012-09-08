---
template: article.jade
title: Commandes utiles Oracle IV
date: '2008-04-09T06:32:00.000Z'
author: Olivier
aliases: ['/post/2008/04/09/commandes-utiles-oracle-iv/', '/post/2008/04/09/commandes-utiles-oracle-iv/', '/post/2008/04/09/Aller-au-contenu-Aller-au-menu-Aller-a-la-recherche-Tag-Oracle-Fil-des-billets-Fil-des-commentaires-mercredi-28-novembre-2007-Commandes-utiles-Oracle-IV']
categories: [Uncategorized]
tags: [Oracle]
---

<p>Dropper les synonymes :</p> 
<pre class="prettyprint">
% SELECT 'DROP SYNONYM ' || synonym_name || ';' FROM user_synonyms; 
</pre>
