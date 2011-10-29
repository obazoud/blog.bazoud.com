---
layout: post
title: Ce blog change de technos
date: '2011-11-02T09:00:00.000Z'
author: Olivier
draft: true
categories: [Uncategorized]
tags: [git,github,nodejs,coffeescript,heroku,docpad,twitter]
excerpt: Ce blog change de technos, abandonne wordpress et utiliser [node.js](http://www.nodejs.org) FTW!
---

## Constat

Ce blog fait sa révolution et éjecte [Wordpress](http://wordpress.org). 
Quelques déavantages à l'utilisation de ce moteur de blog m'ont fait franchir le pas:
* Mise à jour régulièrement de la version de [Wordpress](http://wordpress.org) et des divers plugins
* Le hosting sur [free](http://www.free.fr) et la gestion partiel du [.htaccess](http://httpd.apache.org/docs/2.2/howto/htaccess.html)
* Je ne trouvais pas pratique d'être en ligne pour éditer un post (même si des plugins existent)
* Et puis il fallait être dépendent de [MySQL](http://www.mysql.org)

## Node.js à la rescousse

Ce blog est maintenant propulsé par [Docpad](https://github.com/balupton/docpad), un moteur de génération de site static écrit en [node.js](http://www.nodejs.org) et [CoffeeScript](http://jashkenas.github.com/coffee-script). Grace à [ce script magique de migration de Wordpress vers Docpad/Markdown](https://github.com/obazoud/docpad/blob/49-importer-wordpress/bin/wordpress), j'ai pu retrouvé l'ensemble de mes anciens articles (il devrait être inclus dans les prochaines releases de DocPad).
Cette solution me permet :
* d'écrire mes articles en [Markdown](http://en.wikipedia.org/wiki/Markdown)
* d'écrire mes articles offline
* de ne plus dépendre d'une base de données
* de faire du [node.js](http://www.nodejs.org)
* d'écrire des templates [CoffeeScript](http://jashkenas.github.com/coffee-script) qui génére des pages HTML
* d'utiliser [Git](http://git-scm.com/) et [GitHub](https://github.com/)

Pour la mise en place HTML et la CSS, j'ai utilisé [twitter bootstrap](http://twitter.github.com/bootstrap/), un très bon framework à regarder de plus près.
[Docpad](https://github.com/balupton/docpad) est extensible facilement via des plugins grâce à un lifecycle et l'émission d'évenements. [Mes plugins](https://github.com/obazoud/blog.bazoud.com/tree/master/plugins) m'ont permis de gérer les redirections des permlink wordpress, les tags, les archives et la configuration de ce blog.
Malgré tout, j'ai perdu l'optimisation du site pour mobile, le plugin [WPtouch](http://www.bravenewcode.com/store/plugins/wptouch-pro/) était très bien, mais rien d'insurmontable à implémenter.

## Heroku

J'ai déployé sur [Heroku](http://www.heroku.com/) ayant eu quelques problèmes avec les autres providers de cloud. Ce blog tourne aussi sous node.js simplement pour assurer la migration des redirections 301 et la compression gzip. J'ai utilisé les add-ons heroku en particulier [Zerigo DNS](http://www.zerigo.com/managed-dns) pour pouvoir utiliser mon nom de domain.
Le mise en production est assez simple "git push heroku master".

## Le futur

J'espère que cette migration me permettra d'être productif sur mon blog...
Et si vous voyez des boulettes, y a le [tracker de GitHub](https://github.com/obazoud/blog.bazoud.com/issues) ou un [pull request](http://help.github.com/send-pull-requests/) sera apprécié. [Fork me on GitHub](https://www.github.com/obazoud)!







