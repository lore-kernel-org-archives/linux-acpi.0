From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Subject: Re: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT]
Date: Mon, 20 Mar 2006 06:39:48 +0000
Message-ID: <E1FLE3Q-0002RH-00@skye.ra.phy.cam.ac.uk>
References: <3ACA40606221794F80A5670F0AF15F84041AC26C@pdsmsx403>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:8402 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932092AbWCTGjw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Mar 2006 01:39:52 -0500
In-Reply-To: Your message of "Sun, 19 Mar 2006 12:12:09 +0800."
             <3ACA40606221794F80A5670F0AF15F84041AC26C@pdsmsx403>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Yu, Luming" <luming.yu@intel.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Tom Seeley <redhat@tomseeley.co.uk>, Dave Jones <davej@redhat.com>, Jiri Slaby <jirislaby@gmail.com>, michael@mihu.de, mchehab@infradead.org, Brian Marete <bgmarete@gmail.com>, Ryan Phillips <rphillips@gentoo.org>, gregkh@suse.de, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, Mark Lord <lkml@rtr.ca>, Randy Dunlap <rdunlap@xenotime.net>, jgarzik@pobox.com, Duncan <1i5t5.duncan@cox.net>, Pavlik Vojtech <vojtech@suse.cz>, Meelis Roos <mroos@linux.ee>

> I think you need to continue to find out which THMs, which methods
> cause s3 hang when THM0._TMP disabled.

So far I've found that if (with no THM0 loaded) I load exactly one of
THM2, THM6, or THM7, then there's no hang.  Now I am looking for which
combinations of the THM[0267] zones cause the problem.

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
