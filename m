From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT]
Date: Sat, 18 Mar 2006 21:24:04 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC267@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:16936 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932338AbWCRNYL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 18 Mar 2006 08:24:11 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Tom Seeley <redhat@tomseeley.co.uk>, Dave Jones <davej@redhat.com>, Jiri Slaby <jirislaby@gmail.com>, michael@mihu.de, mchehab@infradead.org, Brian Marete <bgmarete@gmail.com>, Ryan Phillips <rphillips@gentoo.org>, gregkh@suse.de, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, Mark Lord <lkml@rtr.ca>, Randy Dunlap <rdunlap@xenotime.net>, jgarzik@pobox.com, Duncan <1i5t5.duncan@cox.net>, Pavlik Vojtech <vojtech@suse.cz>, Meelis Roos <mroos@linux.ee>

>> The short-term proper way could be:
>> 1. add a global variable: acpi_in_suspend.
>> 2. in acpi_pm_prepare:
>>	a.call acpi_os_wait_events_complete()
>> 	b.set acpi_in_suspend = YES.
>>    in acpi_pm_finish :
>> 	set acpi_in_suspend = NO.
>> 3. in acpi_thermal_run:
>> 	if (acpi_in_suspend == YES)
>>		do nothing.
>
>I tested the included diff to implement the above short-term fix.  It
>also hung on the second sleep.  BUT, it's the same reason that the
>utils.c change didn't help: because acpi_thermal_add() was loading
>THM[0267].  After the usual modification to acpi_thermal_add() to have
>it ignore THM[267], the system didn't hang (12 cycles).  Which is
>progress.

Hmm,  probably, you need to do :

4. in acpi_thermal_notify,
	if (acpi_in_suspend == YES)
		do nothing.
