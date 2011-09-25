---
layout: post
title: Installation de ActiveMQ sous Ubuntu
date: '2007-02-03T14:59:00.000Z'
author: Olivier
aliases: ['/post/2007/02/03/installation-de-activemq-sous-ubuntu/', '/post/2007/02/03/installation-de-activemq-sous-ubuntu/']
categories: [Uncategorized]
tags: [Ubuntu,java,JMS,Derby,ActiveMQ]
excerpt: <p>ActiveMQ est Message Bus open source avec le support complet de JMS 1.1/J2EE 1.4 traitant les messages transient, persistant, transactionnelle et XA.</p> <p>Pour l'installation, il faut :</p>
---

<p>ActiveMQ est Message Bus open source avec le support complet de JMS 1.1/J2EE 1.4 traitant les messages transient, persistant, transactionnelle et XA.</p> <p>Pour l'installation, il faut :</p>
<!--more-->
<ul> <li>Télécharger la <a href="http://incubator.apache.org/activemq/activemq-410-release.html">dernière version de ActiveMQ</a>, c'est à dire la <a href="http://incubator.apache.org/activemq/2007/01/19/activemq-410-released.html">version 4.1.0 sortie au début de cette année</a>. Son petit nom est apache-activemq-4.1.0-incubator.tar.gz</li> <li>Extraire les fichiers :</li> </ul> 
<pre class="prettyprint lang-bsh">
% tar zxvf apache-activemq-4.1.0-incubator.tar.gz 
</pre> 
<ul> <li>Pour lancer ActiveMQ, aller dans le répertoire d'installation et faites :</li> </ul> 
<pre class="prettyprint lang-bsh">
% bin/activemq &gt; activemq-log.txt  2&gt;&amp;1 &amp; 
</pre>
<p>Pour voir ce qui se passe :</p> 
<pre class="prettyprint lang-bsh">
% tail -f activemq-log.txt
</pre> 
<p>Le fichier activemq-log.txt :</p> 
<pre class="prettyprint lang-bsh">
ACTIVEMQ_HOME: /home/bazoud/java/divers/activemq/apache-activemq-4.1.0-incubator
Loading message broker from: xbean:activemq.xml
INFO  BrokerService                  - ActiveMQ 4.1.0-incubator JMS Message Broker (localhost) is starting
INFO  BrokerService                  - For help or more information please see: http://incubator.apache.org/activemq/
INFO  ManagementContext              - JMX consoles can connect to service:jmx:rmi:///jndi/rmi://localhost:1099/jmxrmi
INFO  JDBCPersistenceAdapter         - Database driver recognized: [apache_derby_embedded_jdbc_driver]
INFO  DefaultDatabaseLocker          - Attempting to acquire the exclusive lock to become the Master broker
INFO  DefaultDatabaseLocker          - Becoming the master on dataSource: org.apache.derby.jdbc.EmbeddedDataSource@10ca208
INFO  JournalPersistenceAdapter      - Journal Recovery Started from: Active Journal: using 5 x 20.0 Megs at: /home/bazoud/java/divers/activemq/apache-activemq-4.1.0-incubator/activemq-data/journal
INFO  JournalPersistenceAdapter      - Journal Recovered: 0 message(s) in transactions recovered.
INFO  TransportServerThreadSupport   - Listening for connections at: tcp://bazoud-desktop:61616
INFO  TransportConnector             - Connector openwire Started
INFO  TransportServerThreadSupport   - Listening for connections at: ssl://bazoud-desktop:61617
INFO  TransportConnector             - Connector ssl Started
INFO  TransportServerThreadSupport   - Listening for connections at: stomp://bazoud-desktop:61613
INFO  TransportConnector             - Connector stomp Started
INFO  NetworkConnector               - Network Connector default-nc Started
INFO  BrokerService                  - ActiveMQ JMS Message Broker (localhost, ID:bazoud-desktop-57296-1170513236676-1:0) started
</pre>
<pre class="prettyprint lang-bsh">
netstat -an|grep 61616
</pre>
<pre class="prettyprint lang-bsh">
tcp6       0      0 :::61616                :::*                    LISTEN
</pre>
<p>Il y a bien quelqu'un qui écoute sur le port 61616 :)</p> <p>A noter que ActiveMQ utilise la base <a href="http://db.apache.org/derby/">Apache Derby</a>.</p>
