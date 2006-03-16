From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT]
Date: Thu, 16 Mar 2006 16:18:05 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840B37A7EF@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr18.intel.com ([134.134.136.17]:59884 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1752187AbWCPITe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Mar 2006 03:19:34 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Tom Seeley <redhat@tomseeley.co.uk>, Dave Jones <davej@redhat.com>, Jiri Slaby <jirislaby@gmail.com>, michael@mihu.de, mchehab@infradead.org, Brian Marete <bgmarete@gmail.com>, Ryan Phillips <rphillips@gentoo.org>, gregkh@suse.de, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, Mark Lord <lkml@rtr.ca>, Randy Dunlap <rdunlap@xenotime.net>, jgarzik@pobox.com, Duncan <1i5t5.duncan@cox.net>, Pavlik Vojtech <vojtech@suse.cz>, Meelis Roos <mroos@linux.ee>


>> To verify this, please hack acpi_thermal_active.
>
>Do you mean hack it for now to return without doing anything (like if
>'tz' wasn't valid)?  Or do it farther in the function, like by
>changing
>
>				result =
>				    acpi_bus_set_power(active->devices.
>						       handles[j],
>						       ACPI_STATE_D0);
>to 
>
>				result = 1;
>
>>  Disable active/passive cooling request before suspend.

Yes, just return , and DONT do anything could impact to platform.

>
>Do I need to hack acpi_thermal_passive() as well?

Yes.

Please also make sure you have vanilla DSDT,  vanilla Kernel, and just
hacked 
acpi_thermal_active/passive.

I'm waiting for your good news.
If it is the root cause, probably you need to come up with a real patch.
:-)


Thanks,
Luming
