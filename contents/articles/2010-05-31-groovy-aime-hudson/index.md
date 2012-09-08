---
template: article.jade
title: Groovy aime Hudson
date: '2010-05-31T18:29:53.000Z'
author: Olivier
aliases: ['/?p=399', '/post/2010/05/31/groovy-aime-hudson/']
categories: [Uncategorized]
tags: []
---

A travers cet article, je vous propose quelques pistes pour administrer <a href="http://hudson-ci.org" target="_blank">Hudson</a> avec l'aide <a href="http://groovy.codehaus.org" target="_blank">Groovy</a>. Personnellement, j'utilise :
<ul>
	<li>des scripts avec <a href="http://wiki.hudson-ci.org/display/HUDSON/Remote+access+API" target="_blank">Hudson Remote API</a> et <a href="http://groovy.codehaus.org" target="_blank">Groovy</a></li>
	<li>la console <a href="http://groovy.codehaus.org" target="_blank">Groovy</a> de <a href="http://hudson-ci.org" target="_blank">Hudson</a></li>
</ul>
I. Hudson Remote API

Une des problématiques de mon projet est le nombre de module ainsi que le nombre de version associés à maintenir. Le nombre de jobs à administrer dans Hudson se situe autour de 230. Il est évident que je ne peux pas les maintenir à la main, sans compter que le nombre de projet et de nombres versions augmentent régulièrement. J'ai créé un petit outil qui permet de scanner le repository SVN et de créer les jobs Hudson associés, j'ai choisi la <a href="http://wiki.hudson-ci.org/display/HUDSON/Remote+access+API" target="_blank">Hudson Remote API</a> et de coder en groovy.

J'ai créé 3 fichiers Groovy :
<ul>
	<li>Hudson.groovy qui assure la relation avec Hudson</li>
	<li>Subversion.groovy communique avec SVN à l'aide <a href="http://svnkit.com" target="_blank">SVNKit</a></li>
	<li>svn2Hudson.groovy qui combine les deux : à partir d'une url donnée, je vais récuperer les répertoires conformes à une pattern de nom et créer/mettre à jour les jobs Hudson</li>
</ul>
Pour illustrer par l'exemple ces scripts, nous allons créer/mettre à jour les jobs Hudson pour le projet opensource <a href="http://www.hibernate.org/" target="_blank">Hibernate</a>. Les jobs concernent uniquement trunk et les branches commencant par le mot "Branch".

Il faut avoir installer un JDK, Hudson (avec le JDK et Maven configuré) et Groovy (configuré <a href="http://groovy.codehaus.org/GroovyWS+grape+config+file" target="_blank">configurer grape</a> pour le téléchargement SVNKit, ...).

Ci-joint les sources :

Hudson.groovy
<pre class="prettyprint">import org.xml.sax.SAXParseException
import groovy.xml.MarkupBuilder
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpMethod;
import org.apache.commons.httpclient.HttpMethodBase;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.methods.PostMethod;
/**
 * @author Olivier Bazoud
 */
@Grab(group = 'commons-httpclient', module = 'commons-httpclient', version = '3.1')
class Hudson {
    def baseUrl, hudsonBaseUrl;
    def connectionManagerTimeout = 15000, connectionTimeout = 15000, soTimeout = 15000;

    // Ping hudson
    def ping() {
        def client = new HttpClient()
        def getMethod = new GetMethod(baseUrl + hudsonBaseUrl)
        client.params.connectionManagerTimeout = connectionManagerTimeout
        client.httpConnectionManager.params.connectionTimeout = connectionTimeout
        client.params.soTimeout = soTimeout
        def status = client.executeMethod(getMethod)
        if (status != HttpStatus.SC_OK) {
            throw new RuntimeException("Ping failed : " + status);
        }
    }

    // add a job
    def put(String jobName, String config) {
        def client = new HttpClient()
        def postMethod = new PostMethod(baseUrl + hudsonBaseUrl + "createItem?name=$jobName");
        client.params.connectionManagerTimeout = connectionManagerTimeout
        client.httpConnectionManager.params.connectionTimeout = connectionTimeout
        client.params.soTimeout = soTimeout
        postMethod.setRequestHeader("Content-type", "application/xml; charset=ISO-8859-1")
        postMethod.setRequestBody(config)
        def status = client.executeMethod(postMethod)
        if (status != HttpStatus.SC_OK) {
            if (status != HttpStatus.SC_BAD_REQUEST) {
                throw new RuntimeException("Put $jobName failed : " + status, new RuntimeException(postMethod.getResponseBodyAsString()))
            }
        } else {
            println "Put $jobName created."
        }
    }

    // update a job
    def update(String jobName, String config) {
        def client = new HttpClient()
        def postMethod = new PostMethod(baseUrl + hudsonBaseUrl + "/job/$jobName/config.xml");
        client.params.connectionManagerTimeout = connectionManagerTimeout
        client.httpConnectionManager.params.connectionTimeout = connectionTimeout
        client.params.soTimeout = soTimeout
        postMethod.setRequestHeader("Content-type", "application/xml; charset=ISO-8859-1")
        postMethod.setRequestBody(config)
        def status = client.executeMethod(postMethod)
        if (status != HttpStatus.SC_OK) {
            throw new RuntimeException("Updating $jobName failed : " + status, new RuntimeException(postMethod.getResponseBodyAsString()))
        } else {
            println "$jobName updated."
        }
    }

    // get job
    def fetch(String jobName, boolean failIfNotExist) {
        def client = new HttpClient()
        def getMethod = new GetMethod(baseUrl + hudsonBaseUrl + "job/$jobName/config.xml")

        client.params.connectionManagerTimeout = connectionManagerTimeout
        client.httpConnectionManager.params.connectionTimeout = connectionTimeout
        client.params.soTimeout = soTimeout

        def status = client.executeMethod(getMethod)
        if (status != HttpStatus.SC_OK) {
            if (failIfNotExist) {
                throw new RuntimeException("Get xml $jobName failed : " + status)
            } else {
                return null;
            }

        }

        def root = new XmlParser().parseText(getMethod.getResponseBodyAsString())
    }

    // saveOrUpdate a job
    def saveOrUpdate(String jobName, String config) {
        if (fetch(jobName, false) != null) {
            update(jobName, config)
        } else {
            put(jobName, config)
        }
    }

    def createMaven2Config(String svnUrl) {
        def writer = new StringWriter()
        def xml = new MarkupBuilder(writer)
        xml.'maven2-moduleset'() {
            scm(class : 'hudson.scm.SubversionSCM') {
                locations() {
                    'hudson.scm.SubversionSCM_-ModuleLocation'() {
                        remote("$svnUrl")
                        local('wk')
                     }
                }
                useUpdate('true')
            }
            disabled('false')
            jdk('jdk1.6')
            goals('clean package')
            mavenName('maven-2.x')
            aggregatorStyleBuild('true')
        }
        return writer.toString()
    }
}</pre>
Subversion.groovy
<pre class="prettyprint">import org.tmatesoft.svn.core.internal.io.fs.FSRepositoryFactory
import org.tmatesoft.svn.core.internal.io.dav.DAVRepositoryFactory
import org.tmatesoft.svn.core.internal.io.svn.SVNRepositoryFactoryImpl
import org.tmatesoft.svn.core.SVNURL
import org.tmatesoft.svn.core.io.SVNRepository
import org.tmatesoft.svn.core.io.SVNRepositoryFactory
import org.tmatesoft.svn.core.wc.SVNWCUtil
import static org.tmatesoft.svn.core.SVNNodeKind.DIR
/**
 * @author Olivier Bazoud
 */
@Grab(group = 'org.tmatesoft.svnkit', module = 'svnkit', version = '1.3.3')
class Subversion {
    def url;
    def name;
    def password;
    def repository;

    def connect() {
        println "Connecting to $url ..."
        setup();
        repository = SVNRepositoryFactory.create(SVNURL.parseURIDecoded(url));
        def authManager = SVNWCUtil.createDefaultAuthenticationManager(null, name, password, false);
        repository.setAuthenticationManager(authManager);
        println 'Connection OK.'
    } 

    def disconnect() {
        repository.closeSession()
    }

    def setup() {
        DAVRepositoryFactory.setup();
        SVNRepositoryFactoryImpl.setup();
        FSRepositoryFactory.setup();
    }

    def fetch(def path, def includes) {
        def map = [:]
        repository.getDir(path, -1, null, (Collection) null).each { entry -&gt;
            if (entry.getKind() == DIR) {
                if (includes.matcher(entry.getName()).matches()) {
                    map.put(entry.name.toLowerCase(), entry.getURL().toString())
                }
            }
        }
        return map
    }
}</pre>
svn2Hudson.groovy
<pre class="prettyprint">#!/usr/bin/env groovy
// @author Olivier BAZOUD
def baseUrl = 'http://localhost:8080'
def hudsonBaseUrl = '/'
def svnBaseUrl = 'http://anonsvn.jboss.org/repos/hibernate'
def hudson = new Hudson(baseUrl : "$baseUrl", hudsonBaseUrl : "$hudsonBaseUrl")
def subversion = new Subversion(url : svnBaseUrl, name : 'anonymous', password : 'anonymous')
def map = [:]
// Subversion
try {
    subversion.connect()
    println "Fetching ..."
    map &lt;&lt; subversion.fetch("core", ~/trunk/)
    map &lt;&lt; subversion.fetch("core/branches", ~/Branch.*/)
} finally {
    subversion.disconnect()
}
// Hudson
hudson.ping()
map.each {
    hudson.saveOrUpdate("hibernate-" + it.key, hudson.createMaven2Config(it.value))
}</pre>
Maintenant, on peut lancer le scripts qui va mettre à jour les jobs Hudson :
<pre class="prettyprint lang-bsh">./svn2Hudson.groovy
Connecting to http://anonsvn.jboss.org/repos/hibernate ...
Connection OK.
Fetching ...
Put hibernate-trunk created.
Put hibernate-branch_3_1 created.
Put hibernate-branch_3_2 created.
Put hibernate-branch_3_3 created.
Put hibernate-branch_3_2_4_sp1_cp created.
Put hibernate-branch_3_5 created.
Put hibernate-branch_3_3_2_ga_cp created.</pre>
Liste des jobs Hudson :
<a href="/images/hudson-groovy.png"><img class="aligncenter size-medium wp-image-401" title="hudson-groovy" src="/images/hudson-groovy-300x235.png" alt="Création des jobs Hudson avec Groovy" width="300" height="235" /></a>

A noter que si l'on relance le scripts, les jobs sont mis à jour ;
<pre class="prettyprint lang-bsh">Connecting to http://anonsvn.jboss.org/repos/hibernate ...
Connection OK.
Fetching ...
hibernate-trunk updated.
hibernate-branch_3_1 updated.
hibernate-branch_3_2 updated.
hibernate-branch_3_3 updated.
hibernate-branch_3_2_4_sp1_cp updated.
hibernate-branch_3_5 updated.
hibernate-branch_3_3_2_ga_cp updated.</pre>
Dans cet artcle, j'ai volontairement simplifier le script que j'utilise pour un exemple simple d'utilisation et de compréhension.
Par exemple, la génération de la configuration Hudson s'adpate suivant la nature du projet :
<ul>
	<li>le goal maven clean package ou clean deploy</li>
	<li>le MAVEN_OPTS avec plus ou moins de mémoire et différentes options</li>
	<li>configuration de nombreux plugins : JIRA, <a href="http://www.sonarsource.org/" target="_blank">sonar</a>, Mail, IRC, ...</li>
	<li>il existe plusieurs options en arguments : create only ou update only</li>
	<li>de nombreuse fonctionnalités sont présentes : lancer un job, le détruire, lister tous les jobs, job avec une configuration ant, ...</li>
</ul>
De même que le parcours SVN n'est pas aussi simpliste, j'utilise plusieurs modules, les externals SVN.

Cerise que le gateau, le script svn2Hudson est dans un job Hudson qui se lance tous les matins, les jobs Hudson s'administrent tout seul.
Depuis Avril 2009, date à laquelle j'ai créé ce script, je n'ai plus à jamais à créer de jobs Hudson.
De plus, lors des updates de version de Hudson (toutes les semaines) et les ajouts/updates de plugins, je n'ai qu'à adapter ces scripts, cela se fait rapidemment et tous les jobs sont opérationnelles avec la nouvelle configuration.

II. La console Groovy de Hudson

La console Groovy permet d'interagir "en live" avec votre instance web Hudson. Je l'utilise pour l'administration quotidienne à l'aide de script assez simple. Cette console se situe ici : http://hudsoninstance/script

Quelques exemples sont disponibles : <a href="http://wiki.hudson-ci.org/display/HUDSON/Hudson+Script+Console" target="_blank">http://wiki.hudson-ci.org/display/HUDSON/Hudson+Script+Console</a>

Pour illustrer les scripts suivants, je vais utiliser l'instance Hudson sur laquelle je viens de créer les jobs Hibernate.
<pre class="prettyprint">// Compter certains les jobs
hudsonInstance = hudson.model.Hudson.instance
allItems = hudsonInstance.items
jobs = allItems.findAll{job -&gt; job.isBuildable() &amp;&amp; job.name =~ "hibernate-.*"}
println jobs.size()</pre>
<a href="/images/hudson-groovy-2.png"><img class="aligncenter size-full wp-image-417" title="hudson-groovy-2" src="/images/hudson-groovy-2.png" alt="" width="534" height="316" /></a>
<pre class="prettyprint">// Relancer tous les jobs
hudsonInstance = hudson.model.Hudson.instance
allItems = hudsonInstance.items
jobs = allItems.findAll{job -&gt; job.isBuildable()}
cause = new hudson.model.Cause.RemoteCause("localhost", "bulk build")
jobs.each{ run -&gt; run.scheduleBuild(cause)}</pre>
<pre class="prettyprint">// Relancer les jobs failed
hudsonInstance = hudson.model.Hudson.instance
allItems = hudsonInstance.items
jobs = allItems.findAll{job -&gt; job.isBuildable() &amp;&amp; job.lastBuild != null &amp;&amp; job.lastBuild.result == hudson.model.Result.FAILURE}
cause = new hudson.model.Cause.RemoteCause("localhost", "bulk build")
jobs.each{ run -&gt; run.scheduleBuild(cause)}</pre>
<pre class="prettyprint">// Detruire tous certains jobs
hudsonInstance = hudson.model.Hudson.instance
allItems = hudsonInstance.items
jobs = allItems.findAll{job -&gt; job.isBuildable() &amp;&amp; job.name =~ "hibernate-.*"}
jobs.each{ run -&gt; run.delete()}</pre>
<a href="/images/hudson-groovy3.png"><img class="aligncenter size-large wp-image-421" title="hudson-groovy3" src="/images/hudson-groovy3-1024x232.png" alt="" width="1024" height="232" /></a>

Pour un exemple un peu plus compliqué, je vous renvoie vers <a href="http://blog.aheritier.net/convertir-en-masse-les-notifications-standard-hudson-par-celles-du-plugin-email-ext" target="_blank">Le blog d’Arnaud</a> qui a converti en masse les notifications standard Hudson par celles du plugin Email-Ext.

III. Conclusion

Avec l'API Remote Access et avec la console Groovy de Hudson, vous pouvez aisément administrer votre instance Hudson.
Si vous faites ou avez de tels scripts, tenez moi au courant.