---
template: article.jade
title: Scripts GreaseMonkey
date: '2007-01-17T22:35:00.000Z'
author: Olivier
aliases: ['/post/2007/01/17/scripts-greasemonkey/', '/post/2007/01/17/sripts-greasemonkey/', '/post/2007/01/17/sripts-greasemonkey/']
categories: [Uncategorized]
tags: [firefox]
excerpt: "<p>J'ai développé quelques scripts GreaseMonkey simples pour :</p> <ul> <li>horde : recharge la page toutes les xx secondes et</li> <li>del.icio.us : ajoute un lien 'Open All' qui ouvre tous les liens de la pages, et un autre qui ajoute des liens sur des tags (c'est avant que les bundles existes)</li> </ul>"
---

<p>J'ai développé quelques scripts GreaseMonkey simples pour :</p> <ul> <li>horde : recharge la page toutes les xx secondes et</li> <li>del.icio.us : ajoute un lien 'Open All' qui ouvre tous les liens de la pages, et un autre qui ajoute des liens sur des tags (c'est avant que les bundles existes)</li> </ul>
<!--more-->
<p>1. <strong>Ce script recharge la page des mails</strong> pour éviter de prendre la session (si vos n'avez pas droit les droits pour accéder à cette option dans Horde). Il vous reste à adapter les urls.</p> 
<pre class="prettyprint lang-js">
// Horde Reloaded
// version 0.1 BETA!
// 2006-03-06
//
// --------------------------------------------------------------------
//
// This is a Greasemonkey user script.
//

/* Horde Reloaded
*/

// ==UserScript==
// @name          Horde Reloaded
// @namespace     http://www.bazoud.com
// @description   Reload automatic inbox
// @include       https://webmail.[monsite].com/horde/imp/mailbox.php*
// ==/UserScript==

window.setTimeout(doReload, 1000 * 60 * 25);

function doReload() {
        window.location.href="https://webmail.[monsite].com/horde/imp/mailbox.php";
}
</pre> 
<p>2.<strong>Ce script permet de compléter le champ bcc, lorsque vous composez un mail, et de rajouter une signature, à adapter.</strong>
<pre class="prettyprint lang-js">
// Horde Reloaded
// version 0.1 BETA!
// 2006-03-06
//
// --------------------------------------------------------------------
//
// This is a Greasemonkey user script.
//

/* Horde Reloaded
*/

// ==UserScript==
// @name          Horde Reloaded
// @namespace     http://www.bazoud.com
// @description   Reload automatic inbox
// @include       https://webmail.[monsite].com/horde/imp/mailbox.php*
// ==/UserScript==

window.setTimeout(doReload, 1000 * 60 * 25);

function doReload() {
        window.location.href="https://webmail.[monsite].com/horde/imp/mailbox.php";
}
</pre>
<p>3. <strong>Et mon préféré, un script del.icio.us qui permet de rajouter un lien 'Open All'</strong> et quelques liens supplémentaire.</p> 
<pre class="prettyprint lang-js">
// Delicious
// version 0.1
// 2006-04-13
//
// --------------------------------------------------------------------
//

/* Delicious Open All
*/

// ==UserScript==
// @name          Delicious Open All
// @namespace     http://www.bazoud.com
// @description   Open All
// @include       http://del.icio.us/[mesbookmarks]*
// ==/UserScript==
try {
                deliciousLinks = findAllElements('h4', 'class', 'desc');
                link=document.createElement('a');
                linkText=document.createTextNode("Open All");

                link.href="#"; 
                link.addEventListener("click", openAll, false); 
                link.appendChild(linkText); 
                pageDesc = document.getElementById('page-desc');
                // pageDesc.parentNode.insertBefore(link, pageDesc.nextSibling);
                pageDesc.appendChild(link);
                
                // News Java
                linkNewsJava = document.createElement('a');
                linkNewsJavaText=document.createTextNode(" Xxxx xxx");
                linkNewsJava.href="http://del.icio.us/[mesbookmarks]/xxxxx";
                linkNewsJava.appendChild(linkNewsJavaText);
                pageDesc.appendChild(linkNewsJava);

} catch (E) {
        GM_log(E);
}

function findAllElements(tag, attribute, value) {
        var tabLinks = new Array;

        if (!document.getElementsByTagName) return null;

        arr_nodes = document.getElementsByTagName(tag);
        for (j=0, i = 0; i < arr_nodes.length; i++) {

                obj_node = arr_nodes[i];

                if (obj_node.getAttribute(attribute) == value) {

                        tabLinks[j++] = obj_node.firstChild;
                }
        }
        return tabLinks;

}

function openAll() {
        for (i = 0; i < deliciousLinks.length; i++) {
                // alert(deliciousLinks[i]);
                // window.open(deliciousLinks[i]);
                GM_openInTab(deliciousLinks[i]);
        }
}
</pre> 
<p><a href="/public/billets/DeliciousOpenAll.png"><a href="/images/DeliciousOpenAll.png"><img src="/images/DeliciousOpenAll-300x225.png" alt="" title="DeliciousOpenAll" width="300" height="225" class="alignnone size-medium wp-image-80" /></a>. 
<br />
Attention à ne pas ouvrir trop d'onglet en même temps, se limiter à 25, 50.</p>
