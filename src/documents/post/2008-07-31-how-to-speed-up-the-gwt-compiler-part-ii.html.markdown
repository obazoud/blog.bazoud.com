---
layout: post
title: How to speed up the GWT compiler ? (Part II)
date: '2008-07-31T21:03:00.000Z'
author: Olivier
aliases: ['/post/2008/07/31/how-to-speed-up-the-gwt-compiler-part-ii/', '/post/2008/07/31/can-i-speed-up-the-gwt-compiler-part-ii/', '/post/2008-07-31-can-i-speed-up-the-gwt-compiler-part-ii.html']
categories: [Uncategorized]
tags: [GWT]
---

<h3>English version</h3> <p><a href="/post/2008-07-31-how-to-speed-up-the-gwt-compiler-part-i.html">How to speed up GWT compiler</a>, the main idea is to reduce GWT permutations.</p>
 <p>1. Force a browser</p> <p>In your module.gwt.xml, force an user agent : <a href="http://developer.mozilla.org/en/docs/Gecko">gecko1_8 (Firefox 2)</a>.</p>
<pre class="prettyprint lang-xml">
    &lt;!-- User Agent --&gt;
    &lt;set-property name="user.agent" value="gecko1_8"&gt;&lt;/set-property&gt;
</pre>
<p>2. Use only one locale</p> <p>By default, GWT use &quot;default&quot; locale and comment yours locales.</p> 
<pre class="prettyprint lang-xml">
    &lt;!-- GWT locale
    &lt;extend-property name="locale" values="de_DE"&gt;&lt;/extend-property&gt;
    &lt;extend-property name="locale" values="en_UK"&gt;&lt;/extend-property&gt;
    &lt;extend-property name="locale" values="fr_FR"&gt;&lt;/extend-property&gt;
    &lt;extend-property name="locale" values="hr_HR"&gt;&lt;/extend-property&gt;
    &lt;extend-property name="locale" values="hu_HU"&gt;&lt;/extend-property&gt;
    &lt;extend-property name="locale" values="it_IT"&gt;&lt;/extend-property&gt;
    &lt;extend-property name="locale" values="pt_PT"&gt;&lt;/extend-property&gt;
    &lt;extend-property name="locale" values="pl_PL"&gt;&lt;/extend-property&gt;
    &lt;extend-property name="locale" values="nl_NL"&gt;&lt;/extend-property&gt;
    --&gt;
</pre>
<p><a href="/post/2008-07-31-how-to-speed-up-the-gwt-compiler-part-iii.html">How to speed up the GWT compiler ? (Part III)</a>.</p> 
<h3>French version</h3> <p>Coming soon.</p>
