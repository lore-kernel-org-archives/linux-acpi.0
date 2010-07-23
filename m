From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: swiotlb detection should be memory hotplug aware ?
Date: Fri, 23 Jul 2010 10:59:45 -0400
Message-ID: <20100723145945.GA31857@phenom.dumpdata.com>
References: <20100721135750Z.fujita.tomonori@lab.ntt.co.jp>
 <1279732414.10874.6.camel@ank32.eng.vmware.com>
 <20100722084413I.fujita.tomonori@lab.ntt.co.jp>
 <20100722090329O.fujita.tomonori@lab.ntt.co.jp>
 <1279823680.31733.20.camel@ank32.eng.vmware.com>
 <20100723142208.GA4008@phenom.dumpdata.com>
 <4C49A83C.8070203@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:43262 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757709Ab0GWPAK (ORCPT
	<rfc822;<linux-acpi@vger.kernel.org>>);
	Fri, 23 Jul 2010 11:00:10 -0400
Content-Disposition: inline
In-Reply-To: <4C49A83C.8070203@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: Alok Kataria <akataria@vmware.com>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, "lenb@kernel.org" <lenb@kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Petr Vandrovec <petr@vmware.com>

On Fri, Jul 23, 2010 at 04:33:32PM +0200, Andi Kleen wrote:
> 
> >I thought SRAT has NUMA affinity information - so for example my AMD
> >desktop box has that, but it does not support hotplug capability.
> >
> >I think first your 'hotplug_possible' code needs to be more specific -
> >not just check if SRAT exists, but also if there are swaths of memory
> >that are non-populated. It would also help if there was some indication
> >of whether the box truly does a hardware hotplug - is there a way to do
> >this?
> 
> The SRAT declares hotplug memory ranges in advance. And Linux
> already uses this
> information in the SRAT parser (just the code for doing this is a
> bit dumb, I have a rewrite
> somewhere)
> 
> The only drawback is that some older systems claimed to have large
> hotplug memory ranges
> when they didn't actually support it. So it's better to not do
> anything with a lot
> of overhead.
> 
> So yes it would be reasonable to let swiotlb (and possibly other
> code sizing itself
> based on memory) call into the SRAT parser and check the hotplug ranges too.
> 
> BTW longer term swiotlb should be really more dynamic anyways and grow
> and shrink on demand. I attempted this some time ago with my DMA

I was thinking about this at some point. I think the first step is to 
make SWIOTLB use the debugfs to actually print out how much of its
buffers are used - and see if the 64MB is a good fit.

The shrinking part scares me - I think it might be more prudent to first
explore on how to grow it. The big problem looks to allocate a physical
contiguity set of pages. And I guess SWIOTLB would need to change from
using one big region to something of a pool system?

> allocator patchkit,
> unfortunately that didn't go forward.

I wasn't present at that time so I don't know what the issues were - you
wouldn't have a link to LKML for this?
