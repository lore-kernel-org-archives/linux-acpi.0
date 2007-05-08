From: northy@arcor.de
Subject: Re: How to flash "Message LED" on Asus PC-DL via ACPI?
Date: Tue, 8 May 2007 19:37:48 +0200 (CEST)
Message-ID: <2282165.1178645868282.JavaMail.ngmail@webmail12>
References: <27928223.1178645635586.JavaMail.ngmail@webmail12> <200705081814.36704.corentincj@iksaif.net> <200705081020.33972.corentincj@iksaif.net> <32847781.1178582906744.JavaMail.ngmail@webmail14> <10028751.1178640321174.JavaMail.ngmail@webmail12>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:56230 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965301AbXEHRht convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 May 2007 13:37:49 -0400
Received: from mail-in-11-z2.arcor-online.net (mail-in-11-z2.arcor-online.net [151.189.8.28])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id 7007617F71B
	for <linux-acpi@vger.kernel.org>; Tue,  8 May 2007 19:37:48 +0200 (CEST)
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net [151.189.21.52])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id 62865347FAB
	for <linux-acpi@vger.kernel.org>; Tue,  8 May 2007 19:37:48 +0200 (CEST)
Received: from webmail12 (webmail12.arcor-online.net [151.189.8.64])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 48584FD716
	for <linux-acpi@vger.kernel.org>; Tue,  8 May 2007 19:37:48 +0200 (CEST)
In-Reply-To: <27928223.1178645635586.JavaMail.ngmail@webmail12>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

> That is strange. I compiled acpi4asus-0.41, and this is the output wh=
en I
> try to modprobe asus-laptop: [root@shadow acpi4asus-0.41]# modprobe
> asus-laptop
> FATAL: Error inserting asus_laptop
> (/lib/modules/2.6.20-1.2948.fc6/acpi/asus-laptop.ko): No such device
> # rmmod asus_acpi
> # modprobe asus_laptop=20
> ;)

"rmmod asus_acpi" ran through fine, however I still can't load the asus=
_laptop/asus-laptop module.
[root@shadow acpi4asus-0.41]# modprobe asus-laptop
=46ATAL: Error inserting asus_laptop
(/lib/modules/2.6.20-1.2948.fc6/acpi/asus-laptop.ko): No such device
[root@shadow acpi4asus-0.41]# modprobe asus_laptop
=46ATAL: Error inserting asus_laptop
(/lib/modules/2.6.20-1.2948.fc6/acpi/asus-laptop.ko): No such device
=20
I tried recompiling the package, but that didn't change anything either=
 :/
 =20
> and can you do that  ? :
> # cat /proc/acpi/dsdt > /tmp/dsdt
> and send me the dsdt ?
=20
I've uploaded the file here:
http://home.arcor.de/northy/dsdt
=20
---
Thanks :)
Regards, Sebastian

Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FC=
nstig
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Spar=
er,
nur  39,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
