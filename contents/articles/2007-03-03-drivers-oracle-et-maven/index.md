---
layout: post
title: Drivers Oracle et Maven
date: '2007-03-03T17:52:00.000Z'
author: Olivier
aliases: ['/post/2007/03/03/drivers-oracle-et-maven/', '/post/2007/03/03/drivers-oracle-et-maven/']
categories: [Uncategorized]
tags: [maven,Oracle,java]
---

<p>Pour installer le driver Oracle 10.2.0.1.0 dans le repository Maven,</p> 
<pre class="prettyprint lang-bsh">
% mvn install:install-file 
    -Dfile=/usr/lib/oracle/xe/app/oracle/product/10.2.0/server/jdbc/lib/ojdbc14.jar \ 
    -DgroupId=com.oracle \
    -DartifactId=ojdbc14 \
    -Dversion=10.2.0.1.0 \
    -Dpackaging=jar
</pre> 
<p>Et pour l'utiliser, ajouter dans le pom.xml de votre projet maven</p> 
<pre class="prettyprint lang-xml">
&lt;dependencies&gt;
        &lt;dependency&gt;
                &lt;groupId&gt;com.oracle&lt;/groupId&gt;
                &lt;artifactId&gt;ojdbc14&lt;/artifactId&gt;
                &lt;version&gt;10.2.0.1.0&lt;/version&gt;
        &lt;/dependency&gt;
&lt;/dependencies&gt;
</pre>
