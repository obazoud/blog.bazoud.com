---
template: article.jade
title: Tomcat et commons-logging
date: '2007-02-06T22:14:00.000Z'
author: Olivier
aliases: ['/post/2007/02/06/tomcat-et-commons-logging/', '/post/2007/02/06/tomcat-et-commons-logging/']
categories: [Uncategorized]
tags: [tomcat,java,commons-logging]
excerpt: "<p>Si vous avez l'erreur suivante au démarrage de Tomcat 5.5.20 avec la version 1.1 de commons-logging :</p> <pre> SEVERE: Error reading tld listeners java.lang.NullPointerException java.lang.NullPointerException </pre>"
---

<p>Si vous avez l'erreur suivante au démarrage de Tomcat 5.5.20 avec la version 1.1 de commons-logging :</p> 
<pre class="prettyprint lang-bsh">
 SEVERE: Error reading tld listeners java.lang.NullPointerException java.lang.NullPointerException 
</pre>

<pre class="prettyprint lang-bsh">
SEVERE: Error reading tld listeners java.lang.NullPointerException
java.lang.NullPointerException
        at org.apache.log4j.Category.isEnabledFor(Category.java:746)
        at org.apache.commons.logging.impl.Log4JLogger.isTraceEnabled(Log4JLogger.java:327)
        at org.apache.catalina.startup.TldConfig.tldScanResourcePaths(TldConfig.java:581)
        at org.apache.catalina.startup.TldConfig.execute(TldConfig.java:282)
        at org.apache.catalina.core.StandardContext.processTlds(StandardContext.java:4302)
        at org.apache.catalina.core.StandardContext.start(StandardContext.java:4139)
        at org.apache.catalina.core.ContainerBase.addChildInternal(ContainerBase.java:759)
        at org.apache.catalina.core.ContainerBase.addChild(ContainerBase.java:739)
        at org.apache.catalina.core.StandardHost.addChild(StandardHost.java:524)
        at org.apache.catalina.startup.HostConfig.deployDirectory(HostConfig.java:904)
        at org.apache.catalina.startup.HostConfig.deployDirectories(HostConfig.java:867)
        at org.apache.catalina.startup.HostConfig.deployApps(HostConfig.java:474)
        at org.apache.catalina.startup.HostConfig.start(HostConfig.java:1122)
        at org.apache.catalina.startup.HostConfig.lifecycleEvent(HostConfig.java:310)
        at org.apache.catalina.util.LifecycleSupport.fireLifecycleEvent(LifecycleSupport.java:119)
        at org.apache.catalina.core.ContainerBase.start(ContainerBase.java:1021)
        at org.apache.catalina.core.StandardHost.start(StandardHost.java:718)
        at org.apache.catalina.core.ContainerBase.start(ContainerBase.java:1013)
        at org.apache.catalina.core.StandardEngine.start(StandardEngine.java:442)
        at org.apache.catalina.core.StandardService.start(StandardService.java:450)
        at org.apache.catalina.core.StandardServer.start(StandardServer.java:709)
        at org.apache.catalina.startup.Catalina.start(Catalina.java:551)
        at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
        at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:39)
        at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:25)
        at java.lang.reflect.Method.invoke(Method.java:585)
        at org.apache.catalina.startup.Bootstrap.start(Bootstrap.java:294)
        at org.apache.catalina.startup.Bootstrap.main(Bootstrap.java:432)
</pre> 
<p>Ceci est un bug répertorité <a href="http://issues.apache.org/bugzilla/show_bug.cgi?id=39090#c5">ici</a> : il faut forcer la version commons-logging 1.0.4 dans votre WEB-INF/lib.</p> <p>Et votre Tomcat démarre à nouveau :</p> 
<pre class="prettyprint lang-bsh">
Feb 6, 2007 11:13:14 PM org.apache.catalina.core.AprLifecycleListener lifecycleEvent
INFO: The Apache Tomcat Native library which allows optimal performance in production environments was not found on the java.library.path: /home/bazoud/java/jdk/jdk1.5.0_10/jre/lib/i386/client:/home/bazoud/java/jdk/jdk1.5.0_10/jre/lib/i386:/home/bazoud/java/jdk/jdk1.5.0_10/jre/../lib/i386:/usr/lib/firefox/
Feb 6, 2007 11:13:14 PM org.apache.coyote.http11.Http11BaseProtocol init
INFO: Initializing Coyote HTTP/1.1 on http-8080
Feb 6, 2007 11:13:14 PM org.apache.catalina.startup.Catalina load
INFO: Initialization processed in 2495 ms
Feb 6, 2007 11:13:15 PM org.apache.catalina.core.StandardService start
INFO: Starting service Catalina
Feb 6, 2007 11:13:15 PM org.apache.catalina.core.StandardEngine start
INFO: Starting Servlet Engine: Apache Tomcat/5.5.20
Feb 6, 2007 11:13:15 PM org.apache.catalina.core.StandardHost start
INFO: XML validation disabled
log4j:WARN No appenders could be found for logger (org.apache.catalina.startup.TldConfig).
log4j:WARN Please initialize the log4j system properly.
Feb 6, 2007 11:13:19 PM org.apache.coyote.http11.Http11BaseProtocol start
INFO: Starting Coyote HTTP/1.1 on http-8080
Feb 6, 2007 11:13:20 PM org.apache.jk.common.ChannelSocket init
INFO: JK: ajp13 listening on /0.0.0.0:8009
Feb 6, 2007 11:13:20 PM org.apache.jk.server.JkMain start
INFO: Jk running ID=0 time=0/169  config=null
Feb 6, 2007 11:13:20 PM org.apache.catalina.storeconfig.StoreLoader load
INFO: Find registry server-registry.xml at classpath resource
Feb 6, 2007 11:13:20 PM org.apache.catalina.startup.Catalina start
INFO: Server startup in 5554 ms
</pre>