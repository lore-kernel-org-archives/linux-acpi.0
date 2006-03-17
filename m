From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT]
Date: Fri, 17 Mar 2006 15:50:35 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC265@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28245 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S964872AbWCQHvC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Mar 2006 02:51:02 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Tom Seeley <redhat@tomseeley.co.uk>, Dave Jones <davej@redhat.com>, Jiri Slaby <jirislaby@gmail.com>, michael@mihu.de, mchehab@infradead.org, Brian Marete <bgmarete@gmail.com>, Ryan Phillips <rphillips@gentoo.org>, gregkh@suse.de, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, Mark Lord <lkml@rtr.ca>, Randy Dunlap <rdunlap@xenotime.net>, jgarzik@pobox.com, Duncan <1i5t5.duncan@cox.net>, Pavlik Vojtech <vojtech@suse.cz>, Meelis Roos <mroos@linux.ee>

>> How about re-testing dummy _PSV and dummy _AC0 in DSDT?
>
>Just retested and you were right.  This time I managed to get it to
>hang, after many cycles of sleep.sh and "modprobe -r thermal ;
>modprobe thermal" mixed in.
>

Hmmm, may I think this is a problem of:
_TMP ,

It is neither _TMP && (_PSV || _AC0),
nor  _TMP || _PSV || _AC0.

So, please try hack thermal.c by removing calls to _TMP.
And do stress test with Vanilla Kernel, Vanilla Dsdt , just
with hacked thermal.c

Anyway, the clean way to fix your problem might be:

 suspend thermal driver with disabling AML methods invoke
that might cause/ trigger BIOS issues.

Thanks,
Luming
