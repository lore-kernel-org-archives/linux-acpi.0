From: Olivier Berger <oberger@ouvaton.org>
Subject: Re: Incorrect ACPI blacklisting of ASUS P4B266 ?
Date: Sat, 25 Apr 2009 21:35:42 +0200
Message-ID: <87ws98r0fl.fsf@olivierberger.com>
References: <87k5691x3y.fsf@olivierberger.com>
	<200904021502.31021.trenn@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpfb1-g21.free.fr ([212.27.42.9]:44988 "EHLO
	smtpfb1-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753177AbZDYThM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 25 Apr 2009 15:37:12 -0400
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 0536D2E28A
	for <linux-acpi@vger.kernel.org>; Sat, 25 Apr 2009 21:37:06 +0200 (CEST)
In-Reply-To: <200904021502.31021.trenn@suse.de> (Thomas Renninger's message of "Thu\, 2 Apr 2009 15\:02\:30 +0200")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>

--=-=-=

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

Following advice from Thomas Renninger, I hereby propose a patch for the
ACPI blacklisting kernel code, that I've successfully applied to kernel
2.6.26-15, that allows ACPI detection on Asus P4B266 mainboards.

Maybe there could be a smarter version that would allow blacklisting for
same mainboards with older BIOS versions than the one I'm using, but I
don't know if/how that'd be possible. So the patch I propose is pretty
obvious.

FYI, here are some reports that mention acpi=force working succesfully
for P4B266 mainboards (in english and german) :

http://forums.fedoraforum.org/showpost.php?p=669615&postcount=5 / http://fedoraforum.org/forum/showpost.php?p=669615&postcount=5
https://lists.ubuntu.com/archives/kernel-bugs/2006-November/023486.html / https://bugs.launchpad.net/linux/+bug/43961/comments/145
http://forum.ubuntuusers.de/topic/automatische-abschaltung/#post-249151
http://www.pc-forum24.de/suse-system-installieren/3031-suse-10-2-laesst-sich-nicht-ausschalten.html#post13729

I hope this won't break things for different BIOS versions than mine,
and that this will on the other hand allow lots of users to benefit from
working ACPI.

Best regards,


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline; filename=p4b266noblacklist.patch

--- linux-2.6-2.6.26/arch/x86/kernel/acpi/boot.c.orig	2009-04-25 18:02:10.000000000 +0200
+++ linux-2.6-2.6.26/arch/x86/kernel/acpi/boot.c	2009-04-25 18:03:01.000000000 +0200
@@ -1106,14 +1106,6 @@
 	 },
 	{
 	 .callback = force_acpi_ht,
-	 .ident = "ASUS P4B266",
-	 .matches = {
-		     DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
-		     DMI_MATCH(DMI_BOARD_NAME, "P4B266"),
-		     },
-	 },
-	{
-	 .callback = force_acpi_ht,
 	 .ident = "ASUS P2B-DS",
 	 .matches = {
 		     DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),

--=-=-=



Thomas Renninger <trenn@suse.de> writes:

> On Saturday 28 March 2009 16:32:49 you wrote:
>> Hi.
>> 
>> There are quite a lot of reports of people having problems managing
>> poweroff of their ASUS P4B266 based systems.
>> 
>> It seems that providing acpi=force as a boot param is quite succesful.
>> 
>> Maybe that should be fixed WRT to the blacklisting... hence reporting
>> as advised in the kernel source (arch/x86/kernel/acpi/boot.c).
>> 
>> I unfortunately couldn't identify the reason why such a blacklisting
>> was setup, as it seems to come from long time ago.
> Maybe acpi was broken at that times and the bug was not in the ASUS BIOS,
> but in the ACPI implementation. Or the BIOS got fixed up.
>
> Why don't you send a patch removing the ASUS from the dmi list and post
> it on linux-acpi@vger.kernel.org
> Best also add a pointer to e.g. a discussion where people state that it
> works better with acpi=force.
>
>
>     Thomas

- -- 
Olivier BERGER 
(OpenPGP: 1024D/B4C5F37F)
http://www.olivierberger.com/weblog/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8+ <http://mailcrypt.sourceforge.net/>

iD8DBQFJ82X6LBigKrTF838RAguPAJ9sPUhnbG7V0XeXn1HLBg+8GGCfFwCgp6Hh
+hRrDc8OZ/K7N6bzYwz7b+8=
=Jv7i
-----END PGP SIGNATURE-----

--=-=-=--
