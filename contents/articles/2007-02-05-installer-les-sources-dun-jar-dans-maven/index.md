---
layout: post
title: Installer les sources d''un jar dans Maven
date: '2007-02-05T21:41:00.000Z'
author: Olivier
aliases: ['/post/2007/02/05/installer-les-sources-dun-jar-dans-maven/', '/post/2007/02/05/installer-les-sources-dun-jar-dans-maven/']
categories: [Uncategorized]
tags: [maven,java]
---

<p>Pour installer un fichier de sources dans Maven, c'est assez simple. Par exemple, si vous voulez installer les sources de <a href="http://www.springframework.org">Spring</a> à la main :</p> 
<pre class="prettyprint lang-bsh">
mvn install:install-file -DgroupId=org.springframework -DartifactId=spring -Dversion=2.0.2 -Dpackaging=jar -Dfile=s
</pre> 
<pre class="prettyprint lang-bsh">
[INFO] Scanning for projects...
[INFO] Searching repository for plugin with prefix: 'install'.
[INFO] ----------------------------------------------------------------------------
[INFO] Building Maven Default Project
[INFO]    task-segment: [install:install-file] (aggregator-style)
[INFO] ----------------------------------------------------------------------------
[INFO] [install:install-file]
[INFO] Installing /home/bazoud/download/spring-src.zip to /home/bazoud/java/maven/repository/org/springframework/spring/2.0.2/spring-2.0.2-sources.jar
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESSFUL
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 2 seconds
[INFO] Finished at: Mon Feb 05 22:27:42 CET 2007
[INFO] Final Memory: 2M/4M
[INFO] ------------------------------------------------------------------------
</pre>
<p>A adapter pour vos jars.</p>