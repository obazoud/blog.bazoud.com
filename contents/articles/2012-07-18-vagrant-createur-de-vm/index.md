---
template: article.jade
title: Vagrant, créateur de VM
date: '2012-07-18T21:00:00.000Z'
author: Olivier
categories: [Uncategorized]
tags: [vagrant,devops,ruby,git,opschef,puppet,jenkins,sonar,cloud]
excerpt: Mise en oeuvre de Vagrant pour créer des VM VirtualBox, pour l'exemple nous allons en créer une avec Jenkins et Sonar via Chef
---

## Objectifs

A cours d'un projet IT, nous avons besoin de créer des serveurs, une base de données, un [serveur d'intégration continue](http://fr.wikipedia.org/wiki/Int%C3%A9gration_continue),... Les outils de type [Cloud](http://en.wikipedia.org/wiki/Cloud_computing) se démocratisent de plus en plus dans les entreprises pour construire des infrastructures virtuelles rapidemment. Mais le cloud sur la machine du développeur, c'est pour quand ?

Pour illustrer un cas d'utilisation, nous utiliserons [Vagrant](http://vagrantup.com/) pour créer une machine virtuelle (VM) contenant [Jenkins](http://jenkins-ci.org/) et [Sonar](http://www.sonarsource.org).

## Vagrant

[Vagrant](http://vagrantup.com/) est un outil qui permet de configurer des VM [VirtualBox](https://www.virtualbox.org) ([le support d'autres types de VM est en cours](https://twitter.com/mitchellh/status/222936445114003457)) et d'utiliser des "provisioner" pour provisionner la VM créée, plusieurs sont à notre disposition:

* [Shell Provisioner](http://vagrantup.com/v1/docs/provisioners/shell.html) permet d'executer un shell
* [Puppet Server](http://puppetlabs.com) [Provisioning](http://vagrantup.com/v1/docs/provisioners/puppet_server.html) est un outil de gestion de configuration de serveurs 
* [Puppet](http://docs.puppetlabs.com/man/apply.html) [Provisioning](http://vagrantup.com/v1/docs/provisioners/puppet.html) est utilisable sans Puppet server, en mode standalone
* [Chef Server](http://www.opscode.com/chef) [Provisioning](http://vagrantup.com/v1/docs/provisioners/chef_server.html) est un autre outil de gestion de configuration de serveurs
* [Chef Solo](http://wiki.opscode.com/display/chef/Chef+Solo) [Provisioning](http://vagrantup.com/v1/docs/provisioners/chef_solo.html) permet d'exécuter [Chef](http://www.opscode.com/chef) en l'absence d'un [Chef server](http://wiki.opscode.com/display/chef/Chef+Server)

Il y a également la possibilité de [créer aussi votre propre provisoner](http://vagrantup.com/v1/docs/provisioners/others.html).
Dans la suite de l'article, nous utiliserons [Chef Solo](http://wiki.opscode.com/display/chef/Chef+Solo).

## Installation

Installons [VirtualBox](https://www.virtualbox.org) sur une Ubuntu 12.04 en 64 bits:

<pre class="prettyprint lang-bsh">
# wget http://download.virtualbox.org/virtualbox/4.1.18/virtualbox-4.1_4.1.18-78361~Ubuntu~precise_amd64.deb
# dpkg -i virtualbox-4.1_4.1.18-78361~Ubuntu~precise_amd64.deb
</pre>

Puis [Vagrant](http://vagrantup.com/), celui-ci étant écrit en ruby, il s'installe via une gem:

<pre class="prettyprint lang-bsh">
% gem install vagrant
</pre>

Dans [Vagrant](http://vagrantup.com/), nous installons une box [Ubuntu 'Precise Pangolin' 12.04 LTS](http://releases.ubuntu.com/12.04/) en version serveur déjà toute faite (avec par défaut un user 'vagant' qui le droit de faire du sudo). Cette box [Ubuntu](http://www.ubuntu.com) nous servira de base pour créer notre VM. Attention, le fichier pèse ~ 325 Mo, mais c'est à faire qu'une seule fois.

<pre class="prettyprint lang-bsh">
% vagrant box add precise64 http://files.vagrantup.com/precise64.box
</pre>

Finissons le paragraphe "Installation" avec [Git external](https://github.com/dcestari/git-external) (voir l'article [Conversion en masse de projets SVN vers Git](/post/2012-07-11-conversion-en-masse-de-projets-svn-vers-git.html) pour plus de détail) qui permettra de gérer dans [Git](http://git-scm.com/) facilement les recettes [Chef](http://www.opscode.com/chef). Une recette permet d'effectuer des taches (par exemple: installer apache, mysql, ...).

<pre class="prettyprint lang-bsh">
% gem install git-external
</pre>

Il ne reste qu'à provisionner la VM avec les recettes [Jenkins](http://jenkins-ci.org/) et [Sonar](http://www.sonarsource.org).

## Création de la VM

Nous créons un repository [Git](http://git-scm.com/) pour sauvergarder notre tavail:

<pre class="prettyprint lang-bsh">
% git init && git commit -m "First commit" --allow-empty
</pre>

L'initialisation de Vagrant se fait par la commande suivante:

<pre class="prettyprint lang-bsh">
% vagrant init precise64
</pre>

Un fichier Vagrantfile est créé, c'est un fichier de configuration, écrit en [Ruby](http://www.ruby-lang.org/), pour piloter la création de la VM, voici son [contenu initial](https://gist.github.com/3136221). Vous noterez que le nom de la box apparait sous la clé "config.vm.box".

Pour accèlécer le processus de la création de la VM, la mise en place du cache APT et Gem est recommandée, ça évite de télécharger Internet à chaque provisioning. C'est assez simple à mettre en oeuvre, il ne faut pas hésiter! Cela se passe via les "share_folder" (à noter qu'il faut créer ces répertoires sinon Vagrant ne démarre pas!). Un "share_folder" est un répertoire partagée entre votre machine (le host) et la VM (le guest).

Un autre point intéressant, c'est le port forwarding. Il vous permettra de d'utiliser un port sur votre machine (le host) et il sera automatiquement transfèrer vers le port de la VM (le guest). Dans notre cas, nous pourrons utiliser en localhost le port 8080 pour voir [Jenkins](http://jenkins-ci.org/) et le port 9000 pour [Sonar](http://www.sonarsource.org).

<pre class="prettyprint lang-ruby">
Vagrant::Config.run do |config|
  config.vm.box = "precise64"

  config.vm.share_folder "v-apt-cache", "/var/cache/apt/archives", "~/tmp/vagrant/apt/cache"
  config.vm.share_folder "v-gem-cache", "/opt/vagrant_ruby/lib/ruby/gems/1.8", "~/tmp/vagrant/gems/1.8"

  config.vm.forward_port 8080, 8080
  config.vm.forward_port 9000, 9000
  (...)
end
</pre>

Le provisionning Shell, ici je l'ai utilisé pour mettre à jour Chef avec la dernière version.
<pre class="prettyprint lang-ruby">
  config.vm.provision :shell, :path => "update_chef.sh"
</pre>

L'autre "provisoner" est [Chef Solo](http://wiki.opscode.com/display/chef/Chef+Solo). Commençons par récupérer les cookbooks, chouette ils sont tous sur [Github](https://github.com) ;) Go Go [Git external](https://github.com/dcestari/git-external)!

<pre class="prettyprint lang-bsh">
% git external add git://github.com/opscode-cookbooks/apt.git cookbooks/apt
% git external add git://github.com/opscode-cookbooks/java.git cookbooks/java
% git external add git://github.com/opscode-cookbooks/openssl.git cookbooks/openssl
% git external add git://github.com/bryanwb/chef-ark.git cookbooks/ark
% git external add git://github.com/ctrabold/chef-sonar.git cookbooks/sonar
% git external add git://github.com/opscode-cookbooks/git.git cookbooks/git
% git external add git://github.com/obazoud/mysql.git cookbooks/mysql develop
% git external add git://github.com/obazoud/chef-jenkins.git cookbooks/jenkins war
% git external init
</pre>

Cette série de commande clone chaque repository dans le répertoire indiqué.
Il reste à déclarer l'utilisation de ces cookbooks avec **chef.add_recipe** et leurs paramètrages via le **chef.json**:

* Java 7 Oracle avec un mirroir local (10.0.2.2 est la machine host par défaut)
* Jenkins 1.474 avec aussi un mirroir local
* MySQL avec le mot de passe "root" et bindé sur 0.0.0.0
* Sonar 3.1.1 avec un mirroir local, checksum et utilisation de MySQL comme base de données

<pre class="prettyprint lang-ruby">
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks"

    chef.add_recipe "mysql::server"
    chef.add_recipe "git"
    chef.add_recipe "java"
    chef.add_recipe "jenkins"
    chef.add_recipe "sonar"
    chef.add_recipe "sonar::database_mysql"

    chef.json = {
      :java => {
        :install_flavor => "oracle",
        :jdk_version => "7",
        :jdk => {
          "7" => {
            :x86_64 => {
              :url => "http://10.0.2.2/chef/jdk-7u5-linux-x64.tar.gz",
              :checksum  => "2a118ce9350d0c0cbaaeef286d04980df664b215d6aaf7bc1d4469abf05711bf"
            }
          }
        }
      },
      :jenkins => {
        :mirror_url => "http://10.0.2.2/chef/jenkins/war",
        :version    => "1.474",
        :checksum   => "6ff0ce7c0426d12dd46f9a62e0a8b2a503862ac0d0c7ba687034d05fb884966e"
      },
      :mysql => {
        :server_debian_password => "root",
        :server_root_password => "root",
        :server_repl_password => "root",
        :bind_address => "0.0.0.0"
      },
      :sonar => {
        :mirror    => "http://10.0.2.2/chef/sonar",
        :version   => "3.1.1",
        :checksum  => "9606c6f6c79c6b944d9d4a7c5eb6531b",
        :os_kernel => "linux-x86-64",
        :jdbc_url => "jdbc:mysql://localhost:3306/sonar",
        :jdbc_driverClassName => "com.mysql.jdbc.Driver",
        :jdbc_validationQuery => "select 1"
      }
    }
  end
</pre>

La version complète de [Vagrantfile est dans Github](https://github.com/obazoud/vagrant-ci/blob/master/Vagrantfile).

La configuration étant finie, nous pouvons lancer les commandes création de la VM.

## Vagrant up!

Voici quelques commandes utiles [Vagrant](http://vagrantup.com/):

* Supprime l'ancienne VM créée et démarre la VM en effectueant le provionning
  <pre class="prettyprint lang-bsh">
  % vagrant destroy --force
  % vagrant up
  </pre>
* Relance uniquement le provionning (la VM reste up)
  <pre class="prettyprint lang-bsh">
  % vagrant provision
  </pre>
* Se logger en ssh à la VM
  <pre class="prettyprint lang-bsh">
  # Ajout de la clé ssh de vagrant dans votre agent 
  # Le chemin de cette clé dépend de votre installation
  % ssh-add ~/.rvm/gems/ruby-1.8.7-p358/gems/vagrant-1.0.3/keys/vagrant
  % vagrant ssh
  </pre>
* Arrêt correctement la VM
  <pre class="prettyprint lang-bsh">
  % vagrant halt
  </pre>
* Arrêt la VM
  <pre class="prettyprint lang-bsh">
  % vagrant halt --force
  </pre>

Vous pouvez maintenant accèder à:

* [Jenkins](http://jenkins-ci.org/) sur cette url http://localhost:8080
* [Sonar](http://www.sonarsource.org) en tapant http://localhost:9000 (patienter un peu que [Sonar](http://www.sonarsource.org) puisse créer la structure de la base de données ~ 10 à 30s suivant votre machine)

A noter qu'avec le même fichier Vagrantfile, il est possible de créer et de provisonner plusieurs VM.

## Conclusion

Nous avons mis en oeuvre la création d'une machine virtuelle (VM) contenant [Jenkins](http://jenkins-ci.org/) et [Sonar](http://www.sonarsource.org) directement sur le poste du développeur. [Vagrant](http://vagrantup.com/) et [Chef](http://www.opscode.com/chef) permettent de créer et d'installer via des recettes les logiciels souhaitées. [La plupart des recettes existent déjà](https://github.com/opscode-cookbooks) pour les logiciels communs (apt, apache2, nginx, mysql, ntp, python, php, ...). A vous de jouer maintenant!

Tout le code source se trouve sur GitHub: [https://github.com/obazoud/vagrant-ci](https://github.com/obazoud/vagrant-ci).
