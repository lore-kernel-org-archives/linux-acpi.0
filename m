From: northy@arcor.de
Subject: How to flash "Message LED" on Asus PC-DL via ACPI?
Date: Tue, 8 May 2007 02:08:26 +0200 (CEST)
Message-ID: <32847781.1178582906744.JavaMail.ngmail@webmail14>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:46100 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S967428AbXEHAI1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 May 2007 20:08:27 -0400
Received: from mail-in-04-z2.arcor-online.net (mail-in-04-z2.arcor-online.net [151.189.8.16])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id DB7461F51AE
	for <linux-acpi@vger.kernel.org>; Tue,  8 May 2007 02:08:26 +0200 (CEST)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-04-z2.arcor-online.net (Postfix) with ESMTP id CB65EABF5C
	for <linux-acpi@vger.kernel.org>; Tue,  8 May 2007 02:08:26 +0200 (CEST)
Received: from webmail14 (webmail14.arcor-online.net [151.189.8.67])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id B780A2DA312
	for <linux-acpi@vger.kernel.org>; Tue,  8 May 2007 02:08:26 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi everyone!=20

I am currently trying to get the "Message LED" flashing on my Asus PC-D=
L mainboard.=20
The LED flashed fine during POST and the Asus manual states, that an OS=
 with ACPI support is needed to take control of the LED.=20

I want to create a script that checks for certain system event's (tempe=
rature, fan failure, etc.) , and if any of them returns with the value =
"true", the LED should flash.=20

In order to get this up and running, I downloaded ACPI4Asus-0.41 (I'm r=
unning kernel 2.6.20, Fedora Core 6), which compiles fine.=20
However, when I run "modprobe asus_acpi", there is no entry in the "dme=
sg" or "/var/log/messages". Running "lsmod" shows, that asus_acpi is lo=
aded though.=20
According to the ACPI4Asus-README, there should be a folder called /sys=
/devices/platform/asus-laptop/. This one does not exist at all.=20

I also tried installing "acpitool", and running "acpitool -m 1", howeve=
r it just gave me the feedback that no Asus ACPI was loaded.=20

Have any of you got some ideas on what could be wrong, or what else I c=
ould try to get the LED to flash?=20

Thank you very much for any ideas/support.
I did try to mail my question to the acpi4asus list, but unfortunately =
that one does not exist any longer.

Regards,=20
Sebastian =20
-

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
