---
template: article.jade
title: Downloader les sources automatiquement avec Maven
date: '2007-02-08T18:00:00.000Z'
author: Olivier
aliases: ['/post/2007/02/08/downloader-les-sources-automatiquement-avec-maven/', '/post/2007/02/08/downloader-les-sources-automatiquement-avec-maven/']
categories: [Uncategorized]
tags: [maven,java]
---

<p>Pour éviter à chaque fois de rajouter -DdowloadSources=true quand vous générez votre projet Eclipse,</p> 
<pre class="prettyprint lang-bsh">
% mvn eclipse:clean eclipse:eclipse -DdownloadSources=true
</pre>
<p>Vous pouvez préciser cette option dans votre settings.xml (ça fait déjà moins de choses à taper)</p> 
<pre class="prettyprint lang-xml">
  &lt;profiles&gt;
  ...
    &lt;profile&gt;
      &lt;id&gt;alwaysActiveProfile&lt;/id&gt;
      &lt;properties&gt;
        &lt;downloadSources&gt;true&lt;/downloadSources&gt;
      &lt;/properties&gt;
    &lt;/profile&gt;
  ...
  &lt;/profiles&gt;

  &lt;activeProfiles&gt;
  ...
    &lt;activeProfile&gt;alwaysActiveProfile&lt;/activeProfile&gt;
  ...
  &lt;/activeProfiles&gt;
</pre> 
<p>Maintenant, les sources vont se télécharger automatiquement.</p>
