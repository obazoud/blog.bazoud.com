---
template: article.jade
title: Patch GWT 1.5 / Hibernate4GWT
date: '2008-02-06T21:26:00.000Z'
author: Olivier
aliases: ['/post/2008/02/06/patch-gwt-1-5-hibernate4gwt/', '/post/2008/02/06/patch-gwt-1-5-hibernate4gwt/', '/post/2008/02/06/Patch-GWT-15-/-Hibernate4GWT']
categories: [Uncategorized]
tags: [GWT,jdk5,java,Hibernate,Hibernate4gwt,generics]
---

<p>Pour utiliser Hibernate4GWT et GWT 1.5, il faut patcher Hibernate4GWT la partie &quot;emul&quot; sinon vous pouvez avoir ce genre de message à la compilation</p> <pre class="prettyprint">
[java] [ERROR] Line 22: The interface Comparable cannot be implemented more than once with different arguments: Comparable and Comparable<Date> 
[java] [ERROR] Line 86: Name clash: The method compareTo(Object) of type Date has the same erasure as compareTo(T) of type Comparable<T> 
but does not override it 
</pre>
 <p>En fait, l'émulation JRE de Date et Timestamp ne compile plus avec un JDK 1.5. Voici les patches à passer sur Hibernate4GWT 1.3 :</p> 
<pre class="prettyprint">
Index: src/net/sf/hibernate4gwt/emul/java/sql/Timestamp.java
===================================================================
--- src/net/sf/hibernate4gwt/emul/java/sql/Timestamp.java       (revision 133)
+++ src/net/sf/hibernate4gwt/emul/java/sql/Timestamp.java       (working copy)
@@ -22,7 +22,7 @@
  * Emulation of the java.sql.TimeStamp class
  * Based on the source of java.util.Date emulation from GWT
  */
-public class Timestamp extends java.util.Date implements Cloneable, Comparable{
+public class Timestamp extends java.util.Date implements Cloneable {
   /**
    * Used only by toString().
    */
@@ -90,22 +90,6 @@
     return clone;
   }
 
-  public int compareTo(Timestamp other) {
-    long thisTime = getTime();
-    long otherTime = other.getTime();
-    if (thisTime < otherTime) {
-      return -1;
-    } else if (thisTime > otherTime) {
-      return 1;
-    } else {
-      return getNanos() - other.getNanos();
-    }
-  }
-
-  public int compareTo(Object other) {
-    return compareTo((Timestamp) other);
-  }
-
   /**
    *  Return the names for the days of the week as specified by the Date
    *  specification.
@@ -269,4 +253,4 @@
     this.jsdate = new Date(date);
     this.nanos = 0;
   }-*/;
-}
\ No newline at end of file
+}
</pre>
<br />
<pre class="prettyprint">
Index: src/net/sf/hibernate4gwt/emul/java/sql/Date.java
===================================================================
--- src/net/sf/hibernate4gwt/emul/java/sql/Date.java    (revision 133)
+++ src/net/sf/hibernate4gwt/emul/java/sql/Date.java    (working copy)
@@ -19,7 +19,7 @@
  * Emulation of the java.sql.Date
  * Based on the source of java.util.Date emulation from GWT
  */
-public class Date extends java.util.Date implements Cloneable, Comparable {
+public class Date extends java.util.Date implements Cloneable {
   /**
    * Used only by toString().
    */
@@ -71,22 +71,6 @@
     return new Date(getTime());
   }
 
-  public int compareTo(Date other) {
-    long thisTime = getTime();
-    long otherTime = other.getTime();
-    if (thisTime < otherTime) {
-      return -1;
-    } else if (thisTime > otherTime) {
-      return 1;
-    } else {
-      return 0;
-    }
-  }
-
-  public int compareTo(Object other) {
-    return compareTo((Date) other);
-  }
-
   /**
    *  Return the names for the days of the week as specified by the Date
    *  specification.
</pre>
<br />
<pre class="prettyprint">
Index: build.xml
===================================================================
--- build.xml   (revision 133)
+++ build.xml   (working copy)
@@ -3,7 +3,7 @@
 
        &lt;!-- Properties --&gt;
     &lt;property environment="env"/&gt;
-    &lt;property name="version" value="1.0.3"/&gt;
+    &lt;property name="version" value="1.0.3-r133-patch"/&gt;
        &lt;property name="project" value="hibernate4gwt" /&gt;
        &lt;property name="output.jar" value="${project}-${version}.jar" /&gt;
</pre>
