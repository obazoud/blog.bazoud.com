---
template: article.jade
title: Maven - La complétion et la couleur
date: '2012-06-15T21:30:00.000Z'
author: Olivier
categories: [Uncategorized]
tags: [maven,zsh,bash,oh-my-zsh]
excerpt: Tout ce que vous voulez savoir sur la couleur et la complétion Maven.
---

Si vous utilisez [Maven](http://maven.apache.org) dans un terminal, la ligne de commande peut être fatiguante autant pour les doigts que pour les yeux. Cet article va vous permettre, à travers la complétion et la colorisation du terminal, de vous économiser et améliorer votre productivité.

## La complétion

La complétion permet de taper les lignes de commandes plus aisément à l'aide la touche [TAB]. Et dans le cas de Maven, il affiche les options propres à Maven mais également les plugins. A partir de là, il faut distinguer deux mondes: le bash et zsh :)

### Bash

Il existe le projet [maven-bash-completion](https://github.com/juven/maven-bash-completion), auquel j'ai contribué via quelques pull request. Et comme son nom l'indique, il utilise bash. Ce programme se base sur la déclaration des options, des plugins ainsi que les goals associés. C'est efficace, très rapide mais c'est statique.
En effet, pour chaque plugin que l'on ajoute, il faut déclarer manuellement tous les goals. Cela peut devenir fastidieux.

### Zsh

Passons dans un autre monde, celui de zsh, et en particulier de [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) qui permet de gérer sa configuration zsh et d'avoir pleins de plugins déjà tout fait: [nvm](https://github.com/creationix/nvm), [node](http://nodejs.org/), [git](http://git-scm.com/), ...

Pour rajouter le plugin oh-my-zsh pour Maven , il faut:
- ajouter plugins/mvn/_mvn pour la complétionn, inspiré par le projet [zsh-completions](https://github.com/zsh-users/zsh-completions/blob/master/_mvn)
- activer la complétion avec [plugins/mvn/mvn.plugin.zsh](https://github.com/obazoud/oh-my-zsh/blob/develop/plugins/mvn/mvn.plugin.zsh)
- [activer le plugin maven zsh](https://github.com/obazoud/oh-my-zsh/commit/d6689c5521872a13766a96a525e5d4d82c24832b#zshrc) dans le zshrc
Vous pouvez merger dans votre propre projet oh-my-zsh avec ce [commit](https://github.com/obazoud/oh-my-zsh/commit/d6689c5521872a13766a96a525e5d4d82c24832b).

Dernier point, [activer les plugins maven pour la completion](https://github.com/obazoud/oh-my-zsh/commit/673104753c93f99882c7b7832a45a364b5ebc1af).

Voilà, complétion prête!

Comme l'implémentation bash, cette complétion déclare manuellement les options de maven. Cependant concernant les plugins, il suffit d'ajouter à la liste des plugins, et hop, il utilise. Dans les faits, ça utilise le plugin maven help pour peupler automatiquement le cache de complétion. Par exemple, pour le [plugin Maven Tomcat 6](http://tomcat.apache.org/maven-plugin-2.0-SNAPSHOT/tomcat6-maven-plugin/index.html):

<pre class="prettyprint lang-bsh">
% mvn help:describe -Dplugin=org.apache.tomcat.maven:tomcat6-maven-plugin
...
[INFO] org.apache.tomcat.maven:tomcat6-maven-plugin:2.0-beta-1
...
Name: Apache Tomcat Maven Plugin :: Tomcat 6.x
Description: The Tomcat Maven Plugin provides goals to manipulate WAR
  projects within the Tomcat 6.x servlet container.
...
tomcat6:deploy
  Description: Deploy a WAR to Tomcat.
tomcat6:deploy-only
  Description: Deploy a WAR to Tomcat witjout forking the package lifecycle
tomcat6:exploded
  Description: Deploy an exploded WAR to Tomcat.
...
</pre>

C'est comme cela qu'il va auto découvrir l'ensemble des goals, et en plus cela vous donnera de l'aide.
Petit hic, il faut une connexion Internet la première fois et un petit de patience, mais sinon ça rocks!

Passons à la couleur maintenant.

## La couleur

[Maven-trap](https://github.com/mrdon/maven-trap) est un ensemble d'intercepteurs [Maven](http://maven.apache.org) incluant la colorisation, le mode offline permanent et la prise en charge du format [YAML](http://www.yaml.org/) pour le pom.xml. 

Nous allons installer le jar dans le répertoire boot de maven. Commençons d'abord par cloner le repository Git et lancer la commande d'installation.
<pre class="prettyprint lang-bsh">
% git clone git://github.com/mrdon/maven-trap.git
% mvn clean install
</pre>

Une fois accompli, copions l'artifact dans le répertoire boot de maven.
<pre class="prettyprint lang-bsh">
% cp ~/.m2/repository/org/twdata/maven/trap/maven-trap/0.6-SNAPSHOT/maven-trap-0.6-SNAPSHOT.jar /usr/local/maven/default/boot
</pre>

Dans le shell de lancement de maven, ajouter le jar maven-trap dans le classapth, changer la classe principale par 'org.twdata.maven.trap.Dispatcher'.

<pre class="prettyprint lang-bsh">
% vi /usr/local/maven/default/bin/mvn

156: #CLASSWORLDS_LAUNCHER=org.codehaus.plexus.classworlds.launcher.Launcher
157: CLASSWORLDS_LAUNCHER=org.twdata.maven.trap.Dispatcher

168: #exec "$JAVACMD" \
169: #  $MAVEN_OPTS \
170: #  -classpath "${M2_HOME}"/boot/plexus-classworlds-*.jar \
171: #  "-Dclassworlds.conf=${M2_HOME}/bin/m2.conf" \
172: #  "-Dmaven.home=${M2_HOME}"  \
173: #  ${CLASSWORLDS_LAUNCHER} "$@"
174:
175: exec "$JAVACMD" \
176:   $MAVEN_OPTS \
177:   -classpath "${M2_HOME}"/boot/plexus-classworlds-2.4.jar:"${M2_HOME}"/boot/maven-trap-0.6-SNAPSHOT.jar \
178:   "-Dclassworlds.conf=${M2_HOME}/bin/m2.conf" \
179:   "-Dmaven.home=${M2_HOME}"  \
180:   ${CLASSWORLDS_LAUNCHER} "$@"
</pre>

Reste à activer la couleur.

<pre class="prettyprint lang-bsh">
export MAVEN_COLOR=""
</pre>

Quelques screenshoots:

<a href="/images/maven-color1.png"><img title="maven-color" src="/images/maven-color1.png" /></a>

C'est tout rouge en cas d'erreur.

<a href="/images/maven-color2.png"><img title="maven-color" src="/images/maven-color2.png" /></a>

Mise en évidence du test en erreur.

<a href="/images/maven-color3.png"><img title="maven-color" src="/images/maven-color3.png" /></a>

Et maintenant, Maven c'est beaauuu et productif!!!


