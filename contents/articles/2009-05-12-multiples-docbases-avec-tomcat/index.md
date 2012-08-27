---
template: article.jade
title: Multiples docbases avec tomcat
date: '2009-05-12T19:50:00.000Z'
author: Olivier
aliases: ['/post/2009/05/12/multiples-docbases-avec-tomcat/', '/post/2009/05/12/multiples-docbases-avec-tomcat/', '/post/2009/15/12/Multiple-docbases-avec-tomcat']
categories: [Uncategorized]
tags: [tomcat,java]
---

Je travaille avec des applicatifs java possédant deux arborescences distinctes :
<ul>
	<li>le répertoire de la webapp contenant le cœur de l'applicatif : web.xml, context spring, jsp, images, css, ...</li>
	<li>un répertoire avec des jsp générées par un CMS</li>
</ul>
La solution précédente mettait en œuvre des <a href="http://en.wikipedia.org/wiki/Symbolic_link">symlink</a> entre ces deux répertoires pour qu'un <a href="http://tomcat.apache.org">Tomcat</a> puisse servir l'ensemble des jsp. N'aimant pas beaucoup cette solution (nombreux symblink, problème sous windows, dans quel sens faire le symlink ?, ...) , je me suis mis à la recherche d'une solution plus élégante.

Avec Tomcat, on peut spécifier seulement un seul docBase par context, c'est un peu limitatif. Apache permet de faire des AliasMatch, Alias, ...

Voici un fichier classique de configuration Tomcat : conf/server.xml
<pre class="prettyprint lang-xml">
	&lt;Host name="myhost" appBase="NO_WEBAPPS"&gt;
		&lt;Context path="" allowLinking="true" docBase="/path/to/my/webapp" override="true" reloadable="false"&gt;
	  	&lt;/Context&gt;
	&lt;/Host&gt;
</pre>

L'idée est de créer une extension à Tomcat, la technique consiste à ajouter des docbases supplémentaires.

Dans l'idéal, le fichier conf/server.xml serait de la forme :
<pre class="prettyprint lang-xml">
&lt;Host name="myhost" appBase="NO_WEBAPPS"&gt;
    &lt;Context path="" allowLinking="true" docBase="/path/to/my/webapp" override="true" reloadable="false"&gt;
        &lt;Resources className="com.xxx.xxx.MultipleDirContext" virtualDocBase="/path/to/another/docbase" /&gt;
    &lt;/Context&gt; 
&lt;/Host&gt;
</pre>

Cette configuration permet d'ajouter un ou des docbases supplémentaires en plus de celui défini. En fait, contrairement à ce que je pouvais penser au départ, cette idée est assez facile en mettre en place. Il suffit de créer une classe MultipleDirContext héritant d'une classe tomcat FileDirContext.
<pre class="prettyprint lang-java">
/**
 * Add some DocBase in tomcat. VirtualDocBase separator is ';'. 
 */
public class MultipleDirContext extends FileDirContext {    
  private String seperator = ";";
  private String virtualDocBase;
  private LinkedHashSet&lt;FileDirContextAdapter&gt; virtualContexts = new LinkedHashSet&lt;FileDirContextAdapter&gt;();
  public MultipleDirContext() {
    super();
  } 
  public MultipleDirContext(Hashtable env) {
    super(env); 
  }
  public void setVirtualDocBase(String virtualDocBase) {
      this.virtualDocBase = virtualDocBase;
      StringTokenizer parser = new StringTokenizer(virtualDocBase, ",");
      while (parser.hasMoreTokens()) {
          FileDirContextAdapter currentContext = new FileDirContextAdapter();
          currentContext.setDocBase(parser.nextToken());
          virtualContexts.add(currentContext); 
     }
  }
  public String getVirtualDocBase() { 
     return virtualDocBase; 
  }  
  public String getSeperator() {
      return seperator;  
  }
  public void setSeperator(String seperator) {
    this.seperator = seperator;
  }
  protected File file(String arg0) {
    File file = super.file(arg0);
    if (file == null) {
        for (FileDirContextAdapter virtualContext : virtualContexts) {
          file = virtualContext.file(arg0);
          if (file != null) {
            return file;
          }
       }
    }
     return file;
  }

  public void setDocBase(String arg0) {
    super.setDocBase(arg0); 
 }
  public void release() {
    super.release();        
    for (FileDirContextAdapter virtualContext : virtualContexts) {
      virtualContext.release();
    }
  }
  public void allocate() {
    super.allocate();
    for (FileDirContextAdapter virtualContext : virtualContexts) {
      virtualContext.setCached(this.isCached());
      virtualContext.setCacheTTL(this.getCacheTTL());
      virtualContext.setCacheMaxSize(this.getCacheMaxSize());
      virtualContext.setCaseSensitive(this.isCaseSensitive());
      virtualContext.setAllowLinking(this.getAllowLinking());
      virtualContext.allocate();
    }
  }
}
</pre>
<br />
<pre class="prettyprint lang-java">
public class FileDirContextAdapter extends FileDirContext {
  public FileDirContextAdapter() {
  }
  public FileDirContextAdapter(Hashtable env) {
    super(env);
  }
  protected File file(String arg0) {
    return super.file(arg0);
  }
}
</pre>
<br />
Avec cette extension, si la ressource n'est pas trouvée dans le docbase par défaut, on itère sur les docbases supplémentaires. Une fois le MultipleDirContext.jar créé, le placer dans apache-tomcat-6.0.14/lib. Cette technique dévrait fonctionner avec tomcat 5.5.x, mais je n'ai pas testé, je travaille que sur tomcat 6 :)

Cette technique est utilisée en production depuis plus d'un an, sans overhead, sur ces sites publiques à fort trafic.

Qu'en pensez vous ?
