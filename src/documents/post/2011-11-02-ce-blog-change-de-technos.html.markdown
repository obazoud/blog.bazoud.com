---
layout: post
title: Ce blog change de technos
date: '2011-11-02T09:00:00.000Z'
author: Olivier
draft: true
categories: [Uncategorized]
tags: [git,nodejs,javascript,coffeescript,heroku,docpad,twitter,phantomjs,vows,bdd,cloud]
excerpt: Ce blog change de technos, abandonne wordpress et utiliser [node.js](http://www.nodejs.org) FTW!
---

## Constat

Ce blog fait sa révolution et remplace [Wordpress](http://wordpress.org). 
Quelques désavantages à l'utilisation de ce moteur de blog m'ont fait franchir le pas:
* De nombreuses mise à jour de la version de Wordpress et des plugins
* Penser à mettre [Wordpress à l'heure d'hiver](http://www.wordpress-fr.net/2008/10/26/noublier-pas-mettre-wordpress-aheure/)...
* Le hosting sur [free](http://www.free.fr) et la gestion partiel du [.htaccess](http://httpd.apache.org/docs/2.2/howto/htaccess.html)
* Je voyais régulièrement dans les logs les tentavies d'accès à phpMyAdmin
* Je ne trouvais pas très pratique d'être en ligne pour écrire un article (même si des plugins existent)
* Et puis il fallait être dépendent de [MySQL](http://www.mysql.org)

## Node.js à la rescousse

Ce blog est maintenant propulsé par [Docpad](https://github.com/balupton/docpad), un moteur de génération de site statique écrit en [node.js](http://www.nodejs.org) et [CoffeeScript](http://jashkenas.github.com/coffee-script). Grâce à [ce script de migration de Wordpress vers Docpad/Markdown](https://github.com/obazoud/docpad/blob/49-importer-wordpress/bin/wordpress), j'ai pu retrouvé l'ensemble de mes anciens articles, il devrait être inclus dans les [prochaines releases de DocPad](https://github.com/balupton/docpad/wiki/Roadmap).
Cette solution me permet :
* d'écrire mes articles en [Markdown](http://en.wikipedia.org/wiki/Markdown)
* d'écrire mes articles offline
* de ne plus dépendre d'une base de données
* de faire du [node.js](http://www.nodejs.org)
* d'écrire des templates [CoffeeScript](http://jashkenas.github.com/coffee-script) qui génère des pages HTML
* d'utiliser [Git](http://git-scm.com/) et [GitHub](https://github.com/)
* blog plus rapide vu que ce n'est que des fichiers HTML maintenant

Pour le look and feel du site, j'ai utilisé [twitter bootstrap](http://twitter.github.com/bootstrap/), un très bon framework à regarder de plus près.

[Docpad](https://github.com/balupton/docpad) est facilement extensible à l'aide de plugins, cela est rendu possible par un lifecycle et à l'émission d'évènements. [Mes plugins](https://github.com/obazoud/blog.bazoud.com/tree/master/plugins) m'ont permis de gérer les redirections des permlinks wordpress, les tags, les archives et la configuration de ce blog.

J'ai écrit des [tests](https://github.com/obazoud/blog.bazoud.com/blob/master/test/index-test.coffee) pour tester ce blog, j'ai utilisé [PhantomJS](http://www.phantomjs.org/), [phantomjs-node](https://github.com/sgentle/phantomjs-node) et [Vows](http://vowsjs.org/). Cette petite stack me permet d'effectuer des tests d'intégration live avec nodejs en mode [BDD](http://en.wikipedia.org/wiki/Behavior_Driven_Development).

Malgré tout, j'ai perdu l'optimisation du site pour mobile, le plugin [WPtouch](http://www.bravenewcode.com/store/plugins/wptouch-pro/) était très bien, mais rien d'insurmontable à implémenter avec Docpad, il permet déjà d'appliquer plusieurs templates sur un même document.

## Heroku

J'ai déployé sur [Heroku](http://www.heroku.com/), ayant eu quelques problèmes avec les autres prestataires de cloud nodejs. Ce blog tourne quand même sous node.js, même si ce sont uniquement des pages HTML simplement pour assurer la migration des redirections 301 et la compression gzip. J'ai utilisé les add-ons heroku en particulier [Zerigo DNS](http://www.zerigo.com/managed-dns) pour pouvoir utiliser mon nom de domain.
Le mise en production est assez simple "git push heroku master" et c'est dans le cloud!

## Le futur

J'espère que cette migration me permettra d'être productif sur mon blog...
Et si vous voyez des boulettes, il y a le [tracker de GitHub](https://github.com/obazoud/blog.bazoud.com/issues) et/ou un [pull request](http://help.github.com/send-pull-requests/).


