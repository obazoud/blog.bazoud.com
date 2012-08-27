---
layout: post
title: Commandes utiles Oracle
date: '2007-03-05T09:10:00.000Z'
author: Olivier
aliases: ['/post/2007/03/05/commandes-utiles-oracle/', '/post/2007/03/05/commandes-utiles-oracle/']
categories: [Uncategorized]
tags: [Oracle]
---

<p>Quelques commandes utiles Oracle à garder sous le coude :</p> <p>1 Connaître la version d'Oracle utilisée :</p> 
<pre class="prettyprint">
SELECT * FROM v$version;

BANNER                                                           
&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45; 
Oracle Database 10g Express Edition Release 10.2.0.1.0 - Product 
PL/SQL Release 10.2.0.1.0 - Production                           
CORE    10.2.0.1.0      Production                                         
TNS for Linux: Version 10.2.0.1.0 - Production                   
NLSRTL Version 10.2.0.1.0 - Production                           
5 rows selected
</pre>
 <p>2 Lister les tables (et générer un script de destruction de l'ensemble des tables) :</p> <pre class="prettyprint">
select 'drop table ', table_name, 'cascade constraints;' from user_tables;

'DROPTABLE' TABLE_NAME                     'CASCADECONSTRAINTS;' 
&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45; &#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45; &#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45; 
drop table  REGIONS                        cascade constraints;  
drop table  LOCATIONS                      cascade constraints;  
drop table  DEPARTMENTS                    cascade constraints;  
drop table  JOBS                           cascade constraints;  
drop table  EMPLOYEES                      cascade constraints;  
drop table  JOB_HISTORY                    cascade constraints;  
drop table  COUNTRIES                      cascade constraints;  
7 rows selected
</pre>
<p>3 Dans Oracle 10g, il y a une poubelle si vous faites des bêtises, et pour la vider :</p> 
<pre class="prettyprint">
PURGE recyclebin;
</pre>
