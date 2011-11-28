---
layout: post
title: How to speed up the GWT compiler ? (Part I)
date: '2008-07-31T21:01:00.000Z'
author: Olivier
aliases: ['/post/2008/07/31/how-to-speed-up-the-gwt-compiler-part-i/', '/post/2008/07/31/can-i-speed-up-the-gwt-compiler/', '/post/2008/07/31/Can-I-speed-up-the-GWT-compiler-Part-I', '/post/2008/07/31/can-i-speed-up-the-gwt-compiler-part-i', '/post/2008-07-31-can-i-speed-up-the-gwt-compiler.html']
categories: [Uncategorized]
tags: [maven,GWT,Oracle,jdk6,jdk5,svn,tomcat]
---

<h3>English version</h3> <p>I am working on an international CRM project based on <a href="http://java.sun.com/javase/6">JDK 6</a>, <a href="http://code.google.com/webtoolkit">GWT 1.5</a>, MyGWT/Ext GWT, <a href="http://tomcat.apache.org">tomcat 6</a>, <a href="http://maven.apache.org">maven</a>, <a href="http://www.hibernate.org">hibernate</a>, <a href="http://springframework.org">spring</a>, <a href="http://www.oracle.com">Oracle</a>, ...</p> <p>This business application must worked with Firefox 2, IE 6/7 and 9 locales (the target is about 15 locales).</p> <p>This a very large GWT application and it takes a long time to compile, about 12 mn &quot;only&quot; for GWT maven module : this is a long time in development mode.</p> <p>GWT spends time to compute permutations : create javascript file per browser/locale. With this kind of application, GWT produces 50 permutations :</p> <ul> <li>5 browsers : ie6, opera, gecko1_8, safari, gecko</li> <li>10 locales : default, de_DE, en_UK, fr_FR, hr_HR, hu_HU, it_IT, nl_NL, pl_PL, pt_PT</li> </ul> <p>This is my module.gwt.xml :</p>
<pre class="prettyprint lang-xml">
&lt;module&gt;
    &lt;!-- Inherit the core Web Toolkit stuff. --&gt;
    &lt;inherits name="com.google.gwt.user.User"&gt;&lt;/inherits&gt;
    &lt;inherits name="com.google.gwt.i18n.I18N"&gt;&lt;/inherits&gt;

    &lt;!-- Add support --&gt;
    &lt;inherits name="com.aaa.bbb.ccc.XXXCore"&gt;&lt;/inherits&gt;
    &lt;!-- Add mygwt support --&gt;
    &lt;inherits name="net.mygwt.ui.MyGWT"&gt;&lt;/inherits&gt;
    &lt;!-- Add hibernate4gwt support --&gt;
    &lt;inherits name="net.sf.hibernate4gwt.Hibernate4Gwt"&gt;&lt;/inherits&gt;
    &lt;inherits name="net.sf.hibernate4gwt.SqlDates"&gt;&lt;/inherits&gt;
    &lt;!-- Add gwt-log support --&gt;
    &lt;inherits name="com.allen_sauer.gwt.log.gwt-log"/&gt;&lt;/inherits&gt;

    &lt;!-- Add ftr-gwt-library-date --&gt;
    &lt;inherits name="org.cobogw.gwt.user.User"&gt;&lt;/inherits&gt;
    &lt;inherits name="eu.future.earth.gwt.FtrGwtLibrary"&gt;&lt;/inherits&gt;

    &lt;!-- GWT locale --&gt;
    &lt;extend-property name="locale" values="de_DE" &gt;&lt;/extend-property&gt;
    &lt;extend-property name="locale" values="en_UK" &gt;&lt;/extend-property&gt;
    &lt;extend-property name="locale" values="fr_FR" &gt;&lt;/extend-property&gt;
    &lt;extend-property name="locale" values="hr_HR" &gt;&lt;/extend-property&gt;
    &lt;extend-property name="locale" values="hu_HU" &gt;&lt;/extend-property&gt;
    &lt;extend-property name="locale" values="it_IT" &gt;&lt;/extend-property&gt;
    &lt;extend-property name="locale" values="pt_PT" &gt;&lt;/extend-property&gt;
    &lt;extend-property name="locale" values="pl_PL" &gt;&lt;/extend-property&gt;
    &lt;extend-property name="locale" values="nl_NL" &gt;&lt;/extend-property&gt;

    &lt;!-- Logging --&gt;
    &lt;extend-property name="log_level" values="DEBUG,INFO,WARN,FATAL,EROR,OFF" /&gt;
    &lt;set-property name="log_level" value="INFO" &gt;&lt;/extend-property&gt;

    &lt;!-- Turn off "DivLogger" --&gt;
    &lt;set-property name="log_DivLogger" value="DISABLED" &gt;&lt;/set-property&gt;

    &lt;!-- Specify the app entry point class. --&gt;
    &lt;entry-point class="com.aaa.bbb.ccc.XXXEntryPoint" &gt;&lt;/entry-point&gt;

</module>
</pre> 
<p>The main idea is to reduce permutations.</p> <p><a href="/post/2008-07-31-how-to-speed-up-the-gwt-compiler-part-ii.html">How to speed up the GWT compiler ? (Part II)</a>.</p> <p><a href="/post/2008-07-31-how-to-speed-up-the-gwt-compiler-part-iii.html">How to speed up the GWT compiler ? (Part III)</a>.</p> <h3>French version</h3> <p>Coming soon.</p>
