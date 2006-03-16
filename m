From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Subject: Re: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT]
Date: Thu, 16 Mar 2006 07:57:40 +0000
Message-ID: <E1FJnMa-0000bW-00@skye.ra.phy.cam.ac.uk>
References: <3ACA40606221794F80A5670F0AF15F840B37A72F@pdsmsx403>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:11250 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1752230AbWCPH5n (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 Mar 2006 02:57:43 -0500
In-Reply-To: Your message of "Thu, 16 Mar 2006 15:28:47 +0800."
             <3ACA40606221794F80A5670F0AF15F840B37A72F@pdsmsx403>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Yu, Luming" <luming.yu@intel.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Tom Seeley <redhat@tomseeley.co.uk>, Dave Jones <davej@redhat.com>, Jiri Slaby <jirislaby@gmail.com>, michael@mihu.de, mchehab@infradead.org, Brian Marete <bgmarete@gmail.com>, Ryan Phillips <rphillips@gentoo.org>, gregkh@suse.de, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, Mark Lord <lkml@rtr.ca>, Randy Dunlap <rdunlap@xenotime.net>, jgarzik@pobox.com, Duncan <1i5t5.duncan@cox.net>, Pavlik Vojtech <vojtech@suse.cz>, Meelis Roos <mroos@linux.ee>

> To verify this, please hack acpi_thermal_active.

Do you mean hack it for now to return without doing anything (like if
'tz' wasn't valid)?  Or do it farther in the function, like by
changing

				result =
				    acpi_bus_set_power(active->devices.
						       handles[j],
						       ACPI_STATE_D0);
to 

				result = 1;

>  Disable active/passive cooling request before suspend.

Do I need to hack acpi_thermal_passive() as well?

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
