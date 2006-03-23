From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Subject: Re: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT]
Date: Thu, 23 Mar 2006 14:19:59 -0500
Message-ID: <E1FMVLj-0001D8-Vc@approximate.corpus.cam.ac.uk>
References: <3ACA40606221794F80A5670F0AF15F840B4692FA@pdsmsx403>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpauth08.mail.atl.earthlink.net ([209.86.89.68]:27581 "EHLO
	smtpauth08.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S1751446AbWCWTU3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Mar 2006 14:20:29 -0500
In-Reply-To: Your message of "Thu, 23 Mar 2006 17:10:00 +0800."
             <3ACA40606221794F80A5670F0AF15F840B4692FA@pdsmsx403>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Yu, Luming" <luming.yu@intel.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Tom Seeley <redhat@tomseeley.co.uk>, Dave Jones <davej@redhat.com>, Jiri Slaby <jirislaby@gmail.com>, michael@mihu.de, mchehab@infradead.org, Brian Marete <bgmarete@gmail.com>, Ryan Phillips <rphillips@gentoo.org>, gregkh@suse.de, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, Mark Lord <lkml@rtr.ca>, Randy Dunlap <rdunlap@xenotime.net>, jgarzik@pobox.com, Duncan <1i5t5.duncan@cox.net>, Pavlik Vojtech <vojtech@suse.cz>, Meelis Roos <mroos@linux.ee>

> Does it mean we need to slow down  acpi_ec_intr_read/write ?
> Could you try to insert acpi_os_stall (100)  after  ACPI_DEBUG_PRINT
> statement both in acpi_ec_intr_read/write.

I added that line in those two places.  The result refused to hang with
acpi_debug_layer=0x00100010, but it did hang (on the usual second sleep)
with it set to 0x10.

> Hmmm, then I cannot get the ec access log for hang case?!

It seems difficult, but let's keep trying if you have other ideas for
how to get it.

-Sanjoy

`A society of sheep must in time beget a government of wolves.'
   - Bertrand de Jouvenal
