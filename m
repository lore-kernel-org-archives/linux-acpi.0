From: northy@arcor.de
Subject: Re: How to flash "Message LED" on Asus PC-DL via ACPI?
Date: Tue, 8 May 2007 18:05:21 +0200 (CEST)
Message-ID: <10028751.1178640321174.JavaMail.ngmail@webmail12>
References: <200705081020.33972.corentincj@iksaif.net> <32847781.1178582906744.JavaMail.ngmail@webmail14>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:58396 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934788AbXEHQFW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 May 2007 12:05:22 -0400
In-Reply-To: <200705081020.33972.corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: corentincj@iksaif.net
Cc: linux-acpi@vger.kernel.org

> Le Tuesday 08 May 2007 02:08:26 northy@arcor.de, vous avez =E9crit :=20
> > Hi everyone!=20
>=20
> > run "modprobe asus_acpi", there is no entry in the "dmesg" or=20
> modprobe asus-laptop=20
> asus_acpi is the old driver.=20

That is strange. I compiled acpi4asus-0.41, and this is the output when=
 I try to modprobe asus-laptop:=20
[root@shadow acpi4asus-0.41]# modprobe asus-laptop=20
=46ATAL: Error inserting asus_laptop (/lib/modules/2.6.20-1.2948.fc6/ac=
pi/asus-laptop.ko): No such device=20

but modprobe asus_acpi seems to work fine (if you disregard the missing=
 dmesg output)=20

[root@shadow acpi4asus-0.41]# modprobe asus_acpi=20
[root@shadow acpi4asus-0.41]#=20


> Can you send your dsdt ?=20
>=20
> Thanks=20
>=20
>=20
> --=20
> CHARY 'Iksaif' Corentin=20
> http://xf.iksaif.net=20
>=20

sent to your e-mail address.=20
Thanks for your help!=20
--

Sebastian Prochnow

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
