From: Bodo Eggert <7eggert@gmx.de>
Subject: Regression: Asrock M3A UCC does not boot without acpi=off or
 pci=noacpi
Date: Wed, 8 Jan 2014 01:12:53 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1401080011480.4231@be10.lrz>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-776041718-1389139974=:4231"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:42802 "EHLO
	mail-in-03.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754069AbaAHAM5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Jan 2014 19:12:57 -0500
Received: from mail-in-19-z2.arcor-online.net (mail-in-19-z2.arcor-online.net [151.189.8.36])
	by mx.arcor.de (Postfix) with ESMTP id 4C693D8D9C
	for <linux-acpi@vger.kernel.org>; Wed,  8 Jan 2014 01:12:56 +0100 (CET)
Received: from mail-in-15.arcor-online.net (mail-in-15.arcor-online.net [151.189.21.55])
	by mail-in-19-z2.arcor-online.net (Postfix) with ESMTP id 48E773F8304
	for <linux-acpi@vger.kernel.org>; Wed,  8 Jan 2014 01:12:56 +0100 (CET)
Received: from be10.7eggert.dyndns.org (95-91-230-165-dynip.superkabel.de [95.91.230.165])
	(Authenticated sender: x7eggert@arcor.de)
	by mail-in-15.arcor-online.net (Postfix) with ESMTPSA id 3A33E1AB523
	for <linux-acpi@vger.kernel.org>; Wed,  8 Jan 2014 01:12:56 +0100 (CET)
Received: from 7eggert (helo=localhost)
	by be10.7eggert.dyndns.org with local-esmtp (Exim 4.72)
	(envelope-from <7eggert@gmx.de>)
	id 1W0glS-00016v-4S
	for linux-acpi@vger.kernel.org; Wed, 08 Jan 2014 01:12:54 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-776041718-1389139974=:4231
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

While upgrading, I found out that my Asrock M3A UCC mainboard is no longer=
=20
compatible with current Linux' acpi. The BIOS version was 1.30, now I=20
upgraded to 1.40 (latest) without a change. (Error description below)

I found no other information from other people using the same mainboard=20
suffering from or solving this bug.

What's the best way to find (and fix) the cause? Debugging using=20
self-compiled kernels (with enabled debugging)? Bisecting? Asking=20
somewhere else?

Error description: The kernel will start to boot, but hang after
"NET: Registered protocol family 1" and before
"ACPI: PCI Interrupt Link [APCF] enabled at IRQ 22" (reached only on 2.6)
My self-compiled kernel with ACPI debugging seems to indicate an infinite=
=20
loop - it spams plenty of messages too fast to read.

Debian oldstable kernel 2.6.32-5-amd64 works fine.
Debian stable    kernel 3.2.0-4(?) needs acpi=3Doff or pci=3Dnoacpi.
Same with Kubuntu 13.10's kernel.
Same with self-compiled kernel 3.12.6.

With acpi=3Doff or pci=3Dnoacpi, the nvidia X11 driver crashes ... but that=
's=20
a different story.

with kind regards
=09Bodo Eggert
--=20
Achtung Outlook-Fehler: Sollte diese Mail nicht korrekt dargestellt werden,
so hat Microsoft mal wieder die "unn=F6tigen" Zeilenumbr=FCche ausgeblendet=
=2E
(Grauer Balken fast ganz oben.)

Mit Rechtsklick->Haken weg beheben Sie dieses Problem.
Dauerhafte L=F6sung:
http://www.pixeljunkie.de/entwickeltes/outlook-tipp-unnoetige-zeilenumbruec=
he-automatisch-entfernen-abschalten/
Oder nutzen Sie einfach ein Email-Programm eines anderen Herstellers.
--8323329-776041718-1389139974=:4231--
