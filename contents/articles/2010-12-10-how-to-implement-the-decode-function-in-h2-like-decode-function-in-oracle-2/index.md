---
template: article.jade
title: How to implement the decode function in h2 like decode function in oracle ?
date: '2010-12-09T23:25:44.000Z'
author: Olivier
aliases: ['/?p=445', '/post/2010/12/10/how-to-implement-the-decode-function-in-h2-like-decode-function-in-oracle-2/']
categories: [Uncategorized]
tags: [Oracle,java,h2,decode]
---

<p>
In a previous article, <a href="/post/2008/12/17/fonction-en-h2"  target="_blank">How to create Oracle function (trunc, decode, …) in H2 ?</a>, I wrote a quick and (very) dirty implementation of Oracle Decode function in H2 Database.
<a href="http://download.oracle.com/docs/cd/B19306_01/server.102/b14200/functions040.htm" target="_blank">The syntax for the decode function is:</a>
decode( expr , search , result [, search , result]... [, default] )
DECODE compares expr to each search value one by one. If expr is equal to a search, then Oracle Database returns the corresponding result. If no match is found, then Oracle returns default. If default is omitted, then Oracle returns null.
</p>
<p>
You can write H2 function in Java :
</p>
<pre class="prettyprint">
CREATE ALIAS IF NOT EXISTS DECODE FOR \"com.mycompany.H2Decode.decode\"
</pre>
<p>
Looking closer how H2 manages user-defined function or alias, I read how FunctionAlias class finds the method according to an alias name. It checks argument length with the same name. So if I write decode with all (..almost) arguments, H2 will use the right one. Here we go.
 </p>
<br />
<pre class="prettyprint lang-java">
// Oracle decode like
public class H2Decode {
    private static String decode(String expression, String[] data, String defaultValue) {
        for (int i = 0; i < data.length;) {
            if (StringUtils.equals(expression, data[i])) {
                return data[i + 1];
            }
            i += 2;
        }
        return defaultValue;
    }

    public static final String decode(String expression, String param1, String value1) {
        return decode(expression, new String[] { param1, value1 }, null);
    }

    public static final String decode(String expression, String param1, String value1, String defaultValue) {
        return decode(expression, new String[] { param1, value1 }, defaultValue);
    }

    public static final String decode(String expression, String param1, String value1, String param2, String value2) {
        return decode(expression, new String[] { param1, value1, param2, value2 }, null);
    }

    public static final String decode(String expression, String param1, String value1, String param2, String value2,
            String defaultValue) {
        return decode(expression, new String[] { param1, value1, param2, value2 }, defaultValue);
    }

    public static final String decode(String expression, String param1, String value1, String param2, String value2, String param3,
            String value3) {
        return decode(expression, new String[] { param1, value1, param2, value2, param3, value3 }, null);
    }

    public static final String decode(String expression, String param1, String value1, String param2, String value2, String param3,
            String value3, String defaultValue) {
        return decode(expression, new String[] { param1, value1, param2, value2, param3, value3 }, defaultValue);
    }

    public static final String decode(String expression, String param1, String value1, String param2, String value2, String param3,
            String value3, String param4, String value4) {
        return decode(expression, new String[] { param1, value1, param2, value2, param3, value3, param4, value4 }, null);
    }

    public static final String decode(String expression, String param1, String value1, String param2, String value2, String param3,
            String value3, String param4, String value4, String defaultValue) {
        return decode(expression, new String[] { param1, value1, param2, value2, param3, value3, param4, value4 }, defaultValue);
    }

    public static final String decode(String expression, String param1, String value1, String param2, String value2, String param3,
            String value3, String param4, String value4, String param5, String value5) {
        return decode(expression, new String[] { param1, value1, param2, value2, param3, value3, param4, value4, param5, value5 },
                null);
    }

    public static final String decode(String expression, String param1, String value1, String param2, String value2, String param3,
            String value3, String param4, String value4, String param5, String value5, String defaultValue) {
        return decode(expression, new String[] { param1, value1, param2, value2, param3, value3, param4, value4, param5, value5 },
                defaultValue);
    }

    public static final String decode(String expression, String param1, String value1, String param2, String value2, String param3,
            String value3, String param4, String value4, String param5, String value5, String param6, String value6) {
        return decode(expression, new String[] { param1, value1, param2, value2, param3, value3, param4, value4, param5, value5,
                param6, value6 }, null);
    }

    public static final String decode(String expression, String param1, String value1, String param2, String value2, String param3,
            String value3, String param4, String value4, String param5, String value5, String param6, String value6,
            String defaultValue) {
        return decode(expression, new String[] { param1, value1, param2, value2, param3, value3, param4, value4, param5, value5,
                param6, value6 }, defaultValue);
    }

    public static final String decode(String expression, String param1, String value1, String param2, String value2, String param3,
            String value3, String param4, String value4, String param5, String value5, String param6, String value6, String param7,
            String value7) {
        return decode(expression, new String[] { param1, value1, param2, value2, param3, value3, param4, value4, param5, value5,
                param6, value6, param7, value7 }, null);
    }

    public static final String decode(String expression, String param1, String value1, String param2, String value2, String param3,
            String value3, String param4, String value4, String param5, String value5, String param6, String value6, String param7,
            String value7, String defaultValue) {
        return decode(expression, new String[] { param1, value1, param2, value2, param3, value3, param4, value4, param5, value5,
                param6, value6, param7, value7 }, defaultValue);
    }

    public static final String decode(String expression, String param1, String value1, String param2, String value2, String param3,
            String value3, String param4, String value4, String param5, String value5, String param6, String value6, String param7,
            String value7, String param8, String value8) {
        return decode(expression, new String[] { param1, value1, param2, value2, param3, value3, param4, value4, param5, value5,
                param6, value6, param7, value7, param8, value8 }, null);
    }

    public static final String decode(String expression, String param1, String value1, String param2, String value2, String param3,
            String value3, String param4, String value4, String param5, String value5, String param6, String value6, String param7,
            String value7, String param8, String value8, String defaultValue) {
        return decode(expression, new String[] { param1, value1, param2, value2, param3, value3, param4, value4, param5, value5,
                param6, value6, param7, value7, param8, value8 }, defaultValue);
    }

    public static final String decode(String expression, String param1, String value1, String param2, String value2, String param3,
            String value3, String param4, String value4, String param5, String value5, String param6, String value6, String param7,
            String value7, String param8, String value8, String param9, String value9) {
        return decode(expression, new String[] { param1, value1, param2, value2, param3, value3, param4, value4, param5, value5,
                param6, value6, param7, value7, param8, value8, param1, value8, param9, value9 }, null);
    }

    public static final String decode(String expression, String param1, String value1, String param2, String value2, String param3,
            String value3, String param4, String value4, String param5, String value5, String param6, String value6, String param7,
            String value7, String param8, String value8, String param9, String value9, String defaultValue) {
        return decode(expression, new String[] { param1, value1, param2, value2, param3, value3, param4, value4, param5, value5,
                param6, value6, param7, value7, param8, value8, param1, value8, param9, value9 }, defaultValue);
    }
}
</pre>
<br />

<pre class="prettyprint">
select decode('expression', 'param1', 'value1', 'defaultValue') returns defaultValue
select decode('param1', 'param1', 'value1', 'defaultValue') returns value1
select decode('param2', 'param1', 'value1', 'param2', 'value2', 'defaultValue') returns value2
select decode('param3', 'param1', 'value1', 'param2', 'value2', 'param3', 'value3', 'defaultValue') returns value3
...
</pre>

If, in your sql query, you have a decode function with more than 9 param/value couple, you need to write another method.
And if you think that copy/paste pattern is evil, take a look at <a href="http://svn.codehaus.org/groovy/trunk/groovy/groovy-core/src/main/org/codehaus/groovy/runtime/ArrayUtil.java" target="_blank">ArrayUtil from Groovy language</a>
