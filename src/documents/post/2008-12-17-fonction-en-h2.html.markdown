---
layout: post
title: How to create Oracle function (trunc, decode, ...) in H2 ?
date: '2008-12-17T15:56:00.000Z'
author: Olivier
aliases: ['/post/2008/12/17/how-to-create-oracle-function-trunc-decode-in-h2/', '/post/2008/12/17/fonction-en-h2/', '/post/2008/07/31/Fonction-en-H2']
categories: [Uncategorized]
tags: [Oracle,java,h2]
---

<p>I use Oracle in production environment, but I use an embedded H2 database in unit tests. H2 does not support Oracle functions like TRUNC or DECODE.</p> <p>So, you can write yourself these functions ... in Java :)</p> 
<br />
<pre class="prettyprint lang-java">
// Oracle trunc like
public class H2Trunc {
  public final static Date trunc(Timestamp timeStamp) {
    return new Date(timeStamp.getTime());
  }
}
</pre>
<br />
<pre class="prettyprint lang-java">
// Oracle decode like
public class H2Decode {
  public final static String decode(String expression, String param1, String value1, String param2, String value2, String param3, String value3, String param4, String value4, String param5, String value5, String param6, String value6, String param7, String value7, String param8, String value8, String defaultValue) {
  if (StringUtils.equals(expression, param1)) {
    return value1;
 }
  if (StringUtils.equals(expression, param2)) {
    return value2;
 }
  if (StringUtils.equals(expression, param3)) {
    return value3;
 }
  if (StringUtils.equals(expression, param4)) {
    return value4;
 }
  if (StringUtils.equals(expression, param5)) {
    return value5;
 }
  if (StringUtils.equals(expression, param6)) {
    return value6;
 }
  if (StringUtils.equals(expression, param7)) {
    return value7;
 }
  if (StringUtils.equals(expression, param8)) {
    return value8;
 }
  return defaultValue;
  } 
}
</pre>
<br />
<p>In H2, create these functions with sql:</p>
<pre class="prettyprint">
CREATE ALIAS IF NOT EXISTS DECODE FOR \&quot;com.my.package.H2Decode.decode\&quot;; CREATE ALIAS IF NOT EXISTS TRUNC FOR \&quot;com.my.package.H2Trunc.trunc\&quot;
</pre>
