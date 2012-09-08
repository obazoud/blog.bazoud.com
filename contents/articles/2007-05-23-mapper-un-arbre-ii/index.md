---
template: article.jade
title: Mapper un arbre II
date: '2007-05-23T19:25:00.000Z'
author: Olivier
aliases: ['/post/2007/05/23/mapper-un-arbre-ii/', '/post/2007/05/23/mapper-un-arbre-ii/', '/post/2007/05/13/Mapper-un-arbre-II']
categories: [Uncategorized]
tags: [maven,jdk5,java,Hibernate,generics,eclipse,testng]
excerpt: <h3>Préparation</h3> <p>Avec <a href="http://maven.apache.org">Maven</a>, nous allons générer le projet et tous les éléments nécessaires pour <a href="http://www.eclipse.org">Eclipse</a>.</p>
---

<h3>Préparation</h3> <p>Avec <a href="http://maven.apache.org">Maven</a>, nous allons générer le projet et tous les éléments nécessaires pour <a href="http://www.eclipse.org">Eclipse</a>.</p>
<!--more-->
<p>Tout d'abord, la création du projet, avec Maven, c'est un jeu d'enfant</p> 
<pre class="prettyprint lang-bsh"> 
$ mvn archetype:create -DgroupId=com.blog -DartifactId=tree -DarchetypeArtifactId=maven-archetype-quickstart
</pre>
<p>Le résultat est le suivant :</p> 
<pre class="prettyprint lang-bsh"> 
tree
|-- pom.xml
`-- src
    |-- main
    |   `-- java
    |       `-- com
    |           `-- blog
    |               `-- App.java
    `-- test
        `-- java
            `-- com
                `-- blog
                    `-- AppTest.java
</pre> 
<p>Évidemment le App et AppTest ne resteront pas longtemps :)</p> <p>Editons le pom.xml pour ajouter les dépendances nécessaires :</p> <ul> <li>Fixer comme compilateur des sources et des tests le JDK 5</li> <li><a href="http://jakarta.apache.org/commons/lang">commons-lang</a> : pour equals/hashCode des objects persistants</li> <li><a href="http://www.springframework.org/">spring</a> pour la configuration des tests</li> <li>hibernate et hibernate-annotations</li> <li>ojdbc14 pour la base de tests</li> <li><a href="http://testng.org/doc/">testng</a> et <a href="http;//www.dbunit.org">dbunit</a> pour les tests</li> <li><a href="http://jakarta.apache.org/commons/dbcp/">commons-dbcp</a> pour la datasource</li> </ul> 
<pre class="prettyprint lang-xml">
&lt;project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd"&gt;
        &lt;modelVersion&gt;4.0.0&lt;/modelVersion&gt;
        &lt;groupId&gt;com.blog&lt;/groupId&gt;
        &lt;artifactId&gt;tree&lt;/artifactId&gt;
        &lt;packaging&gt;jar&lt;/packaging&gt;
        &lt;version&gt;1.0-SNAPSHOT&lt;/version&gt;
        &lt;name&gt;tree&lt;/name&gt;
        &lt;url&gt;http://maven.apache.org&lt;/url&gt;
        &lt;build&gt;
                &lt;finalName&gt;tree&lt;/finalName&gt;
                &lt;plugins&gt;
                        &lt;plugin&gt;
                                &lt;artifactId&gt;maven-compiler-plugin&lt;/artifactId&gt;
                                &lt;configuration&gt;
                                        &lt;source&gt;1.5&lt;/source&gt;
                                        &lt;target&gt;1.5&lt;/target&gt;
                                &lt;/configuration&gt;
                        &lt;/plugin&gt;
                &lt;/plugins&gt;
        &lt;/build&gt;
        &lt;dependencies&gt;
                &lt;dependency&gt;
                        &lt;groupId&gt;commons-lang&lt;/groupId&gt;
                        &lt;artifactId&gt;commons-lang&lt;/artifactId&gt;
                        &lt;version&gt;2.3&lt;/version&gt;
                &lt;/dependency&gt;
                &lt;dependency&gt;
                        &lt;groupId&gt;org.springframework&lt;/groupId&gt;
                        &lt;artifactId&gt;spring&lt;/artifactId&gt;
                        &lt;version&gt;2.0.4&lt;/version&gt;
                &lt;/dependency&gt;
                &lt;dependency&gt;
                        &lt;groupId&gt;org.hibernate&lt;/groupId&gt;
                        &lt;artifactId&gt;hibernate&lt;/artifactId&gt;
                        &lt;version&gt;3.2.2.ga&lt;/version&gt;
                &lt;/dependency&gt;
                &lt;dependency&gt;
                        &lt;groupId&gt;org.hibernate&lt;/groupId&gt;
                        &lt;artifactId&gt;hibernate-annotations&lt;/artifactId&gt;
                        &lt;version&gt;3.2.1.ga&lt;/version&gt;
                &lt;/dependency&gt;
                &lt;dependency&gt;
                        &lt;groupId&gt;com.oracle&lt;/groupId&gt;
                        &lt;artifactId&gt;ojdbc14&lt;/artifactId&gt;
                        &lt;version&gt;10.2.0.1.0&lt;/version&gt;
                        &lt;scope&gt;test&lt;/scope&gt;
                &lt;/dependency&gt;
                &lt;dependency&gt;
                        &lt;groupId&gt;org.testng&lt;/groupId&gt;
                        &lt;artifactId&gt;testng&lt;/artifactId&gt;
                        &lt;version&gt;5.1&lt;/version&gt;
                        &lt;scope&gt;test&lt;/scope&gt;
                        &lt;classifier&gt;jdk15&lt;/classifier&gt;
                &lt;/dependency&gt;
                &lt;dependency&gt;
                        &lt;groupId&gt;org.dbunit&lt;/groupId&gt;
                        &lt;artifactId&gt;dbunit&lt;/artifactId&gt;
                        &lt;version&gt;2.2&lt;/version&gt;
                        &lt;scope&gt;test&lt;/scope&gt;
                &lt;/dependency&gt;
            &lt;dependency&gt;
                        &lt;groupId&gt;commons-dbcp&lt;/groupId&gt;
                        &lt;artifactId&gt;commons-dbcp&lt;/artifactId&gt;
                        &lt;version&gt;1.2.2&lt;/version&gt;
                        &lt;scope&gt;runtime&lt;/scope&gt;
                &lt;/dependency&gt;
        &lt;/dependencies&gt;
&lt;/project&gt;
</pre>
