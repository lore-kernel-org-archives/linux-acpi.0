From: Len Brown <lenb@kernel.org>
Subject: Re: Please review power management abstract for LF End User Summit
Date: Wed, 16 Dec 2009 03:46:23 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912160341460.30935@localhost.localdomain>
References: <E87738D94A6AD54789B5B8D1BAEB06CC6EED79B299@azsmsx503.amr.corp.intel.com>
 <alpine.LFD.2.00.0911070025401.4070@localhost.localdomain>
 <4AFEDA59.1060804@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:37283 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbZLPIqY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 03:46:24 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ008HWLPB0P70@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 02:46:24 -0600 (CST)
In-reply-to: <4AFEDA59.1060804@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: "Brown, Len" <len.brown@intel.com>, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>, "Mallick, Asit K" <asit.k.mallick@intel.com>, "Kleen, Andi" <andi.kleen@intel.com>, "'linux-power-mgmt@linux.intel.com'" <linux-power-mgmt@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Sat, 14 Nov 2009, Robert Hancock wrote:

> On 11/06/2009 11:30 PM, Len Brown wrote:
> > Thanks for the suggestions.
> > 
> > final abstract is here:
> > http://events.linuxfoundation.org/eus09hpc4
> > 
> > presentation being constructed here (currently draft 0.5):
> > http://userweb.kernel.org/~lenb/doc/2009-EUS-Server-PM-web/index.html

> I noticed you mention that "power off is a valid power management strategy"..
> indeed you can use WOL to power up again, and Linux can boot quickly,
> unfortunately the boot speed on most server platforms in the BIOS before even
> starting to boot the OS is abysmal, and seems to be getting worse there as it
> improves in desktop systems. Some IBM servers take MINUTES just to initialize
> the RAID controller.. this sort of thing isn't exactly conducive to rapid
> power-up of servers when required.

Agreed, though not all systems have these delays -- choose wisely:-)

> Also, the power-off power usage of some servers isn't great either - some of
> them even have to keep the power supply fans running when powered off,
> otherwise presumably the PS would heat up too much..

ditto.

> Presumably in both of these cases it's because of a lack of demand for better
> behavior (fast power-up on desktops is demanded by Microsoft "designed for
> Windows" specs, and low power-off power usage is required by Energy Star, EU
> standards, etc.)

Yes, I agree think that these external forces are effective in getting
system vendors in line.  Another is formal RFQ's for large purchases
where the customer specifies exactly what they want.

cheers,
-Len

