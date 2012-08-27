---
template: article.jade
title: USB et Ubuntu
date: '2007-01-18T15:48:00.000Z'
author: Olivier
aliases: ['/post/2007/01/18/usb-et-ubuntu/', '/post/2007/01/18/usb-et-ubuntu/']
categories: [Uncategorized]
tags: [Ubuntu]
excerpt: <p>J'ai résolu mon problème de <a href="/post/2007/01/11/Quelques-details-a-finir">USB (lecteur MP3 Creative Muvo Slim)</a> sous Ubuntu, il fallait connaître la commande magique.</p>
---

<p>J'ai résolu mon problème de <a href="/post/2007/01/11/Quelques-details-a-finir">USB (lecteur MP3 Creative Muvo Slim)</a> sous Ubuntu, il fallait connaître la commande magique.</p>
<!--more-->
<p>La dite commande qu'il fallait quand même dénicher <a href="https://www.redhat.com/archives/fedora-list/2005-March/msg04036.html">ici</a>. En gros, mon lecteur USB est incompatible avec le module ehci-hcd (à moins que ce soit le contraire :)).</p> <p>Pour résumé, si j'ai eu les suivants lorsque je branchais mon lecteur USB :</p> 
<pre class="prettyprint lang-bsh">
% tail -f /var/log/syslog usb 4-2: new high speed USB device using ehci_hcd and address 12 
</pre>
<p>Avec la fameuse commande magique qui permet d'enlever le module ehci-hcd au noyau :</p> 
<pre class="prettyprint bsh">
% sudo modprobe -r ehci-hcd
</pre>
<p>Du coup, tout va mieux :</p> 
<pre class="prettyprint lang-bsh">
% tail -f /var/log/syslog usb 
1-2: new full speed USB device using uhci_hcd and address 7 usb 1-2: configuration #1 chosen from 1 choice usbcore: registered new driver libusual SCSI subsystem initialized Initializing USB Mass Storage driver... scsi0 : SCSI emulation for USB Mass Storage devices usbcore: registered new driver usb-storage USB Mass Storage support registered. usb-storage: device found at 7 usb-storage: waiting for device to settle before scanning usb-storage: device scan complete   Vendor: CREATIVE  Model: MuVo Slim         Rev: 1113   Type:   Direct-Access                      ANSI SCSI revision: 04 SCSI device sda: 2038016 512-byte hdwr sectors (1043 MB) sda: Write Protect is off sda: Mode Sense: 03 00 00 00 sda: assuming drive cache: write through SCSI device sda: 2038016 512-byte hdwr sectors (1043 MB) sda: Write Protect is off sda: Mode Sense: 03 00 00 00 sda: assuming drive cache: write through  sda: sda1 sd 0:0:0:0: Attached scsi removable disk sda sd 0:0:0:0: Attached scsi generic sg0 type 0 FAT: utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive! 
</pre> 
<p>Après une petite dizaine de secondes, une icône apparaît sur le bureau et le gestionnaire de fichier se positionne sur mon usbdisk. Il reste plus qu'à monter mon lecteur USB, /dev/sda1, sur un répertoire. Lorsque je déconnecte mon lecteur :</p> 
<pre class="prettyprint lang-bsh">
% tail -f /var/log/syslog
usb 1-2: USB disconnect, address 7 usb 1-2: new full speed USB device using uhci_hcd and address 8
</pre>

