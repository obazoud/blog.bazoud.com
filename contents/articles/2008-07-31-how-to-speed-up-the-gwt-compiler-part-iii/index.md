---
template: article.jade
title: How to speed up the GWT compiler ? (Part III)
date: '2008-07-31T21:08:00.000Z'
author: Olivier
aliases: ['/post/2008/07/31/how-to-speed-up-the-gwt-compiler-part-iii/', '/post/2008/07/31/can-i-speed-up-the-gwt-compiler-part-iii/', '/post/2008-07-31-can-i-speed-up-the-gwt-compiler-part-iii.html']
categories: [Uncategorized]
tags: [GWT]
---

<h3>English version</h3> <p><a href="/post/2008-07-31-how-to-speed-up-the-gwt-compiler-part-i.html">How to speed up GWT compiler</a>, the main idea is to reduce GWT permutations.</p> <p>To manage the permutations, I build my own version of GWT 1.5 named GWT 1.5 r2030-olivier.</p> <p>I am using 1.5 M1:</p> <ul> <li>svn co http://google-web-toolkit.googlecode.com/svn/trunk -r2030</li> <li>Edit I18N.gwt.xml to remove default locale and force &quot;fr_FR&quot; as &quot;default&quot; locale</li> </ul>
<pre class="prettyprint">
Index: trunk/user/src/com/google/gwt/i18n/I18N.gwt.xml
===================================================================
--- trunk/user/src/com/google/gwt/i18n/I18N.gwt.xml     (revision 2030)
+++ trunk/user/src/com/google/gwt/i18n/I18N.gwt.xml     (working copy)
@@ -18,7 +18,7 @@
 
        &lt;!-- Browser-sensitive code should use the 'locale' client property. --&gt;
        &lt;!-- 'default' is always defined.                                    --&gt;
-       &lt;define-property name="locale" values="default" /&gt;
+       &lt;define-property name="locale" values="fr_FR" /&gt;
 
        &lt;property-provider name="locale"&gt;
                &lt;![CDATA[
</pre>
 <ul> <li>Edit UserAgent.gwt.xml and, in my case, remove unused some browsers : safari, opera, gecko (old firefox/mozilla)</li> </ul> 
<pre  class="prettyprint">
Index: trunk/user/src/com/google/gwt/user/UserAgent.gwt.xml
===================================================================
--- trunk/user/src/com/google/gwt/user/UserAgent.gwt.xml        (revision 2030)
+++ trunk/user/src/com/google/gwt/user/UserAgent.gwt.xml        (working copy)
@@ -19,7 +19,7 @@
 &lt;module&gt;
 
   &lt;!-- Browser-sensitive code should use the 'user.agent' property --&gt;
-  &lt;define-property name="user.agent" values="ie6,gecko,gecko1_8,safari,opera"/&gt;
+  &lt;define-property name="user.agent" values="ie6,gecko1_8"/&gt;
 
   &lt;property-provider name="user.agent"&gt;&lt;![CDATA[
       var ua = navigator.userAgent.toLowerCase();
@@ -27,11 +27,7 @@
           return (parseInt(result[1]) * 1000) + parseInt(result[2]);
       };
 
-      if (ua.indexOf("opera") != -1) {
-        return "opera";
-      } else if (ua.indexOf("webkit") != -1) {
-        return "safari";
-      } else if (ua.indexOf("msie") != -1) {
+      if (ua.indexOf("msie") != -1) {
         var result = /msie ([0-9]+)\.([0-9]+)/.exec(ua);
         if (result && result.length == 3) {
           if (makeVersion(result) >= 6000) {
@@ -44,7 +40,6 @@
           if (makeVersion(result) >= 1008)
             return "gecko1_8";
           }
-        return "gecko";
       }
       return "unknown";
   ]]&gt;&lt;/property-provider&gt;
</pre>
<p>With my own build, GWT compiler speeds up my project compilation :</p> <ul> <li>12mn with GWT 1.5 r2030</li> <li>4mn with GWT 1.5 r2030-olivier</li> <li>1m15s with GWT 1.5 r2030-olivier + no additional locale</li> <li>1mn with GWT 1.5 r2030-olivier + no locale + gecko1_8</li> </ul> <p>This is an amazing gain : 12mn to 1mn</p>
