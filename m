From: Alok Kataria <akataria@vmware.com>
Subject: Re: acpi based pci gap calculation  - v3
Date: Tue, 22 Jul 2008 15:52:48 -0700
Message-ID: <1216767168.5693.31.camel@alok-dev1>
References: <1216148382.6135.21.camel@alok-dev1>
	 <1216330272.32324.26.camel@alok-dev1> <1216663147.26169.5.camel@alok-dev1>
	 <200807221450.52114.jbarnes@virtuousgeek.org>
Reply-To: akataria@vmware.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-outbound-2.vmware.com ([65.115.85.73]:51939 "EHLO
	smtp-outbound-2.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754762AbYGVWww (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 Jul 2008 18:52:52 -0400
In-Reply-To: <200807221450.52114.jbarnes@virtuousgeek.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Andi Kleen <ak@linux.intel.com>, Ingo Molnar <mingo@elte.hu>, Brown@vger.kernel.org, Len <len.brown@intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, TJ <linux@tjworld.net>

On Tue, 2008-07-22 at 14:50 -0700, Jesse Barnes wrote:
> On Monday, July 21, 2008 10:59 am Alok Kataria wrote:
> > Hi Jesse,
> >
> > Did you get a chance to try this patch on your box. Let me know what are
> > the values you get now.
> 
> Here's the dmesg from my box with the ACPI gap stuff applied.
> 
> I'm still more inclined to TJ's approach though; it should give us a lot more
> space for PCI devices; though you're right that avoiding conflicts is
> definitely important too...

Hi Jesse,

Thanks for sending the log.

In the log that you sent me, please note the following debug messages
-------
E820_DEBUG: Searching for gap between (0x00000000 - 0x100000000)
E820_DEBUG: Found gap starting at 0xbf000000 size 0x40f00000
Allocating PCI resources starting at c0000000 (gap: bf000000:40f00000)
-------

This is the gap that was allocated by walking just the e820_map

With my changes we query the _CRS resource and get following info
------
ACPI_DEBUG start_addr 0xf8000000 gapsize 0x00400000 address_length 0x06b00000
                end_addr is 0xfeb00000
E820_DEBUG: Searching for gap between (0xf8000000 - 0xfeb00000)
E820_DEBUG: Found gap at start starting at 0x100000000 size 0x07f00000
ACPI_DEBUG start_addr 0xbf000000 gapsize 0x07f00000 address_length 0x31000000
                end_addr is 0xf0000000
E820_DEBUG: Searching for gap between (0xbf000000 - 0xf0000000)
E820_DEBUG: Found gap starting at 0xbf000000 size 0x31000000
------

So there are 2 producer regions one from [0xBF000000 - 0xF0000000] and
another from [0xF8000000 - 0xFEB00000]. That means BIOS has reserved the
area from [0xF0000000 - 0xF7FFFFFF] for some other resource.
If you look a little below in the log there is this

----
system 00:01: iomem range 0xf0000000-0xf7ffffff has been reserved
----

So the gap that we had calculated first i.e. from e820_setup_gap did
contain a collision i.e. though a resource was reserved from 
[0xf0000000 - 0xf7ffffff] our gap calculation doesn't take that into
account.  My patch fixes this issue.

So, IMHO this is a BUG and should be fixed. Please let me know your
views. 

Thanks,
Alok

