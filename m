From: Olivier Berger <oberger@ouvaton.org>
Subject: Re: Incorrect ACPI blacklisting of ASUS P4B266 ?
Date: Tue, 28 Apr 2009 19:15:47 +0200
Message-ID: <877i14aed8.fsf@olivierberger.com>
References: <87k5691x3y.fsf@olivierberger.com>
	<200904271218.02906.trenn@suse.de> <87ocuhqpgz.fsf@olivierberger.com>
	<200904281339.15689.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpfb1-g21.free.fr ([212.27.42.9]:50735 "EHLO
	smtpfb1-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762502AbZD1RRj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Apr 2009 13:17:39 -0400
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 4E7327E668B
	for <linux-acpi@vger.kernel.org>; Tue, 28 Apr 2009 19:17:30 +0200 (CEST)
In-Reply-To: <200904281339.15689.trenn@suse.de> (Thomas Renninger's message of "Tue\, 28 Apr 2009 13\:39\:14 +0200")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org

Thomas Renninger <trenn@suse.de> writes:

>> 
>> That would be sad if the current blacklisting wasn't able to do such
>> checks on versions :(
> You could either:
>   1) add a whitelist into the blacklist
>   2) better limit the blacklist
> The first won't break machines, but is ugly.

I suppose some new algorithm would need to be written for that, and no easy
"struct definition" (like what is currently there) will be enough ?

> For the second you must know which BIOS(es) fix the acpi parts to not cause
> regressions and then list all broken BIOS revisions, e.g.:
> 	{
> 	 .callback = force_acpi_ht,
> 	 .ident = "ASUS P4B266",
> 	 .matches = {
> 		     DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
> 		     DMI_MATCH(DMI_BOARD_NAME, "P4B266"),
> 		     DMI_MATCH(DMI_BOARD_VERSION, "ASUS P4B266 ACPI BIOS Revision 1007"),
> 		     },
> 	 },
> 	{
> 	 .callback = force_acpi_ht,
> 	 .ident = "ASUS P4B266",
> 	 .matches = {
> 		     DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
> 		     DMI_MATCH(DMI_BOARD_NAME, "P4B266"),
> 		     DMI_MATCH(DMI_BOARD_VERSION, "ASUS P4B266 ACPI BIOS Revision 1008"),
> 		     },
> 	 },
>
> BTW, the same seem to have happened for the ASUS A7V:
> 	/*
> 	 * Boxes that need ACPI PCI IRQ routing disabled
> 	 */
> 	{
> 	 .callback = disable_acpi_irq,
> 	 .ident = "ASUS A7V",
> 	 .matches = {
> 		     DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC"),
> 		     DMI_MATCH(DMI_BOARD_NAME, "<A7V>"),
> 		     /* newer BIOS, Revision 1011, does work */
> 		     DMI_MATCH(DMI_BIOS_VERSION,
> 			       "ASUS A7V ACPI BIOS Revision 1007"),
> 		     },
> 	 },
>

Well, that lacks some version comparison operator to look clean to
me... which looks far from trivial considering the version formats
probably quite creative ;)

> One could argue that people have to upgrade to the latest BIOS
> and your patch is ok. This is IMO a valid argument, but it could be
> that people with a P4B266-SE board cannot upgrade to version 1010.
> I'd say, better leave the fingers off...

Yup.

>
>> Anyway, I suppose I will follow your advice and try and report people of
>> the acpi=force as I already started to do in
>> http://www.olivierberger.com/weblog/index.php?post/2009/03/28/Proper-power-management-on-Asus-P4B266-mainboard
> Everyone with such problems should easily be able to google the acpi=force
> param for this board then.
>

I'm thinking about some kind of warning message that might be provided
by the kernel.

Currently, the blacklisting issues something like : 
 xxx detected : force use of acpi=ht 

Maybe in some greylisted cases (like such ASUS P4B266), an additional
message may be issued, something like :
 xxx detected : may work with acpi=force (test at own risk)
or something like that ?


Btw, while we're at it, the first message is not so clear to me "force
use of acpi=ht" : I think it could be interpreted as "you may force ACPI
to work by passing acpi=ht" or something like that, as it tends to
indicate that it refers to an 'acpi=' parameter.

Maybe something like "forced 'ht' mode for acpi" or a similar variant
would be less ambiguous (pardon me, I'm not so sure what 'ht' means
here, btw).

Hope this helps,
-- 
Olivier BERGER 
(OpenPGP: 1024D/B4C5F37F)
http://www.olivierberger.com/weblog/
