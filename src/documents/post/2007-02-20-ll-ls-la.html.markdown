---
layout: post
title: ll = ls -la
date: '2007-02-20T17:25:00.000Z'
author: Olivier
aliases: ['/post/2007/02/20/ll-ls-la/', '/post/2007/02/20/ll-ls-la/']
categories: [Uncategorized]
tags: [Ubuntu,shell]
ignored: true
---

<p>Comment faire un alias ll ? En faisant un vi ~/.bashrc</p> 
<pre class="prettyprint lang-bsh">
# some more ls aliases 
#alias ll='ls -l' 
#alias la='ls -A' 
#alias l='ls -CF' 
alias ll='ls -la' 
</pre> 
<p>En puis il suffit de taper ll. Et on retrouve ses bonnes habitudes.</p>