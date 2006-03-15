From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT]
Date: Wed, 15 Mar 2006 09:46:30 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840B32A693@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr20.intel.com ([134.134.136.19]:23274 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S932179AbWCOBrf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Mar 2006 20:47:35 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Tom Seeley <redhat@tomseeley.co.uk>, Dave Jones <davej@redhat.com>, Jiri Slaby <jirislaby@gmail.com>, michael@mihu.de, mchehab@infradead.org, Brian Marete <bgmarete@gmail.com>, Ryan Phillips <rphillips@gentoo.org>, gregkh@suse.de, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, Mark Lord <lkml@rtr.ca>, Randy Dunlap <rdunlap@xenotime.net>, jgarzik@pobox.com, Duncan <1i5t5.duncan@cox.net>, Pavlik Vojtech <vojtech@suse.cz>, Meelis Roos <mroos@linux.ee>

>
>[I've trimmed non-relevant lists (v4l-dvb-maintainer@linuxtv.org,
>video4linux-list@redhat.com, linux-ide@vger.kernel.org,
>linux-input@atrey.karlin.mff.cuni.cz,
>linux-usb-devel@lists.sourceforge.net) from the CC.  Let me know if
>anyone else wants to be trimmed.]
>
>> Could you do bisection to find out which methods or which thermal
>> zone cause trouble?  To do that, you have to hack thermal.c by
>> commenting out some calls of evaluating methods below.  I hope it is
>> easy for you!  :-)
>
>I eventually muddled my way there.  The short story is that I can
>reproduce the hang -- on the FIRST S3 cycle -- when the _TMP method is
>called a few times, just for THM0.  

Excellent!
Could you just comment out _TMP in kernel or in DSDT,
and do several  S3 suspend /resume  Cycles without remove thermal
module, 
I want to make sure we are at right place to drill down. 

Thanks for your  testing reports. It's impressive. :-)

--Luming
