From: Darren Salt <linux@youmustbejoking.demon.co.uk>
Subject: Re: Oopses and ACPI problems (Linus 2.6.29-rc4)
Date: Tue, 10 Feb 2009 15:15:21 +0000
Message-ID: <5030E7CFF4%linux@youmustbejoking.demon.co.uk>
References: <alpine.LFD.2.00.0902081251090.3048@localhost.localdomain>
 <gemini.ket9w800w44dc0hvg.linux@youmustbejoking.demon.co.uk>
 <20090209234911.GB862@elte.hu> <5030E21460%linux@youmustbejoking.demon.co.uk>
 <20090210150431.GA26798@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:63161 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750869AbZBJPl7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Feb 2009 10:41:59 -0500
In-Reply-To: <20090210150431.GA26798@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Corentin Chary <corentincj@iksaif.net>

I demand that Matthew Garrett may or may not have written...

> On Tue, Feb 10, 2009 at 02:12:44PM +0000, Darren Salt wrote:
>> Reverting this fixes the rfkill oops; things work correctly again. I=
 don't
>> know why this appears to be needed, since things work fine without t=
his
>> patch =E2=80=92 both Fn-F2 and echoing to /sys/class/rfkill/rfkill0/=
state =E2=80=92 even
>> when I start up with init=3D/bin/sh and test directly from that shel=
l.

> If this is BIOS version specific I'm going to be upset, but the gener=
al
> case behaviour is that rfkill only works on the 901 if you either (a)=
 pass
> force=3D1 to pciehp (which you shouldn't) or (b) have native support =
in a
> driver. My /guess/ is that you've got pciehp loaded, and there's some=
 kind
> of awkward race between it and eeepc-laptop.

I have; and yes, pciehp_force=3D1.

As things stand, this is likely to be a problem for anybody using lenny=
 on
Eee hardware and upgrading (on their own) to 2.6.29, given that that
workaround is present in eeepc-acpi-scripts in lenny.

Anyway, removing that option fixes the problem.

>> [long delay between these two lines]
>>   input: ETPS/2 Elantech Touchpad as /class/input/input5
>>   eeepc: Hotkey init flags 0x41
>> (not seen in .28 or .28.1; not checked later .28.*.)

> BIOS bug. There's an explicit delay in the eee bios for some reason, =
and=20
> I haven't found any straightforward way to avoid it.

BIOS bug or no, the fact remains that this is (AFAICS) a regression.

--=20
| Darren Salt    | linux or ds at              | nr. Ashington, | Toon
| RISC OS, Linux | youmustbejoking,demon,co,uk | Northumberland | Army
| + Use more efficient products. Use less.          BE MORE ENERGY EFFI=
CIENT.

  10 PRINT "I used to do this in Dixons": POKE 23692,255: GO TO 10
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
