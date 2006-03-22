From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Subject: Re: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT]
Date: Tue, 21 Mar 2006 23:35:07 -0500
Message-ID: <E1FLv3r-00040D-3t@approximate.corpus.cam.ac.uk>
References: <3ACA40606221794F80A5670F0AF15F840B417B9D@pdsmsx403>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpauth04.mail.atl.earthlink.net ([209.86.89.64]:63377 "EHLO
	smtpauth04.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S1750751AbWCVEfc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Mar 2006 23:35:32 -0500
In-Reply-To: Your message of "Wed, 22 Mar 2006 09:30:04 +0800."
             <3ACA40606221794F80A5670F0AF15F840B417B9D@pdsmsx403>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Yu, Luming" <luming.yu@intel.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Tom Seeley <redhat@tomseeley.co.uk>, Dave Jones <davej@redhat.com>, Jiri Slaby <jirislaby@gmail.com>, michael@mihu.de, mchehab@infradead.org, Brian Marete <bgmarete@gmail.com>, Ryan Phillips <rphillips@gentoo.org>, gregkh@suse.de, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, Mark Lord <lkml@rtr.ca>, Randy Dunlap <rdunlap@xenotime.net>, jgarzik@pobox.com, Duncan <1i5t5.duncan@cox.net>, Pavlik Vojtech <vojtech@suse.cz>, Meelis Roos <mroos@linux.ee>

> We can do bisection in EC0.UPDT to find out which statement cause
> hang?

Yes, though see below for why I don't think it'll help no matter what we
find there.

> My assumption is that since Windows works well, then these BIOS code
> should have been tested ok. The only possible excuse for BIOS is that
> Linux is using unnecessary/untested code path for Suspend/resume.  So,
> Eventually, we need to disable unnecessary BIOS call for
> suspend/resume

Maybe we're not collecting the right data in that case.  We know that
commenting out the call to UPDT in THM0.TMP fixes the hang.  But it does
not follow that the osl suspend code should avoid running UPDT.

The hang may work like this: Between boot and sleep, calling UPDT messes
up something in the ec [which is why it takes >1 sleep to cause a hang].
When the system tries to sleep, that something triggers and the ec
hangs.  But it may hang somewhere else than UPDT, and avoiding UPDT
during sleep will not fix it.

However, we do have one more piece of data.  When it hangs, it hangs in
\_SI._SST, because I see that line on successful sleeps (as the last
method before the beep) but not when it hangs (and then I also don't
hear a beep).  There are lots of calls to EC0.XXX, including to
EC0.BEEP, within _SST, which isn't surprising if the EC is the problem.
So perhaps I should bisect in _SST and put in the debug lines there?

Here's another idea, which is a terrible hack.  But there are lots of
lines in the DSDT like
   If (LOr (SPS, WNTF))
which I imagine is saying "If something or if WinNT".  So, what if Linux
pretends to be WinNT (or W98F -- which is another common test), at least
for the 600x?  Maybe those code paths are known to work.

-Sanjoy

`A society of sheep must in time beget a government of wolves.'
   - Bertrand de Jouvenal
